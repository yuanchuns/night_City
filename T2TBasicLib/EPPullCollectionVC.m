//
//  EPPullCollectionVC.m
//  T2TBasicLib
//
//  Created by nextone on 15/9/19.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EPPullCollectionVC.h"
#import "T2TView.h"
@interface EPPullCollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate,RefreshControlDelegate>

@end

@implementation EPPullCollectionVC
-(void)loadView{

    self.isHaveHeadView = NO;
    self.isHaveFootView = YES;
    
}

- (void)dealloc{
    
    NSLog(@"EPullNewTableVC dealloc");
    self.arrData = nil;
    self.control = nil;
}

-(void)navBackAction:(UIBarButtonItem *)backBar
{
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (kIsIOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.control = [[RefreshControl alloc] initWithScrollView:self.collectionView delegate:self];
    self.control.topEnabled = YES;
    self.control.bottomEnabled = YES;
    if (kIsIOS7) {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
}
-(void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction{    
    if (direction == RefreshDirectionTop) {
        [self performSelector:@selector(startScrPullDownRefresh) withObject:nil afterDelay:1];
    }else{
        [self performSelector:@selector(startScrPullUpLoadMore) withObject:nil afterDelay:1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public
-(void)startScrPullUpLoadMore{
    
}
//开始下拉刷新
-(void)startScrPullDownRefresh{
    
}


-(void)setIsNotMore:(BOOL)isNotMore{
    
    _isNotMore = isNotMore;
    self.control.isReachEnd = isNotMore;
}
- (void)startPullDownRefreshing{
    [self.control startRefreshingDirection:RefreshDirectionTop];
}
- (void)endPullDownRefreshing{
    [self.control finishRefreshingDirection:RefreshDirectionBottom withIsNetData:nil];
}

- (void)endPullUpLoading{
    [self.control finishRefreshingDirection:RefreshDirectionTop withIsNetData:nil];
}


#pragma mark - CLLRefreshHeadControllerDelegate
- (void)beginPullDownRefreshing{
    
    [self performSelector:@selector(startScrPullDownRefresh) withObject:nil afterDelay:1];
}

- (void)beginPullUpLoading{
    
    [self performSelector:@selector(startScrPullUpLoadMore) withObject:nil afterDelay:1];
}
/**
 *  2、UIScrollView的控制器是否保留iOS7新的特性，意思是：tablView的内容是否可以显示导航条后面
 *
 *  @return 如果不实现该delegate方法，默认是不支持的
 **/
- (BOOL)keepiOS7NewApiCharacter{
    if (!self.navigationController)
        return NO;
    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
    return keeped;
}

/**
 * 3、是否显示 上拉更多视图
 * @return 如果不实现该delegate方法，默认是没有更多
 **/
- (BOOL)hasRefreshFooterView{
    
    return self.isHaveFootView;
}

-(BOOL)hasRefreshHeaderView{
    
    return self.isHaveHeadView;
}

#pragma mark - Table view data source

-(void)viewDidLayoutSubviews
{
    if ([self.collectionView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.collectionView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([self.collectionView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.collectionView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
#pragma mark - colletionViewDelegate

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenWidth-20)/2+2.5, 272.0);
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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
