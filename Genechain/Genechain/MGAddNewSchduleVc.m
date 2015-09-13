//
//  MGAddNewSchduleVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGAddNewSchduleVc.h"
#import "MGTextFiledCell.h"
#import "MGOneBoxCell.h"
#import "MGTwoBoxCell.h"
#import "MGTaskerCell.h"
#import "MGSchudleDetailModel.h"
#import "MGSelectedSchduleTypeVc.h"
#import "MGAreaModel.h"
#import "MGSelectedAreaVc.h"
#import "MGSelectProjectVc.h"
#import "MGSelectedClientVc.h"
#import "MGSelectedActivityVc.h"
#import "MGSelectedTaskerVc.h"
#import "MGSelectedCompanyVc.h"
#import "MGSelectedDeptVc.h"
#import "MGAddTaskerVc.h"
@interface MGAddNewSchduleVc ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrTasker;
@property (nonatomic, strong) MGSchudleDetailModel *detailModel;
@property (nonatomic, strong) MGAreaModel *areaModel;
@end

@implementation MGAddNewSchduleVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日程建立";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.height -= kNavBarHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    [self.tableView registerNibName:MGOneBoxCellClassName forCellReuseIdentifier:MGOneBoxCellClassName];
    [self.tableView registerNibName:MGTwoBoxCellClassName forCellReuseIdentifier:MGTwoBoxCellClassName];
    [self.tableView registerNibName:MGTextFiledCellClassName forCellReuseIdentifier:MGTextFiledCellClassName];
    [self.tableView registerNibName:MGTaskerCellClassName forCellReuseIdentifier:MGTaskerCellClassName];
    
    self.detailModel = [[MGSchudleDetailModel alloc] init];
    self.arrTasker = [NSMutableArray array];
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
//    btn.backgroundColor = [UIColor blueColor];
    [view addSubview:btn];
}

- (void)actionBtnOk {

    if ([self showMsg]) {
        NSDictionary *dicGet = @{@"status":MGGetStatusDicHaveUserName(),@"list":[self arrListTasker],@"object":[self getObjectDic]};
        
        NSString *strUrl = [NSString stringWithFormat:kMGDefaultURL,kMGAddNewSchduleUrl,[dicGet JSONString]];
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [T2THttpManager getWithUrl:strUrl success:^(T2TResponse *responseObject) {
            if(responseObject.code == kMGOkStatuCode){
                [T2TView showOKHUDWithHUD:hub test:@"建立成功"];
                [self performSelector:@selector(navBackAction:) withObject:nil afterDelay:1.5];
            } else {
                [T2TView showFailHUDWithHUD:hub text:responseObject.reson];
            }
        } failure:^(id error) {
            [T2TView showFailHUDWithHUD:hub text:@"创建失败"];
        } otherHttpHeader:MGGetOtherHttpHear()];
    }
    
}

- (NSDictionary *)getObjectDic {

    NSMutableDictionary *dicObject = [NSMutableDictionary dictionary];
    NSArray *arrKeys = @[@"projectId",@"clientId",@"clientName",@"activityType",@"projectName",@"activityName"];
    for (NSString *key in arrKeys) {
        [dicObject setObject:@"" forKey:key];
    }
    
    switch (self.detailModel.kind) {
        case 1:{
        
        }
            break;
        case 2:{
            [dicObject setObject:kStrWithInter(self.detailModel.clientId) forKey:@"clientId"];
            [dicObject setObject:self.detailModel.clientName forKey:@"clientName"];
        }
            break;
        case 3:{
            [dicObject setObject:kStrWithInter(self.detailModel.clientId) forKey:@"clientId"];
            [dicObject setObject:self.detailModel.clientName forKey:@"clientName"];
            [dicObject setObject:self.detailModel.projectId forKey:@"projectId"];
            [dicObject setObject:self.detailModel.projectName forKey:@"projectName"];


        }
            break;
        case 4:{

            [dicObject setObject:self.detailModel.activityName forKey:@"activityName"];
            [dicObject setObject:self.detailModel.activityType forKey:@"activityType"];

            
        }
            break;
        default:
            break;
    }
    
    [dicObject setObject:self.detailModel.deptName forKey:@"deptName"];
    [dicObject setObject:self.detailModel.startDate forKey:@"startDate"];
    [dicObject setObject:self.detailModel.cityName forKey:@"cityName"];
    [dicObject setObject:kStrWithInter(self.detailModel.cityCode) forKey:@"cityCode"];
    [dicObject setObject:self.detailModel.endDate forKey:@"endDate"];
    [dicObject setObject:kStrWithInter(self.detailModel.deptId) forKey:@"deptId"];
    [dicObject setObject:kStrWithInter(self.detailModel.kind) forKey:@"kind"];
    [dicObject setObject:kStrWithInter(self.detailModel.companyId) forKey:@"companyId"];
    [dicObject setObject:self.detailModel.comment forKey:@"taskName"];
    return [dicObject copy];
    
}

