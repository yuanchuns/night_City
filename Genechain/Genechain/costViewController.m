//
//  costViewController.m
//  Genechain
//
//  Created by nextone on 15/9/2.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "costViewController.h"
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
#import "taskViewController.h"
#import "BoolViewController.h"
@interface costViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrTasker;
@property (nonatomic, strong) MGSchudleDetailModel *detailModel;
@property (nonatomic, strong) MGAreaModel *areaModel;
@property (nonatomic, strong) taskMode *taskMode;

@property(nonatomic,copy)NSString *string;

@end

@implementation costViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isBook) {
        self.title = @"教具费用建立";
    }else {
        self.title = @"差旅费用建立";
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
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
    self.taskMode =[[taskMode alloc]init];
    self.detailModel = [[MGSchudleDetailModel alloc] init];
    self.arrTasker = [NSMutableArray array];
    [self addTableFootView];
    [self initString];
    // Do any additional setup after loading the view.
}
-(void)initString{
    self.string = @"否";
    self.detailModel.advanceFlag = 0;
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
    if (self.detailModel.kind==1) {
        if (self.detailModel.projectName.length==0) {
            [T2TView showFailHUDWithText:@"请选择项目"];
            return;
        }
        if (self.taskMode.taskName.length==0) {
            [T2TView showFailHUDWithText:@"请选择任务"];
            return;
        }
        
    }else if (self.detailModel.kind==2){
        
        if (self.detailModel.clientName.length==0) {
            [T2TView showFailHUDWithText:@"请选择客户"];
            return;
        }
        
        
    }else if (self.detailModel.kind==4){
        if (self.detailModel.activityName.length==0) {
            [T2TView showFailHUDWithText:@"请选择活动"];
            return;
        }
    }
    if (self.detailModel.comment.length==0) {
        [T2TView showFailHUDWithText:@"请输入费用说明"];
        return;
    }
    [self request_TravelInitSetLsit_connection];
}

