//
//  EPullNewTableVC.m
//  T2TBasicLib
//
//  Created by mark on 15/1/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EPullNewTableVC.h"
#import "T2TView.h"
@interface EPullNewTableVC ()<RefreshControlDelegate,UITableViewDataSource,UITableViewDelegate>
//@property(nonatomic,strong)CLLRefreshHeadController *refreshHead;

@end


@implementation EPullNewTableVC


-(void)loadView{

    [super loadView];
    
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
    if (kIsIOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    [self.tableView setSeparatorColor:[UIColor colorWithHexString:@"#dbdbdb"]];
    self.navigationItem.leftBarButtonItem = [T2TView backItemWithTarget:self];
    self.control = [[RefreshControl alloc] initWithScrollView:self.tableView delegate:self];
    self.control.topEnabled = YES;
    self.control.bottomEnabled = YES;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    if (kIsIOS7) {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
//    self.refreshHead = [[CLLRefreshHeadController alloc] initWithScrollView:self.tableView viewDelegate:self];

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}




-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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

@end