- (NSArray *)arrListTasker {

    NSMutableArray *arrDicInfo = [NSMutableArray array];
    
    for (MGSchduleDetailTaskerModel *model in self.arrTasker) {
        NSDictionary *dic = @{@"taskerName":kUnNilStr(model.taskerName),@"taskerEndDate":kUnNilStr(model.taskerEndDate),@"taskerComment":kUnNilStr(model.taskerComment),@"taskerStartDate":kUnNilStr(model.taskerStartDate),@"taskerNo":kUnNilStr(model.taskerNo)};
        [arrDicInfo addObject:dic];
    }
    
    return [arrDicInfo copy];
}

- (BOOL)showMsg {

    if (self.detailModel.kind == 0) {
        [T2TView showFailHUDWithText:@"请选择类别"];
        return NO;
    } else if (self.detailModel.cityCode == 0) {
         
        [T2TView showFailHUDWithText:@"请选择城市"];
        return NO;
     } else if (self.detailModel.comment == nil || self.detailModel.comment.length == 0) {
         
         [T2TView showFailHUDWithText:@"请输入日程描述"];
         return NO;
     } else if (self.detailModel.companyId == 0) {
         
         [T2TView showFailHUDWithText:@"请选择城市"];
         return NO;
     } else if (self.detailModel.deptId == 0) {
     
         [T2TView showFailHUDWithText:@"请选择部门"];
         return NO;
     } else if (self.detailModel.endDate == nil) {
     
         [T2TView showFailHUDWithText:@"请选择开始日和结束日"];
         return NO;
     } else if (self.arrTasker.count == 0) {
     
         [T2TView showFailHUDWithText:@"请添加任务人"];
         return NO;
     }
    
    switch (self.detailModel.kind) {
        case 1:{
            
        }
            break;
        case 2:{
            if (self.detailModel.clientId == 0) {
                
            [T2TView showFailHUDWithText:@"请选择客户"];
            return NO;
            }
            
        }
            break;
        case 3:{
            if (self.detailModel.projectId == 0) {
                
                [T2TView showFailHUDWithText:@"请选择项目"];
                return NO;
            }
        }
            break;
        case 4:{
            if (self.detailModel.activityId == nil) {
                
                [T2TView showFailHUDWithText:@"请选择活动"];
                return NO;
            }
        }
            break;
        default:
            break;
    }

    
    return YES;
}

- (void)setDatePicviewWithtype:(int)type{
    
    if (type == 2 && self.detailModel.startDate == nil) {
        [T2TView showFailHUDWithText:@"请先选择开始时间"];
        return;
    }
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
            self.detailModel.startDate = dict[kDateStrKey];
        }else{
            NSDate *startDate = [dateForMatter dateFromString:self.detailModel.startDate];
            NSDate *endDate = [dateForMatter dateFromString:dict[kDateStrKey]];
            if ([startDate compare:endDate] == NSOrderedAscending) {
             self.detailModel.endDate = dict[kDateStrKey];
            } else {
            [T2TView showFailHUDWithText:@"结束时间不能早于开始时间"];
            }
            
        }
        [self.tableView reloadData];
    }];
    [sheet showInView:kCurrentWindow];
}


