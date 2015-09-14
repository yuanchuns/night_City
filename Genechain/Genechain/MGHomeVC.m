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
#import "FirViewController.h"
#import "SecViewController.h"
#import "ThirViewController.h"
#import "FourViewController.h"
#import "FirViewController.h"
#import "FivViewController.h"

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
    
//    
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
    
  
       
    [self initializeSecheduleTab];

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
   
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



- (void)initializeSecheduleTab{
    FirViewController *msvc = [[FirViewController alloc] init];
    T2TNavController *msNav = getNavWithVc(msvc);
    
    SecViewController *mvc = [[SecViewController alloc] init];
    T2TNavController *mNav = getNavWithVc(mvc);
    
    ThirViewController *mtvc = [[ThirViewController alloc] init];
    T2TNavController *mtNav = getNavWithVc(mtvc);
    
    fourViewController *fourVc = [[fourViewController alloc] init];
    T2TNavController *FourNav = getNavWithVc(fourVc);
    
    
    FivViewController *fiveVc = [[FivViewController alloc] init];
    T2TNavController *FiveNav = getNavWithVc(fiveVc);

    
    
    SSTabBarImage *tabBarImg1 =
    [[SSTabBarImage alloc]initWithImageNames:@[@"TabNormal0",@"TabSelected0"]];
    SSTabBarImage *tabBarImg2 =
    [[SSTabBarImage alloc]initWithImageNames:@[@"TabNormal1",@"TabSelected1"]];
    SSTabBarImage *tabBarImg3 =
    [[SSTabBarImage alloc]initWithImageNames:@[@"takePic_normal",@"takePic_pressed"]];
    SSTabBarImage *tabBarImg4 =
    [[SSTabBarImage alloc]initWithImageNames:@[@"TabNormal2",@"TabSelected2"]];
    
    SSTabBarImage *tabBarImg5 =
    [[SSTabBarImage alloc]initWithImageNames:@[@"TabNormal3",@"TabSelected3"]];
    
    MGSecheduleHomeVC *tab = [[MGSecheduleHomeVC alloc] initWithViewControllers:@[msNav,mNav,mtNav,FourNav,FiveNav] imageArray:@[tabBarImg1,tabBarImg2,tabBarImg3,tabBarImg4,tabBarImg5] titleArray:@[@"",@"",@"",@"",@""]];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.35;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"reveal";
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController presentViewController:tab animated:NO completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*******************抓取轮播图数据
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
*****************/


@end
