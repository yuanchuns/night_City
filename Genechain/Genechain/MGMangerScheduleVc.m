//
//  MGMangerScheduleVc.m
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMangerScheduleVc.h"
#import "MGMangerSchduleModel.h"
#import "MGMangerSchduleCell.h"
#import "MGSchduleDetailVc.h"
#import "MGSchduleQueryVc.h"
#import "MGAddNewSchduleVc.h"
#import "MGCalendarView.h"
@interface MGMangerScheduleVc ()<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic, strong) NSMutableDictionary *dicContainsInfo;
@property (nonatomic, strong) MGSchduleQueryVc *qvc;
@property (nonatomic, strong) MGSchudleDetailModel *detailModel;
@end

@implementation MGMangerScheduleVc

- (void)viewDidLoad {
    

    [super viewDidLoad];
     self.title = @"日程管理";
    
    self.detailModel  = [[MGSchudleDetailModel alloc] init];
    MGCalendarView *calendarView = [[MGCalendarView alloc] initWithFrame:CGRectMake(0, 0, 50, kScreenHeight-kNavBarHeight-kTabBarHeight)];
    [calendarView setSelectedHandle:^(NSString *calendarStr, BOOL isMonth) {
        if (isMonth) {
            self.detailModel.startDate = calendarStr;
            self.detailModel.endDate = nil;
            
        } else {
            self.detailModel.startDate = nil;
            self.detailModel.endDate = calendarStr;
            
        }
        [self startPullDownRefreshing];
    }];
    [self.view addSubview:calendarView];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.height -= kTabBarHeight;
    self.tableView.left = 50;
    self.tableView.width -= 50;
    [self.tableView registerNibName:MGMangerSchduleCellClassName forCellReuseIdentifier:MGMangerSchduleCellClassName];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 33);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"日程管理" forState:UIControlStateNormal];
     [btn setImage:kImaWithImaName(@"schedule_type_button_focus") forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kImaWithImaName(@"btn_add_normel") style:UIBarButtonItemStylePlain target:self action:@selector(actionRightBar)];
   
    [self reloadDate];
    // Do any additional setup after loading the view.
}



- (void)reloadDate {

    
    NSDate *date = [NSDate date];
    NSDateComponents *comm = [date CreateDateComponentsWithYMD];
    NSString *strDate = [NSString stringWithFormat:@"%ld%02ld",comm.year,comm.month];
    self.detailModel.startDate = strDate;
//    self.dicContainsInfo = [[NSMutableDictionary alloc] initWithDictionary:@{@"yearMonth":strDate,@"yearMonthDay":@""}];
}

#pragma mark - overRide
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

#pragma mark - actionFunc

- (void)actionRightBar{
    MGAddNewSchduleVc *avc = [[MGAddNewSchduleVc alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)btnAction{

//    if (!self.qvc) {
        self.qvc = [[MGSchduleQueryVc alloc] init];
//    }
    
    T2TNavController *nav = getNavWithVc(self.qvc);
//    _qvc.dicInfo = self.dicContainsInfo;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    __weak typeof(self) weak = self;
    self.qvc.detailModel = self.detailModel;
    [self.qvc setOkHandle:^(MGSchudleDetailModel *model) {
        weak.detailModel = model;
        [weak startPullDownRefreshing];
    }];
    
}

- (void)handleContentResponse:(T2TResponse *)content{

    if ([content.list isKindOfClass:[NSArray class]] && content.code == kMGOkStatuCode) {
        for (NSDictionary *dic in content.list) {
            MGMangerSchduleModel *model = [[MGMangerSchduleModel alloc] initWithDic:dic];
            [self.arrData addObject:model];
        }
    }
}

- (NSString *)getRequestUrlStr{

    MGUserModel *model = [MGUserModel shareMGUserModel];
    
//    :{"pageNo":1,"loginName":"wuran","kind":"1","deptId":"17","taskerName":"张庆文","clientName":"联通","yearMonth":"201507","yearMonthDay":"20150701"
    
//    object:{"pageNo":1,"loginName":"wuran","kind":"1","deptId":"17","taskerName":"张庆文","clientName":"联通","yearMonth":"201507","yearMonthDay":"20150701"}
    
    
    NSDictionary *dicInfo = @{@"pageNo":@(self.curIndex),@"loginName":kUnNilStr(model.loginName),@"kind":(self.detailModel.kind == 0)?@"":kStrWithInter(self.detailModel.kind),@"deptId":(self.detailModel.deptId == 0)?@"":kStrWithInter(self.detailModel.deptId),@"taskerName":kUnNilStr(self.detailModel.taskName),@"clientName":kUnNilStr(self.detailModel.clientName),@"yearMonth":kUnNilStr(self.detailModel.startDate),@"yearMonthDay":kUnNilStr(self.detailModel.endDate)};
    

    
    NSString *url = [NSString stringWithFormat:kMGDefaultURL,kMGMangerScheduleUrl,[@{@"status":MGGetStatusDicHaveUserName(),@"object":dicInfo} JSONString]];
    return url;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MGMangerSchduleCell *cell = [tableView dequeueReusableCellWithIdentifier:MGMangerSchduleCellClassName];
    
    if (self.arrData.count > indexPath.row) {
        [cell setUIValueWithModel:self.arrData[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.arrData.count > indexPath.row) {
        return  [MGMangerSchduleCell getCellHeightWithModel:self.arrData[indexPath.row]];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MGSchduleDetailVc *devc = [[MGSchduleDetailVc alloc] init];
    MGMangerSchduleModel *model = self.arrData[indexPath.row];
    devc.schduleId = model.scheduleId;
    [self.navigationController pushViewController:devc animated:YES];
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