#pragma mark - tableDelegateAndDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.arrTasker.count + 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        [cell setLblFirHandle:^{
            MGSelectedSchduleTypeVc *cvc = [[MGSelectedSchduleTypeVc alloc] init];
            [cvc setHandleBlock:^(MGProjectTypeModel *model) {
                self.detailModel.kind = model.kindId;
                self.detailModel.kindName = model.kindName;
                [tableView reloadData];
            }];
            cvc.type =0;
            [self.navigationController pushViewController:cvc animated:YES];
        }];
        
        [cell setLblSecHandle:^{
            MGSelectedAreaVc *mvc = [[MGSelectedAreaVc alloc] init];
            mvc.selectModel = self.areaModel;
            [mvc setselectAreaHandle:^(MGAreaModel *model) {
                self.areaModel = model;
                self.detailModel.cityCode = (int)[model.code integerValue];
                self.detailModel.cityName = model.name;
                [tableView reloadData];
            }];
            [self.navigationController pushViewController:mvc animated:YES];
        }];
        
        if (self.detailModel.kind == 0) {
            [cell setLblFirPlahodler:@"选择类别"];
        } else {
            [cell resetLblFir];
            cell.lblFir.text = self.detailModel.kindName;
        }
        
        if (self.detailModel.cityCode == 0) {
            [cell setLblSecPlahodler:@"选择城市"];
        } else {
        
            [cell resetLblSec];
            cell.lblSec.text = self.detailModel.cityName;
        }
        
        return cell;
    }else if (indexPath.row == 1){
    
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        [cell setLblFirHandle:^{
            MGSelectedCompanyVc *cvc = [[MGSelectedCompanyVc alloc] init];
            [cvc setSelectedHandle:^(MGCommpanyModel *model) {
                if (model.denfineValue != self.detailModel.companyId) {
                    self.detailModel.deptId = 0;
                    self.detailModel.deptName = nil;
                }
                self.detailModel.companyName = model.denfineName;
                self.detailModel.companyId = model.denfineValue;
                [tableView reloadData];
            }];
            [self.navigationController pushViewController:cvc animated:YES];
        }];
        
        [cell setLblSecHandle:^{
            if (self.detailModel.companyId == 0) {
                [T2TView showFailHUDWithText:@"请先选择公司"];
                return ;
            }
            MGSelectedDeptVc *dvc = [[MGSelectedDeptVc alloc] init];
            dvc.parentId = self.detailModel.companyId;
            [dvc setHandleSlected:^(MGDepartmentModel *model) {
                self.detailModel.deptId = model._id;
                self.detailModel.deptName = model.deptName;
                [tableView reloadData];
            }];
            [self.navigationController pushViewController:dvc animated:YES];
        }];
        
        if (self.detailModel.companyId == 0) {
            
            [cell setLblFirPlahodler:@"公司"];
        } else {
        
            [cell resetLblFir];
            cell.lblFir.text = self.detailModel.companyName;
        }
        
        if (self.detailModel.deptId == 0) {
            [cell setLblSecPlahodler:@"部门"];
        } else {
        
            [cell resetLblSec];
            cell.lblSec.text = self.detailModel.deptName;
        }
        
        return cell;

    }else if (indexPath.row == 2){
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if (self.detailModel.projectId == 0) {
            cell.placeholder = @"选择项目";
        } else {
            [cell resetCell];
            cell.lblContent.text = self.detailModel.projectName;
        }
        return cell;
    }else if (indexPath.row == 3){
    
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if (self.detailModel.clientId == 0) {
            cell.placeholder = @"选择客户";
        } else {
            [cell resetCell];
            cell.lblContent.text = self.detailModel.clientName;
        }
        return cell;
    }else if (indexPath.row == 4){
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if (self.detailModel.activityId == 0) {
            cell.placeholder = @"选择活动";
        } else {
            [cell resetCell];
            cell.lblContent.text = self.detailModel.activityName;
        }
        return cell;
    }else if (indexPath.row == 5){
        MGTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTextFiledCellClassName];
        [cell setTextFiledTextChangeHandle:^(id error) {
            self.detailModel.comment = error;
        }];
        cell.textFiled.placeholder = @"任务描述";
        return cell;
    }else if (indexPath.row == 6){
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        [cell setLblFirHandle:^{
            [self setDatePicviewWithtype:1];
        }];
        [cell setLblSecHandle:^{
           [self setDatePicviewWithtype:2];
        }];
        
        if (self.detailModel.startDate == nil) {
            [cell setLblFirPlahodler:@"开始日"];
        } else {
            [cell resetLblFir];
            cell.lblFir.text = self.detailModel.startDate;
        }
        
        if (self.detailModel.endDate == nil) {
            
            [cell setLblSecPlahodler:@"结束日"];
            
        } else {
        
            [cell resetLblSec];
            cell.lblSec.text = self.detailModel.endDate;
        }
        
        return cell;
    }
    MGTaskerCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTaskerCellClassName];
    if (self.arrTasker.count > 0) {
        [cell setUIValueWithModel:self.arrTasker[indexPath.row-7]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row > 6) {
        if (self.arrTasker.count > 0) {
         return    [MGTaskerCell getCellHeightWithModel:self.arrTasker[indexPath.row-7]];
        }
        return 0;
    } else if (indexPath.row > 1 && indexPath.row < 5 && self.detailModel.kind != 0) {
        if (self.detailModel.kind == 1 || self.detailModel.kind> 4){
            return 0;
        }
        float rowHeight[4][3] = {{0,0,0},{0,48,0},{48,48,0},{0,0,48}};
        return rowHeight[self.detailModel.kind-1][indexPath.row-2];
    }
    
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 63)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 55, 32);
    [btn setBackgroundImage:kImaWithImaName(@"schedule_edit_tasker_add") forState:UIControlStateNormal];
    btn.center = view.center;
    [btn addTarget:self action:@selector(actionBtnAdd) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 52;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 2) {
        MGSelectProjectVc *pvc = [[MGSelectProjectVc alloc] init];
        [pvc setSelectedHandle:^(MGProjectModel *model) {
            self.detailModel.projectId = kStrWithInter(model.projectId);
            self.detailModel.projectName = model.projectName;
            self.detailModel.clientName = model.clientName;
            self.detailModel.clientId = model.clientId;
            
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:pvc animated:YES];
    }else if (indexPath.row == 3 && self.detailModel.kind != 3){
    
        MGSelectedClientVc *cvc = [[MGSelectedClientVc alloc] init];
        [cvc setSelectHanle:^(MGClientModel *model) {
            self.detailModel.clientId = model.clientId;
            self.detailModel.clientName = model.clientName;
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:cvc animated:YES];
    } else if (indexPath.row == 4) {
    
        MGSelectedActivityVc *avc = [[MGSelectedActivityVc alloc] init];
        [avc setSelectedActivityHandle:^(id obj, int indexTypeSelected) {
            if (indexTypeSelected == 1) {
                MGActivetyOfEnrollmentModel *model = obj;
                self.detailModel.activityId = kStrWithInter(model.activityId);
                self.detailModel.activityName = model.activityName;
                self.detailModel.activityType = @"1";
            } else {
                MGActivetyOfExhibition *model = obj;
                self.detailModel.activityId = kStrWithInter(model.expositionId);
                self.detailModel.activityName = model.expositionName;
                self.detailModel.activityType = @"2";
                
            }
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:avc animated:YES];
    } else if (indexPath.row > 6) {
    
        MGSchduleDetailTaskerModel *model = self.arrTasker[indexPath.row - 7];
        MGAddTaskerVc *tvc = [[MGAddTaskerVc alloc] initWithDetailModel:model];
        tvc.editType = changeTasker;
        [tvc setselectedTaskerModel:^(MGSchduleDetailTaskerModel *model, taskerEditType type) {
            [self.arrTasker replaceObjectAtIndex:indexPath.row-7 withObject:model];
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:tvc animated:YES];
        
    }
}

- (void)actionBtnAdd {

    if (self.detailModel.startDate && self.detailModel.endDate) {
        MGAddTaskerVc *tvc = [[MGAddTaskerVc alloc] initWithStarteDate:self.detailModel.startDate endDate:self.detailModel.endDate];
        tvc.editType = addTasker;
        [tvc setselectedTaskerModel:^(MGSchduleDetailTaskerModel *model, taskerEditType type) {
            [self.arrTasker addObject:model];
            [self.tableView reloadData];
        }];
//        [tvc setselectedTaskerModel:^(MGSchduleDetailTaskerModel *model) {
//            [self.arrTasker addObject:model];
//            [self.tableView reloadData];
//        }];
        [self.navigationController pushViewController:tvc animated:YES];
    } else {
        
        [T2TView showFailHUDWithText:@"请先选择开始日和结束日"];
    }
    
    
}

- (void)gotoSelectedKind{

    MGSelectedSchduleTypeVc *tvc = [[MGSelectedSchduleTypeVc alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
    
    [tvc setHandleBlock:^(MGProjectTypeModel *model) {
        self.detailModel.kind = model.kindId;
        self.detailModel.kindName = model.kindName;
    }];
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
