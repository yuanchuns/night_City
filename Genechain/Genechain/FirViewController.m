//
//  FirViewController.m
//  Genechain
//
//  Created by nextone on 15/9/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "FirViewController.h"
#import "FirCollCell.h"
@interface FirViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *arrData;
@end

@implementation FirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"热门",@"广场",@"关注",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame =CGRectMake(0.0f, 0.0f, 150.0f, 30.0f);
    [segmentedControl addTarget:self action:@selector(SelectbuttonAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.layer.borderWidth = 0.0;
    segmentedControl.selectedSegmentIndex=0;
    segmentedControl.tintColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    segmentedControl.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = segmentedControl;
    
    
    
    self.navigationItem.leftBarButtonItem = nil;
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayOut];
    self.collectionView.backgroundColor =[UIColor colorWithRed:0.14f green:0.16f blue:0.17f alpha:1.00f];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:MGHomeItemCellReuseRedifilerAndName bundle:nil] forCellWithReuseIdentifier:MGHomeItemCellReuseRedifilerAndName];

    // Do any additional setup after loading the view from its nib.
}

-(void)SelectbuttonAction:(UISegmentedControl *)seg{
    NSInteger Index = seg.selectedSegmentIndex;
    switch (Index) {
            
        case 0:

            break;
            
        case 1:
            
            break;
            
        case 2:
            
            break;
            
        default:
            
            break;
            
    }

}

#pragma mark - dataSoure

- (NSString *)getRequestUrlStr{
    //http://223.4.94.140:8091/pm/appTask!p201MyTaskList.action?word={"status":{"userName":"伍然","beanName":"status","parameter":"2","ver":"1.0.0","sessionId":"C9C5F778A2419EE36C2EACA9BD4B13D8","loginName":"wuran"},"object":{"pageNo":1,"clientName":""}}
    //    NSString *indexStr = [NSString stringWithFormat:@"%ld",self.curIndex];
    //  http://210.14.73.175:7912/API/Video/GetHotVideo?ReqMsg={"PageIndex":0,"PageSize":16} HTTP/1.1

    NSString *str = [NSString stringWithFormat:kMGDefaultURL,[@{@"ReqMsg":@{@"PageIndex":@(0),@"PageSize":@(16)}} JSONString]];
    return str;
}

- (void)handleContentResponse:(T2TResponse *)content{
    
    if ([content.list isKindOfClass:[NSArray class]] && content.code == kMGOkStatuCode) {
        
    NSLog(<#NSString *format, ...#>)
                for (NSDictionary *dic in content.list) {
            //            MGMineTaskModel *model = [[MGMineTaskModel alloc] initWithDic:dic];
            //            [self.arrData addObject:model];
        }
    }
}

#pragma mark - colletionViewDelegate

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FirCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MGHomeItemCellReuseRedifilerAndName forIndexPath:indexPath];
    
    return cell;
    
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenWidth-20)/2+2.5, 262.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}
//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 5,5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - textFiledDelgate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - privateFunc
-(void)navBackAction:(UIBarButtonItem *)backBar
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.35;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
