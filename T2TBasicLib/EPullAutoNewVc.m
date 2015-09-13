//
//  EPullAutoNewVc.m
//  T2TBasicLib
//
//  Created by mark on 15/1/15.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EPullAutoNewVc.h"
#import "T2THttpManager.h"
#import "T2TFailedView.h"
@interface EPullAutoNewVc ()

@end

@implementation EPullAutoNewVc
-(void)dealloc{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    NSLog(@" EPullAutoNewVc dealloc");
    self.failedViewBlock = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self getRequestUrlStr]) {
        [self startPullDownRefreshing];
    }
    // Do any additional setup after loading the view.
}

#pragma mark -public
-(NSString *)getRequestUrlStr{
    
    return @"";
}

-(void)handleContentData:(id)content{
    
}

-(void)handleContentResponse:(T2TResponse *)content{
}

-(void)reloadData{
    
    [T2TFailedView removeFromView:self.tableView];
    [self startPullDownRefreshing];
}

#pragma mark - private

-(void)loadData{
    [T2TFailedView removeFromView:self.tableView];
    self.isLoading = YES;
    NSString *str = [self getRequestUrlStr];
    [T2THttpManager  getWithUrl:str success:^(T2TResponse *responseObject) {
        [self loadDidEndWithResponse:responseObject];
    } failure:^(id res) {
        [self loadDidEndWithResponse:res];
    }];
}

-(void)loadDidEndWithResponse:(T2TResponse *)respose{
    if (![respose isKindOfClass:[T2TResponse class]]) {
        respose = [[T2TResponse alloc] initWithDic:nil];
    }
    self.allCount = respose.count;
    if (!self.arrData) self.arrData = [NSMutableArray array];
    [self handleContentData:respose.list];
    [self handleContentResponse:respose];
    [self.tableView reloadData];
    [self.control finishRefreshingDirection:(self.curIndex == 1)?RefreshDirectionTop:RefreshDirectionBottom withIsNetData:[NSDate date]];
    self.isLoading = NO;
    self.isNotMore = (self.arrData.count >= respose.count);
    [self endPullUpLoading];
    [self.control finishRefreshingDirection:RefreshDirectionTop withIsNetData:[NSDate date]];
    
   __weak typeof(self) weakSelf = self;
    [T2TFailedView showFailedInView:self.tableView response:respose arrData:self.arrData withRefreshBlock:^{
        [weakSelf reloadData];
        
    } editFailedView:^(T2TFailedView *failedView) {
        if(self.failedViewBlock)self.failedViewBlock(failedView);
    }];
    [self finishHandleDataWithResponse:respose];
}

-(void)finishHandleDataWithResponse:(T2TResponse *)res{

}

-(void)willStartPullDownFreash{

}

#pragma mark - SuperApi

-(void)startScrPullDownRefresh{
    if (!self.isLoading) {
        self.isLoading = YES;
        self.curIndex = 1;
        self.arrData = [NSMutableArray array];
        [self willStartPullDownFreash];
        [self loadData];
    }
   
}

-(void)startScrPullUpLoadMore{
    if (!self.isLoading) {
        self.isLoading = YES;
        self.curIndex ++;
        [self loadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"EPullAutoNewVc didReceiveMemoryWarning");
    // Dispose of any resources that can be recreated.
}


@end
