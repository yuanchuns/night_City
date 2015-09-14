//
//  MGHomeVC.m
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGHomeVC.h"
#import "MGLoginVC.h"
#import "EImavCell.h"
#import "MGHomeItemCell.h"
#import "MGSecurityHomeVc.h"
#import "MGSecheduleHomeVC.h"
#import "MGTestHomeVC.h"
#import "MGToolHomeVC.h"
#import "MGHomeImaModel.h"
#import "MGWebVc.h"
@interface MGHomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,EAutoScrollView>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *arrTitles;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) EImavCell *cellImaHead;
@end

@implementation MGHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.navigationItem.leftBarButtonItem = nil;
    
    
//    self.cellImaHead = [[EImavCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    self.cellImaHead.frame = CGRectMake(0, 0, kScreenWidth, 128);
//    self.cellImaHead.autoScr.delegate = self;
//    __weak typeof(self) weak = self;
//    [self.cellImaHead.autoScr setScorllIndexBlock:^(NSUInteger index) {
//        
//        if (index < weak.arrData.count) {
//            MGHomeImaModel *model = weak.arrData[index];
//            weak.cellImaHead.lblInfo.text = model.describe;
//            weak.cellImaHead.control.currentPage = index;
//        }
//        
//    }];
//    [self.view addSubview:self.cellImaHead];
    
  
    
//    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.cellImaHead.bottom, kScreenWidth, kScreenHeight-self.cellImaHead.bottom - kNavBarHeight) collectionViewLayout:flowLayOut];
//    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
//    self.collectionView.dataSource = self;
//    self.collectionView.delegate = self;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.showsVerticalScrollIndicator = NO;
//    self.collectionView.scrollEnabled = NO;
//    [self.view addSubview:self.collectionView];
//    [self.collectionView registerNib:[UINib nibWithNibName:MGHomeItemCellReuseRedifilerAndName bundle:nil] forCellWithReuseIdentifier:MGHomeItemCellReuseRedifilerAndName];
//    
//    self.arrTitles = @[@"安全设置",@"日程",@"工具",@"测评",@"费用归属"];
//    [self requestData];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kMGLoginSuccessNotification object:nil];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headImaIsChange) name:kMGChangeHeadImaSuccessNotificationName object:nil];
//[self headImaIsChange];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
   
}

- (void)headImaIsChange {

    UIImageView *imavHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:imavHead];
    MGUserModel *model = [MGUserModel shareMGUserModel];
    [imavHead sd_setImageWithURL:[NSURL URLWithString:getImaUrlWithName(model.loginName)] placeholderImage:[UIImage imageNamed:kMGHeadImaName]];
    self.navigationItem.leftBarButtonItem = leftBar;
}



- (void)requestData{
    
    static BOOL loding  = NO;
    if (loding) {
        return;
    }
    self.arrData = [NSMutableArray array];
    MGUserModel *model = [MGUserModel shareMGUserModel];
    NSMutableDictionary *dicRequest = [NSMutableDictionary dictionaryWithDictionary:MGGetStausDic()];
    [dicRequest setObject:kUnNilStr(model.userName) forKey:@"userName"];
    [T2THttpManager getWithUrl:[NSString stringWithFormat:kMGDefaultURL,kMGHomeImaUrl,[@{@"status":dicRequest} JSONString]] success:^(T2TResponse *responseObject) {
        if (responseObject.code == kMGOkStatuCode) {
            for (NSDictionary *dicInfo in responseObject.list) {
                MGHomeImaModel *modelIma = [[MGHomeImaModel alloc] initWithDic:dicInfo];
                [self.arrData addObject:modelIma];
            }
            self.cellImaHead.control.numberOfPages = self.arrData.count;
            [self.cellImaHead.autoScr reloadBannerWithData:self.arrData];
        }
        
    } failure:^(id error) {
        
    } otherHttpHeader:MGGetOtherHttpHear()];
}

#pragma mark - escrDelegate

-(void)tapIndex:(NSUInteger)index{
    
    if (self.arrData.count < index) {
        return;
    }
  MGHomeImaModel *model = self.arrData[index];
    MGWebVc *wvc = [MGWebVc getMGWebView];
    wvc.url = model.url;
    wvc.title = model.describe;
    [self.navigationController pushViewController:wvc animated:YES];
}

