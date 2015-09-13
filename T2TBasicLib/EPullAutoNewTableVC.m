//
//  EPullAutoNewTableVC.m
//  T2TBasicLib
//
//  Created by mark on 15/1/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EPullAutoNewTableVC.h"
#import "T2THttpManager.h"

@interface EPullAutoNewTableVC ()

@end

@implementation EPullAutoNewTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
 if([self getRequestUrlStr] && !self.isNotAuto)[self.control startRefreshingDirection:RefreshDirectionTop];
    
    // Do any additional setup after loading the view.
}

- (void)dealloc{

    NSLog(@"EPullAutoNewTableVC dealloc");
    self.failedViewBlock = nil;
    
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
    [self.control startRefreshingDirection:RefreshDirectionTop];
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
    
    self.isLoading = NO;
    self.isNotMore= (self.arrData.count >= respose.count);
     [self.control finishRefreshingDirection:(self.curIndex == 1)?RefreshDirectionTop:RefreshDirectionBottom withIsNetData:[NSDate date]];
    [self.control finishRefreshingDirection:RefreshDirectionTop withIsNetData:[NSDate date]];
//    [self endPullDownRefreshing];
    [self endPullUpLoading];
    
    __weak typeof(self) weakSelf = self;
    [T2TFailedView showFailedInView:self.tableView response:respose arrData:self.arrData withRefreshBlock:^{
        [weakSelf reloadData];
    } editFailedView:^(T2TFailedView *failedView) {
        if(self.failedViewBlock)self.failedViewBlock(failedView);
    }];
}


#pragma mark - SuperApi

-(void)startScrPullDownRefresh{
    if (!self.isLoading) {
        self.isLoading = YES;
        self.curIndex = 1;
        self.arrData = [NSMutableArray array];
        [self loadData];
    
    }
}

-(void)startScrPullUpLoadMore{
    if(!self.isLoading){
    self.isLoading = YES;
    self.curIndex ++;
        [self loadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
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
