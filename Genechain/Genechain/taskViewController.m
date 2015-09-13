//
//  taskViewController.m
//  Genechain
//
//  Created by nextone on 15/9/2.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "taskViewController.h"
#import "MJRefresh.h"
#import "taskcell.h"
@interface taskViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic)int page;
@end

@implementation taskViewController
//- (void)refresh{
//    __weak taskViewController *block_self = self;
//    [self.tableView addHeaderWithCallback:^{
//        block_self.page=1;
//        [block_self request_SelectTash_TravelInitSetLsit_connection];
//          }];
//    [self.tableView addFooterWithCallback:^{
//        [block_self request_SelectTash_TravelInitSetLsit_connection];
//    }];
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择任务";
    self.page = 1;
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.arrData = [NSMutableArray array];
    [self request_SelectTash_TravelInitSetLsit_connection];
    // Do any additional setup after loading the view from its nib.
}

//差旅建立初始化列表
-(void)request_SelectTash_TravelInitSetLsit_connection{
    
    __weak taskViewController *block_self =self;
    NSDictionary *dicPost   = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"projectId":kUnNilStr(self.detailModel.projectId)}};
    NSString *url = [NSString stringWithFormat:kMGDefaultURL,kMGTravel_Select_Task_ScheduleUrl,[dicPost JSONString]];

    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [T2THttpManager getWithUrl:url success:^(T2TResponse *responseObject) {
        [hub hide:YES];
        if (responseObject.code == kMGOkStatuCode) {
            
            for (NSDictionary *dicInfo in responseObject.list) {
                taskMode *model = [[taskMode alloc] initWithDic:dicInfo];
                [block_self.arrData addObject:model];
                [T2TFailedView  removeFromView:self.tableView];
                
             }
          
            } else {
            [T2TFailedView showFailedInView:self.tableView response:responseObject arrData:self.arrData withRefreshBlock:^{
                [T2TFailedView removeFromView:self.tableView];
                [block_self request_SelectTash_TravelInitSetLsit_connection];
            } editFailedView:^(T2TFailedView *failedView) {
                if(self.failedViewBlock)self.failedViewBlock(failedView);
            }];

        }
        [block_self.tableView reloadData];
        
        } failure:^(id error) {
        [hub hide:YES];
        [T2TView showFailHUDWithHUD:hub text:@"处理失败"];
        NSLog(@"error===%@",error);
        
        } otherHttpHeader:MGGetOtherHttpHear()];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrData count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    taskcell *cell = [taskcell cellWithTableView:tableView];
    taskMode *model =[self.arrData objectAtIndex:indexPath.row];
    cell.model =model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    taskMode *model =[self.arrData objectAtIndex:indexPath.row];
    (!self.taskcode) ?:self.taskcode(model);
    [self navBackAction:nil];

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
