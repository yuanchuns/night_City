//
//  MGChangeHeadImaVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/18.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGChangeHeadImaVc.h"
#import "MGImavHeadCell.h"
#import "AFNetworking.h"
#import "T2TBtnActionSheet.h"
#import "UIImage+Scale.h"
#import <AVFoundation/AVFoundation.h>
@interface MGChangeHeadImaVc ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) NSArray *arrIma;
@property (nonatomic, strong) UIImage *curIma;

@end

@implementation MGChangeHeadImaVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"头像";
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setCollectionViewLayout:layOut];
    
    [self.collectionView registerNib:[UINib nibWithNibName:MGImavHeadCellClassName bundle:nil] forCellWithReuseIdentifier:MGImavHeadCellClassName];
    
    self.arrIma = @[@"photo1.jpg",@"photo2.jpg",@"photo3.jpg",@"photo4.jpg",@"photo5.jpg",@"photo6.jpg",
                    @"photo7.jpg",@"photo8.jpg",@"photo9.jpg"];
    MGUserModel *model = [MGUserModel shareMGUserModel];
    
    [self.imavHead sd_setImageWithURL:[NSURL URLWithString:getImaUrlWithName(model.loginName)] placeholderImage:kDefaultHeadImg];
    
    [self.btnUpload setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#c2c2c2"]] forState:UIControlStateNormal];
    
    self.imavHead.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapImavHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionImavHead)];
    [self.imavHead addGestureRecognizer:tapImavHead];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)actionImavHead {

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    sheet.delegate = self;
    [sheet showInView:self.view];

    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    if (buttonIndex == 1) {
       
            pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
            kAlter(@"提示", @"请在iPhone的\"设置-隐私-相册\"选项中允许百年基业访问你的相册");
            //        [self navBackAction:nil];
            return;
        }
        pic.delegate = self;
        [self.navigationController presentViewController:pic animated:YES completion:nil];
        
    } else if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
       
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            kAlter(@"提示", @"请在iPhone的\"设置-隐私-相机\"选项中允许百年基业访问你的相机");
            return;
        }
        pic.sourceType = UIImagePickerControllerSourceTypeCamera;
        pic.delegate = self;
        [self.navigationController presentViewController:pic animated:YES completion:nil];
    }
    
   

}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    
     UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    self.curIma = [image unProportionScaleToSize:CGSizeMake(150, 150)];
    [self.btnUpload setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#46bbf0"]] forState:UIControlStateNormal];
    self.imavHead.image = self.curIma;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

     [picker dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)actionBtnSave:(id)sender {
    
    if (self.curIma) {
     
        
        
        UIImage *image= self.curIma;
        if (image) {
            
            
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *strUrl = [NSString stringWithFormat:kMGDefaultURL,@"appManage!uploadPhoto.action",@""];
            [[AFHTTPRequestOperationManager manager] POST:strUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
//                MGUserModel *model = [MGUserModel shareMGUserModel];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                
                [formData appendPartWithFileData:imageData name:@"image" fileName:fileName mimeType:@"image/jpeg"];
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dic = [operation.responseString objectFromJSONString];
                T2TResponse *res = [[T2TResponse alloc] initWithDic:dic];
//
                if (res.code == kMGOkStatuCode) {
                    
                    [self headImaIsChangeWithHub:hub];
                    
                } else {
                [T2TView showFailHUDWithHUD:hub text:@"修改失败"];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [T2TView showFailHUDWithHUD:hub text:@"修改失败"];
            }];
            
            
        }

    }
    
}


- (void)headImaIsChangeWithHub:(MBProgressHUD *)hub {

    [[SDImageCache sharedImageCache] cleanDisk];
    [self clearCacheWithFinishBlock:^{
     [T2TView showOKHUDWithHUD:hub test:@"修改成功"];
        [self performSelector:@selector(navBackAction:) withObject:nil afterDelay:1];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMGChangeHeadImaSuccessNotificationName object:nil];
    }];
    
}

-(void)clearCacheWithFinishBlock:(T2TBasicBlock)finishBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *ay_filePathInCaches = [[NSFileManager defaultManager] subpathsAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSAllDomainsMask, YES) firstObject]];
        for (NSString *filePath in ay_filePathInCaches) {
            [[NSFileManager defaultManager]removeItemAtPath:kFilePathAtCachWithName(filePath) error:nil];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(finishBlock)finishBlock();
        });
    });
    
}

#pragma mark - collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.arrIma.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MGImavHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MGImavHeadCellClassName forIndexPath:indexPath];
    cell.imavHead.image = kImaWithImaName(self.arrIma[indexPath.row]);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake((kScreenWidth - 40)/3, (kScreenWidth - 40)/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    self.curIma = kImaWithImaName(self.arrIma[indexPath.row]);
     [self.btnUpload setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#46bbf0"]] forState:UIControlStateNormal];
    self.imavHead.image = kImaWithImaName(self.arrIma[indexPath.row]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