//差旅建立初始化列表
-(void)request_TravelInitSetLsit_connection{
    
    //expenseType   费用类型
    
//http://223.4.94.140:8091/pm/appBook!w203Book.action?word={"status":{"userName":"王东","beanName":"status","parameter":"1","ver":"1.0.0","sessionId":"31898DD3ABAAF9425C987DFEA8908EEA","loginName":"wangdong"},"object":{"taskId":"3474","bookId":"2191","salonName":"","description":"描述说明哦","clientName":"广东邮电职业技术学院","salonId":"","expenseType":"1","salonType":"","projectId":"1630","companyId":"6","clientId":"4615"}}
    NSDictionary *dicPost;
    NSString *url;
    if (self.isBook) {
        dicPost   = @{@"status":MGGetStatusDicHaveUserName(),
                          @"object":@{@"taskId":kUnNilStr(self.taskMode.id),
                                      @"bookId":kUnNilStr(self.Bookmodel.id),
                                      @"advanceFlag":kStrWithInter(self.detailModel.advanceFlag),
                                      @"salonName":kUnNilStr(self.detailModel.activityName),
                                      @"description":kUnNilStr(self.detailModel.comment),
                                      @"clientName":kUnNilStr(self.detailModel.clientName),
                                      @"subjectId":kUnNilStr(self.model.subjectId),
                                      @"salonId":kUnNilStr(self.detailModel.activityId),
                                      @"expenseType":kStrWithInter(self.detailModel.kind),
                                      @"salonType":kUnNilStr(self.detailModel.activityType),
                                      @"projectId":kUnNilStr(self.detailModel.projectId ),
                                      @"companyId":kStrWithInter(self.detailModel.companyId),
                                      @"clientId":kStrWithInter(self.detailModel.clientId)}};

        url= [NSString stringWithFormat:kMGDefaultURL,kMGBookSetListInitScheduleUrl,[dicPost JSONString]];

    }else{
        dicPost   = @{@"status":MGGetStatusDicHaveUserName(),
                      @"object":@{@"taskId":kUnNilStr(self.taskMode.id),
                                  @"flightId":kUnNilStr(self.model.id),
                                  @"advanceFlag":kStrWithInter(self.detailModel.advanceFlag),
                                  @"salonName":kUnNilStr(self.detailModel.activityName),
                                  @"description":kUnNilStr(self.detailModel.comment),
                                  @"clientName":kUnNilStr(self.detailModel.clientName),
                                  @"subjectId":kUnNilStr(self.model.subjectId),
                                  @"salonId":kUnNilStr(self.detailModel.activityId),
                                  @"expenseType":kStrWithInter(self.detailModel.kind),
                                  @"salonType":kUnNilStr(self.detailModel.activityType),
                                  @"projectId":kUnNilStr(self.detailModel.projectId ),
                                  @"companyId":kStrWithInter(self.detailModel.companyId),
                                  @"clientId":kStrWithInter(self.detailModel.clientId)}};
        url= [NSString stringWithFormat:kMGDefaultURL,kMGTravelSetListInitScheduleUrl,[dicPost JSONString]];

    }
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [T2THttpManager getWithUrl:url success:^(T2TResponse *responseObject) {
        [hub hide:YES];
        if (responseObject.code == kMGOkStatuCode) {
            [T2TView showOKHUDWithText:@"创建成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [T2TView showFailHUDWithHUD:hub text:responseObject.reson];
        }
        NSLog(@"responseObject===%@",responseObject);
    } failure:^(id error) {
        [hub hide:YES];
        [T2TView showFailHUDWithText:@"创建失败"];
        NSLog(@"error===%@",error);
    } otherHttpHeader:MGGetOtherHttpHear()];
}



#pragma mark - tableDelegateAndDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrTasker.count + 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak costViewController *weakSelf =self;
    if (indexPath.row == 0){
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        [cell setLblFirHandle:^{
            MGSelectedCompanyVc *cvc = [[MGSelectedCompanyVc alloc] init];
            [cvc setSelectedHandle:^(MGCommpanyModel *model) {
                if (model.denfineValue != self.detailModel.companyId) {
                    weakSelf.detailModel.deptId = 0;
                    weakSelf.detailModel.deptName = nil;
                }
                weakSelf.detailModel.companyName = model.denfineName;
                weakSelf.detailModel.companyId = model.denfineValue;
                [tableView reloadData];
            }];
            [weakSelf.navigationController pushViewController:cvc animated:YES];
        }];
        
        [cell setLblSecHandle:^{
            MGSelectedSchduleTypeVc *cvc = [[MGSelectedSchduleTypeVc alloc] init];
            [cvc setHandleBlock:^(MGProjectTypeModel *model) {
                weakSelf.detailModel.kind = model.denfineValue;
                weakSelf.detailModel.kindName = model.denfineName;
                [tableView reloadData];
            }];
            cvc.type = 1;
            if (weakSelf.detailModel.companyName.length==0) {
                [T2TView showFailHUDWithText:@"请先选择公司"];
                return;
            }
            [weakSelf.navigationController pushViewController:cvc animated:YES];
            
        }];
        
        if (self.detailModel.companyId == 0) {
            
            [cell setLblFirPlahodler:@"公司"];
        } else {
            
            [cell resetLblFir];
            cell.lblFir.text = self.detailModel.companyName;
        }
        
        if (self.detailModel.kind == 0) {
            [cell setLblSecPlahodler:@"选择类别"];
        } else {
            
            [cell resetLblSec];
            cell.lblSec.text = self.detailModel.kindName;
        }
        
        return cell;
        
    }else if (indexPath.row == 1){
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if (self.detailModel.projectId == 0) {
            cell.placeholder = @"选择项目";
        } else {
            [cell resetCell];
            cell.lblContent.text = self.detailModel.projectName;
        }
        return cell;
    }else if (indexPath.row == 2){
        
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if ([self.taskMode.id intValue]==0) {
            cell.placeholder = @"选择任务";
        } else {
            [cell resetCell];
            cell.lblContent.text = self.taskMode.taskName;
        }
        return cell;
        
        
    }else if (indexPath.row == 3){
        if (self.detailModel.kind==4) {
            MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
            if (self.detailModel.activityId == 0) {
                cell.placeholder = @"选择活动";
            } else {
                [cell resetCell];
                cell.lblContent.text = self.detailModel.activityName;
            }
            return cell;
 
        }else{
            MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if (self.detailModel.clientId == 0) {
            cell.placeholder = @"选择客户";
        } else {
            [cell resetCell];
            cell.lblContent.text = self.detailModel.clientName;
        }
        return cell;
        }
        
    }else if (indexPath.row==4){
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        cell.lblFir.text =kUnNilStr(locationString) ;
        cell.lblSec.text =[NSString stringWithFormat:@"%.2f",[self.model.price floatValue]];
        [cell hidenRightRowImav];
        self.detailModel.currentTime =kUnNilStr(locationString);
        self.detailModel.taskPrice = kUnNilStr(cell.lblSec.text);
        
        return cell;
        
    }else if (indexPath.row==5){
        
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        
        if (self.isBook) {
            
            cell.lblFir.text  = [NSString stringWithFormat:@"教具费:%.2f",[self.Bookmodel.toolsAmount floatValue]];
            cell.lblSec.text =[NSString stringWithFormat:@"快递费:%.2f",[self.Bookmodel.expressAmount floatValue]];
            [cell hidenRightRowImav];
            
        }else{
            
            if ([self.model.subjectId integerValue]==23) {
                cell.lblFir.text = @"交通费";
                
            }else if([self.model.subjectId integerValue]==26){
                cell.lblFir.text = @"住宿费";
                
            }else{
                cell.lblFir.text = @"机票款";
                
            }
            self.detailModel.expenseType =kUnNilStr(cell.lblFir.text);
            self.detailModel.count =1;
            cell.imavFir.hidden = YES;
            [cell setLblSecHandle:^{
                BoolViewController *vc= [[BoolViewController alloc] init];
                vc.selectStr  = ^(NSString *str){
                    weakSelf.string = str;
                    if ([str isEqualToString:@"是"]) {
                        weakSelf.detailModel.advanceFlag = 1;
                    }else{
                        weakSelf.detailModel.advanceFlag = 0;
                    }
                    [tableView reloadData];
                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }];
            cell.lblSec.text = [NSString stringWithFormat:@"%@",self.string];
        }
        return cell;
        
        
    }else if (indexPath.row == 6){
        MGTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTextFiledCellClassName];
        [cell setTextFiledTextChangeHandle:^(id error) {
            weakSelf.detailModel.comment = error;
        }];
        cell.textFiled.placeholder = @"费用说明";
        return cell;
    }
    MGTaskerCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTaskerCellClassName];
    if (self.arrTasker.count > 0) {
        [cell setUIValueWithModel:self.arrTasker[indexPath.row-7]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.detailModel.kind==1) {
        
    }else if(self.detailModel.kind==2){
        if (indexPath.row==1||indexPath.row==2) {
            return 0;
        }
    }else if(self.detailModel.kind==3){
        if (indexPath.row==1||indexPath.row==2||indexPath.row==3) {
            return 0;
        }
    }else if(self.detailModel.kind==4){
        if (indexPath.row==1||indexPath.row==2) {
            return 0;
        }
    }
    if (self.isBook) {
        if (indexPath.row==4) {
            return 0;
        }
    }
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    __weak costViewController *blockSelf =self;
    if (self.detailModel.kindName.length==0) {
        [T2TView showFailHUDWithText:@"请先选择类别"];
        return;
    }

    if (indexPath.row == 1) {
        MGSelectProjectVc *pvc = [[MGSelectProjectVc alloc] init];
        [pvc setSelectedHandle:^(MGProjectModel *model) {
            blockSelf.detailModel.projectId = kStrWithInter(model.projectId);
            blockSelf.detailModel.projectName = model.projectName;
            blockSelf.detailModel.clientName = model.clientName;
            blockSelf.detailModel.clientId = model.clientId;
            if (blockSelf.taskMode.taskName) {
                blockSelf.taskMode.id = @"0";
                blockSelf.taskMode.taskName =  @"";
            }
            [tableView reloadData];
        }];
        
        [self.navigationController pushViewController:pvc animated:YES];
    }else if (indexPath.row == 2){
        
        taskViewController *vc =[[taskViewController alloc]init];
        vc.detailModel = blockSelf.detailModel;
        vc.taskcode = ^(taskMode *model){
            blockSelf.taskMode = model;
            [tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 3) {
        if (self.detailModel.kind==1) {
            return;
        }
        if (self.detailModel.companyName.length==0) {
            [T2TView showFailHUDWithText:@"请先选择项目"];
            return;
        }
        if (self.detailModel.kind==4) {
            MGSelectedActivityVc *avc = [[MGSelectedActivityVc alloc] init];
            [avc setSelectedActivityHandle:^(id obj, int indexTypeSelected) {
                if (indexTypeSelected == 1) {
                    MGActivetyOfEnrollmentModel *model = obj;
                    blockSelf.detailModel.activityId = kStrWithInter(model.activityId);
                    blockSelf.detailModel.activityName = model.activityName;
                    blockSelf.detailModel.activityType = @"1";
                } else {
                    MGActivetyOfExhibition *model = obj;
                    blockSelf.detailModel.activityId = kStrWithInter(model.expositionId);
                    blockSelf.detailModel.activityName = model.expositionName;
                    blockSelf.detailModel.activityType = @"2";
                    
                }
                [tableView reloadData];
            }];
            [self.navigationController pushViewController:avc animated:YES];
            return;
        }else{
        MGSelectedClientVc *cvc = [[MGSelectedClientVc alloc] init];
        [cvc setSelectHanle:^(MGClientModel *model) {
            blockSelf.detailModel.clientId = model.clientId;
            blockSelf.detailModel.clientName = model.clientName;
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:cvc animated:YES];
        
        }
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