#pragma mark - colletionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.arrTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MGHomeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MGHomeItemCellReuseRedifilerAndName forIndexPath:indexPath];
    cell.lblTitle.text = self.arrTitles[indexPath.row];
    NSString *imaUrl = [NSString stringWithFormat:@"main_grid_module%ld",indexPath.row+1];
    cell.imavHead.image = kImaWithImaName(imaUrl);
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((kScreenWidth-2*15-20)/3, 80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 15;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 15;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row != 1 && indexPath.row != 2) {
        NSArray *arrVc = @[@"MGSecurityHomeVc",@"",@"MGToolHomeVC",@"MGTestHomeVC",@"workSpaceViewController"];
        Class cls = NSClassFromString(arrVc[indexPath.row]);
        UIViewController *vc = [[cls alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        //[self initializeToolTab];
    }else {
        [self initializeSecheduleTab];
    }
}

- (void)initializeToolTab{
    MGToolWebVc *msvc = [[MGToolWebVc alloc] init];
    msvc.url = kMGToolFirstTabUrl;
    msvc.title = @"携程商旅";
    T2TNavController *msNav = getNavWithVc(msvc);
    
    MGToolWebVc *mvc = [[MGToolWebVc alloc] init];
    mvc.url = kMGToolSecondTabUrl;
    mvc.title = @"滴滴打车";
    T2TNavController *mNav = getNavWithVc(mvc);
    
    MGToolWebVc *mtvc = [[MGToolWebVc alloc] init];
    mtvc.url = kMGToolThirdTabUrl;
    mtvc.title = @"快递服务";
    T2TNavController *mtNav = getNavWithVc(mtvc);
    
    SSTabBarImage *tabBarImg1 =
    [[SSTabBarImage alloc]initWithImageNames:@[@"tools_ctrip",@"tools_ctrip"]];
    SSTabBarImage *tabBarImg2 =
    [[SSTabBarImage alloc]initWithImageNames:@[@"tools_didi",@"tools_didi"]];
    SSTabBarImage *tabBarImg3 =
    [[SSTabBarImage alloc]initWithImageNames:@[@"tools_express",@"tools_express"]];
    
    MGToolHomeVC *tab = [[MGToolHomeVC alloc] initWithViewControllers:@[msNav,mNav,mtNav] imageArray:@[tabBarImg1,tabBarImg2,tabBarImg3] titleArray:@[@"携程商旅",@"滴滴打车",@"快递服务"]];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.35;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"reveal";
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController presentViewController:tab animated:NO completion:nil];
    
}


- (void)initializeSecheduleTab{
//    MGMineScheduleVc *msvc = [[MGMineScheduleVc alloc] init];
//    T2TNavController *msNav = getNavWithVc(msvc);
//    
//    MGMangerScheduleVc *mvc = [[MGMangerScheduleVc alloc] init];
//    T2TNavController *mNav = getNavWithVc(mvc);
//    
//    MGMineTaskVc *mtvc = [[MGMineTaskVc alloc] init];
//    T2TNavController *mtNav = getNavWithVc(mtvc);
//    
//    SSTabBarImage *tabBarImg1 =
//    [[SSTabBarImage alloc]initWithImageNames:@[@"schedule_tab1_normel",@"schedule_tab1_focus"]];
//    SSTabBarImage *tabBarImg2 =
//    [[SSTabBarImage alloc]initWithImageNames:@[@"kabao",@"kabao_h"]];
//    SSTabBarImage *tabBarImg3 =
//    [[SSTabBarImage alloc]initWithImageNames:@[@"wode",@"wode_h"]];
//    
//    MGSecheduleHomeVC *tab = [[MGSecheduleHomeVC alloc] initWithViewControllers:@[msNav,mNav,mtNav] imageArray:@[tabBarImg1,tabBarImg2,tabBarImg3] titleArray:@[@"我的日程",@"日程管理",@"我的任务"]];
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.35;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"reveal";
//    animation.subtype = kCATransitionFromRight;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self.navigationController presentViewController:tab animated:NO completion:nil];
    
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
