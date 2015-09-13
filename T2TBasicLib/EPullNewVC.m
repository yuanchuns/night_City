//
//  EPullNewVC.m
//  T2TBasicLib
//
//  Created by mark on 15/1/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EPullNewVC.h"

//#import "CLLRefreshHeadController.h"
#import "T2TView.h"
@interface EPullNewVC ()<RefreshControlDelegate,UITableViewDataSource,UITableViewDelegate>
//@property(nonatomic,strong)CLLRefreshHeadController *refreshHead;
@end

@implementation EPullNewVC


-(void)loadView{

    [super loadView];
    self.isHaveFootView = YES;
    self.isHaveHeadView = NO;
    self.tableStyle = UITableViewStylePlain;
}

-(void)dealloc{
    
    NSLog(@" EPullNewVC dealloc");
    self.arrData = nil;
    self.control = nil;
    self.tableView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kIsIOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationItem.leftBarButtonItem = [T2TView backItemWithTarget:self];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableStyle];
    self.tableView.height = kScreenHeight- kNavBarHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorColor:[UIColor colorWithHexString:@"#dbdbdb"]];
    [self.view addSubview:self.tableView];
    self.control = [[RefreshControl alloc]initWithScrollView:self.tableView delegate:self];
    self.control.bottomEnabled = self.isHaveFootView;
    self.control.topEnabled = self.isHaveHeadView;
    
    // Do any additional setup after loading the view.
}


-(void)navBackAction:(UIBarButtonItem *)backBar
{

    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}


#pragma mark - public


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
    [self.control finishRefreshingDirection:RefreshDirectionBottom withIsNetData:nil];
}

//开始上拉加载更多
-(void)startScrPullUpLoadMore{
    
}
//开始下拉刷新
-(void)startScrPullDownRefresh{

}
#pragma mark - CLLRefreshHeadControllerDelegate


-(void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction{

    if (direction == RefreshDirectionTop) {
        [self performSelector:@selector(startScrPullDownRefresh) withObject:nil afterDelay:1];
    }else{
        [self performSelector:@selector(startScrPullUpLoadMore) withObject:nil afterDelay:1];
    }}

//- (void)beginPullDownRefreshing{
//
//     [self performSelector:@selector(startScrPullDownRefresh) withObject:nil afterDelay:1];
//    
//}
//
//
//- (void)beginPullUpLoading{
//    
//    [self performSelector:@selector(startScrPullUpLoadMore) withObject:nil afterDelay:1];
//    
//    
//}


//- (CLLRefreshViewLayerType)refreshViewLayerType{
//
//    return CLLRefreshViewLayerTypeOnScrollViews;
//}
//
///**
// *  2、UIScrollView的控制器是否保留iOS7新的特性，意思是：tablView的内容是否可以显示导航条后面
// *
// *  @return 如果不实现该delegate方法，默认是不支持的
// **/
//- (BOOL)keepiOS7NewApiCharacter{
//    if (!self.navigationController)
//        return NO;
//    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
//    return keeped;
//}
//
///**
// * 3、是否显示 上拉更多视图
// * @return 如果不实现该delegate方法，默认是没有更多
// **/
//- (BOOL)hasRefreshFooterView{
//    return self.isHaveFootView;
//}
//
//-(BOOL)hasRefreshHeaderView{
//
//    return self.isHaveHeadView;
//}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     NSLog(@"EPullNewVc didReceiveMemoryWarning");
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
