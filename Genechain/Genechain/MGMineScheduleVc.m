//
//  MGMineScheduleVc.m
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMineScheduleVc.h"
#import "MGMineSchduleCell.h"
#import "MGSchduleDetailVc.h"
#import "T2TDatePikerActionSheet.h"
#import "MGAddMineSchduleNoti.h"
@interface MGMineScheduleVc ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MGMineScheduleVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的日程";
    [self.tableView registerNibName:MGMineSchduleCellClassName forCellReuseIdentifier:MGMineSchduleCellClassName];
    self.tableView.height -= kTabBarHeight;
    self.tableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}

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


- (void)setDatePicviewWithModel:(MGMangerSchduleModel *)model{
    
//    NSString *dateAndTime = [NSString stringWithFormat:@"%@ %@",model.startDate,model.startTime];
//    NSDate *today = [NSDate date];
//    
//    NSCalendar *gregorian = [NSCalendar currentCalendar];
//    
//    NSDateComponents *dateComm = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit  fromDate:today];
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
    [dateForMatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDate *date = [dateForMatter dateFromString:dateAndTime];
    T2TDatePikerActionSheet *sheet = [[T2TDatePikerActionSheet alloc] init];
    sheet.datePicker.date = [NSDate date];
    sheet.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    sheet.format = dateForMatter;
    [sheet setSelectedBlock:^(NSDictionary *dict) {
        
        NSDate *date = [dateForMatter dateFromString:dict[kDateStrKey]];
        [MGAddMineSchduleNoti addLocationNotiWithId:[model.scheduleId intValue] userInfo:model date:date finishBlock:^(BOOL state) {
            if (state) {
                [T2TView showOKHUDWithText:@"添加闹钟成功"];
            } else {
                [T2TView showFailHUDWithText:@"该任务闹钟已经存在"];
            }
            [self.tableView reloadData];
        }];
        
    }];
    [sheet showInView:kCurrentWindow];
}
#pragma mark - override

- (NSString *)getRequestUrlStr{


    MGUserModel *mager = [MGUserModel shareMGUserModel];
    NSMutableDictionary *dicStatus = [NSMutableDictionary dictionaryWithDictionary:MGGetStausDic()];
    [dicStatus setObject:kUnNilStr(mager.userName) forKey:@"userName"];
//    NSString *strIndex = [NSString stringWithFormat:@"%ld",self.curIndex];
    NSDictionary *dicGet = @{@"status":dicStatus,@"object":@{@"pageNo":@(self.curIndex),@"loginName":kUnNilStr(mager.loginName)}};
    NSString *strUrl = [NSString stringWithFormat:kMGDefaultURL,kMGMineScheduleUrl,[dicGet JSONString]];
    return strUrl;
}

- (void)handleContentResponse:(T2TResponse *)content{

    if ([content.list isKindOfClass:[NSArray class]] && content.code == kMGOkStatuCode) {
        for (NSDictionary *dic in content.list) {
            MGMangerSchduleModel *model = [[MGMangerSchduleModel alloc] initWithDic:dic];
            [self.arrData addObject:model];
        }
    }
}


#pragma  mark - tableDelegateOrDataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MGMineSchduleCell *cell = [tableView dequeueReusableCellWithIdentifier:MGMineSchduleCellClassName];
    if (self.arrData.count > indexPath.row) {
        
        MGMangerSchduleModel  *model = self.arrData[indexPath.row];
       [cell setUivalueWithModel:model];
        
        [cell setBtnActionHandle:^{
            [self setDatePicviewWithModel:model];
        }];
        cell.btnAdd.selected = ([kUserDefaults objectForKey:model.scheduleId]);
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.arrData.count > indexPath.row) {
        return [MGMineSchduleCell getCellHeightWithModel:self.arrData[indexPath.row]];
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MGSchduleDetailVc *dvc = [[MGSchduleDetailVc alloc] init];
    MGMangerSchduleModel *model = self.arrData[indexPath.row];
    dvc.schduleId = model.scheduleId;
    

    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
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
