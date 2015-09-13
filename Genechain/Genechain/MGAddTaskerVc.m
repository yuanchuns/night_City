//
//  MGAddTaskerVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/17.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGAddTaskerVc.h"
#import "MGOneBoxCell.h"
#import "MGTextFiledCell.h"
#import "MGSchduleDetailTaskerModel.h"
#import "T2TDatePikerActionSheet.h"
#import "MGSelectedTaskerVc.h"
@interface MGAddTaskerVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MGSchduleDetailTaskerModel *detailTaskerModel;
@property (nonatomic, copy) takserEditTypeBlock objBlock;
@property (nonatomic, weak) UITextField *textFiled;
@end

@implementation MGAddTaskerVc

- (instancetype)initWithStarteDate:(NSString *)startDate endDate:(NSString *)endDate {

    if (self = [super init]) {
        self.detailTaskerModel = [[MGSchduleDetailTaskerModel alloc] init];
        self.detailTaskerModel.taskerStartDate = startDate;
        self.detailTaskerModel.taskerEndDate = endDate;
    }
    return self;
}

- (instancetype)initWithDetailModel:(MGSchduleDetailTaskerModel *)model {

    if (self = [super init]) {
        self.detailTaskerModel = [[MGSchduleDetailTaskerModel alloc] initWithDic:[model dicData]];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加任务人";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNibName:MGTextFiledCellClassName forCellReuseIdentifier:MGTextFiledCellClassName];
    [self.tableView registerNibName:MGOneBoxCellClassName forCellReuseIdentifier:MGOneBoxCellClassName];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    [self addTableFootView];
    
    // Do any additional setup after loading the view.
}

- (void)addTableFootView {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.tableView.tableFooterView = view;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 0, kScreenWidth - 20, 50);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionBtnOk) forControlEvents:UIControlEventTouchUpInside];
     [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#46bbf0"]] forState:UIControlStateNormal];
    btn.userInteractionEnabled  = (self.detailTaskerModel.taskerName != nil);
    [view addSubview:btn];
}

- (void)actionBtnOk {

    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
    [dateForMatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [dateForMatter dateFromString:self.detailTaskerModel.taskerStartDate];
    NSDate *endDate = [dateForMatter dateFromString:self.detailTaskerModel.taskerEndDate];
    if ([startDate compare:endDate] == NSOrderedAscending) {
        self.detailTaskerModel.taskerComment = kUnNilStr(self.textFiled.text);
        (!self.objBlock) ?: self.objBlock(self.detailTaskerModel,self.editType);
        [self navBackAction:nil];
    } else {
        [T2TView showFailHUDWithText:@"结束时间不能早于开始时间"];
    }

}

- (void)setselectedTaskerModel:(takserEditTypeBlock)objBlock {

    self.objBlock = objBlock;
}

- (void)setDatePicviewWithtype:(int)type{
    
    NSDate *today = [NSDate date];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComm = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit  fromDate:today];
    dateComm.hour = (type == 1)?9:18;
    dateComm.minute = 0;
    
    
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
    [dateForMatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    T2TDatePikerActionSheet *sheet = [[T2TDatePikerActionSheet alloc] init];
//    sheet.datePicker.minimumDate = [NSDate date];
    sheet.datePicker.date = [gregorian dateFromComponents:dateComm];
    sheet.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    sheet.format = dateForMatter;
    [sheet setSelectedBlock:^(NSDictionary *dict) {
        if (type == 1) {
            self.detailTaskerModel.taskerStartDate = dict[kDateStrKey];
        }else{
            
            self.detailTaskerModel.taskerEndDate = dict[kDateStrKey];
        }
        [self.tableView reloadData];
    }];
    [sheet showInView:kCurrentWindow];
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y < 0) {
        [self.view endEditing:YES];
    }
    
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if (self.detailTaskerModel.taskerName) {
            [cell resetCell];
            cell.lblContent.text = self.detailTaskerModel.taskerName;
        } else {
        
            cell.placeholder = @"选择任务人";
        }
        return cell;
    } else if (indexPath.row == 1) {
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        [cell resetCell];
        cell.lblContent.text = self.detailTaskerModel.taskerStartDate;
        return cell;
    } else if (indexPath.row == 2) {
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        [cell resetCell];
        cell.lblContent.text = self.detailTaskerModel.taskerEndDate;
        return cell;
    }
    
    MGTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTextFiledCellClassName];
   cell.textFiled.placeholder = @"备注";
    self.textFiled = cell.textFiled;
    cell.textFiled.text = self.detailTaskerModel.taskerComment;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 52;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        MGSelectedTaskerVc *tvc = [[MGSelectedTaskerVc alloc] init];
        [tvc setSelectedEmployModelHandle:^(MGEmployeeModel *model) {
            self.detailTaskerModel.taskerNo = model.employeeNo;
            self.detailTaskerModel.taskerName = model.employeeName;
            [self addTableFootView];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:tvc animated:YES];
        
    } else if (indexPath.row == 1) {
        
    [self setDatePicviewWithtype:1];
        
    } else if (indexPath.row == 2){
        
        [self setDatePicviewWithtype:2];
        
    }
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
