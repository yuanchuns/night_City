//
//  MGSchdulePullVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSchdulePullVc.h"

@interface MGSchdulePullVc ()
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation MGSchdulePullVc

- (void)loadView{

    [super loadView];
    self.isHaveHeadView = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    if ([self getRequestUrlStr]) {
        [self startPullDownRefreshing];
    }
    // Do any additional setup after loading the view.
}

- (void)startScrPullUpLoadMore{
    if (!self.isLoading) {
        self.isLoading = YES;
        self.curIndex ++;
        [self loadData];
    }

}

- (void)startScrPullDownRefresh{

    
    if (!self.isLoading) {
        self.isLoading = YES;
        self.curIndex = 1;
        self.arrData = [NSMutableArray array];
        [self loadData];
    }

    
}

- (NSString *)getRequestUrlStr{

    return @"";
}

- (void)handleContentResponse:(T2TResponse *)content{

}

-(void)loadData{
    [T2TFailedView removeFromView:self.tableView];
    self.isLoading = YES;
    NSString *str = [self getRequestUrlStr];
    [T2THttpManager  getWithUrl:str success:^(T2TResponse *responseObject) {
        [self loadDidEndWithResponse:responseObject];
    } failure:^(id res) {
        [self loadDidEndWithResponse:res];
    } otherHttpHeader:MGGetOtherHttpHear()];
}

-(void)reloadData{
    
    [T2TFailedView removeFromView:self.tableView];
    [self startPullDownRefreshing];
}
-(void)loadDidEndWithResponse:(T2TResponse *)respose{
    if (![respose isKindOfClass:[T2TResponse class]]) {
        respose = [[T2TResponse alloc] initWithDic:nil];
    }
    if (!self.arrData) self.arrData = [NSMutableArray array];
    [self handleContentResponse:respose];
    [self.tableView reloadData];
    [self.control finishRefreshingDirection:(self.curIndex == 1)?RefreshDirectionTop:RefreshDirectionBottom withIsNetData:[NSDate date]];
    self.isLoading = NO;
    self.isNotMore = (![respose.list isKindOfClass:[NSArray class]]);
    [self endPullUpLoading];
    [self.control finishRefreshingDirection:RefreshDirectionTop withIsNetData:[NSDate date]];
    
    __weak typeof(self) weakSelf = self;
    [T2TFailedView showFailedInView:self.tableView response:respose arrData:self.arrData withRefreshBlock:^{
        [weakSelf reloadData];
        
    } editFailedView:^(T2TFailedView *failedView) {
//        if(self.failedViewBlock)self.failedViewBlock(failedView);
    }];
   
}


- (void)dealloc{

    NSLog(@"MGSchdulePullVc dealloc");
}

@end
