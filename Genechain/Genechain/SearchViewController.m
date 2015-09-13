//
//  SearchViewController.m
//  Genechain
//
//  Created by nextone on 15/8/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "SearchViewController.h"
#import "MGOneBoxCell.h"
#import "MGTextFiledCell.h"
#import "T2TDatePikerActionSheet.h"
#import "MGSelectedSchduleTypeVc.h"
#import "MGSelectedDeptVc.h"
#import "MGSchudleDetailModel.h"
#import "ListVC.h"


@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>



@property(strong,nonatomic)UITableView *tableView;
//@property(copy,nonatomic)NSString *DateSelect;
//@property(copy,nonatomic)NSString *userName;
//@property(copy,nonatomic)NSString *deptName;


@end

@implementation SearchViewController

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
//- (void)setOkHandle:(T2TObjBlock)dicInfo{
//
//    self.dicBlock = dicInfo;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"查询条件";
    
    self.detailModel =[[MGSchudleDetailModel alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNibName:MGOneBoxCellClassName forCellReuseIdentifier:MGOneBoxCellClassName];
    [self.tableView registerNibName:MGTextFiledCellClassName forCellReuseIdentifier:MGTextFiledCellClassName];
    //    self.dicSelected = [NSMutableDictionary dictionary];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.isBook) {
        return 3;
        
    }else {
        return 5;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isBook) {
        if (indexPath.row == 0) {
            MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
            if ([self.detailModel.startDate isKindOfClass:[NSString class]]) {
                [cell resetCell];
                cell.lblContent.text = self.detailModel.startDate;
            }else{
                [cell setPlaceholder:@"请选年月"];
                
            }
            [cell setLongGesHandle:^{
                self.detailModel.startDate = nil;
                [tableView reloadData];
            }];
            
            return cell;
        }else if (indexPath.row == 1){
            MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
            
            if ([self.detailModel.deptName isKindOfClass:[NSString class]]) {
                cell.lblContent.text = self.detailModel.deptName;
            }else{
                cell.placeholder = @"选择部门";
            }
            [cell setLongGesHandle:^{
                self.detailModel.deptId = 0;
                self.detailModel.deptName = nil;
                [tableView reloadData];
            }];
            return cell;
            
            
        }
        
        MGTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTextFiledCellClassName];
        cell.textFiled.tag = indexPath.row;
        cell.textFiled.delegate = self;
        if ([self.detailModel.clientName isKindOfClass:[NSString class]]) {
            cell.textFiled.text = self.detailModel.clientName;
        }else{
            cell.textFiled.placeholder = @"领用人";
        }
        [cell.textFiled addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
        
        
        
        
    }else{
        
        
        
        if (indexPath.row == 0) {
            MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
            if ([self.detailModel.userName isKindOfClass:[NSString class]]) {
                [cell resetCell];
                cell.lblContent.text = self.detailModel.userName;
            }else{
                [cell setPlaceholder:@"选择类别"];
            }
            [cell setLongGesHandle:^{
                self.detailModel.userName = nil;
                [tableView reloadData];
            }];
            return cell;
        }else if (indexPath.row == 1){
            
            MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
            if ([self.detailModel.startDate isKindOfClass:[NSString class]]) {
                [cell resetCell];
                cell.lblContent.text = self.detailModel.startDate;
            }else{
                [cell setPlaceholder:@"请选日期"];
                
            }
            [cell setLongGesHandle:^{
                self.detailModel.startDate = nil;
                [tableView reloadData];
            }];
            
            return cell;
        }else if(indexPath.row == 2){
            MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
            
            if ([self.detailModel.deptName isKindOfClass:[NSString class]]) {
                
                cell.lblContent.text = self.detailModel.deptName;
            }else{
                cell.placeholder = @"选择部门";
            }
            [cell setLongGesHandle:^{
                self.detailModel.deptId = 0;
                self.detailModel.deptName = nil;
                [tableView reloadData];
            }];
            return cell;
            
        }else if (indexPath.row == 3){
            MGTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTextFiledCellClassName];
            cell.textFiled.tag = indexPath.row;
            cell.textFiled.delegate = self;
            if ([self.detailModel.clientName isKindOfClass:[NSString class]]) {
                cell.textFiled.text = self.detailModel.clientName;
            }else{
                cell.textFiled.placeholder = @"输入客户名称";
            }
            [cell.textFiled addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
            return cell;
        }
        MGTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTextFiledCellClassName];
        cell.textFiled.tag = indexPath.row;
        cell.textFiled.delegate = self;
        if ([self.detailModel.taskName isKindOfClass:[NSString class]]) {
            cell.textFiled.text = self.detailModel.taskName;
        }else{
            cell.textFiled.placeholder = @"输入任务人";
        }
        [cell.textFiled addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.isBook) {
        if (indexPath.row == 0) {
            NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
            [dateForMatter setDateFormat:@"yyyyMM"];
            [self setDatePicview:dateForMatter type:1];
        }else if (indexPath.row == 1){
                       
            MGSelectedDeptVc *msc = [[MGSelectedDeptVc alloc] init];
            [msc setHandleSlected:^(MGDepartmentModel *model) {
                MGOneBoxCell *cell = (MGOneBoxCell *)[tableView cellForRowAtIndexPath:indexPath];
                [cell resetCell];
                cell.lblContent.text = kUnNilStr(model.deptName);
                self.detailModel.deptId = model._id;
                self.detailModel.deptName = model.deptName;
                
            }];
            [self.navigationController pushViewController:msc animated:YES];
        }
    }else{
    if (indexPath.row == 0) {
        
        ListVC *vc =[[ListVC alloc] init];
        vc.selectStr=^(NSString *str){
            MGOneBoxCell *cell = (MGOneBoxCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell resetCell];
            cell.lblContent.text = str;
            if ([str isEqualToString:@"机票"]) {
                self.detailModel.subjectId = @"7";
                
            }else if ([str isEqualToString:@"火车票"]){
                self.detailModel.subjectId = @"23";

            }else{
                self.detailModel.subjectId = @"26";
            }
            self.detailModel.userName =str;
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1){
        NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
        [dateForMatter setDateFormat:@"yyyyMM"];
        [self setDatePicview:dateForMatter type:1];

        
        
    }else if (indexPath.row == 2){
        
        MGSelectedDeptVc *msc = [[MGSelectedDeptVc alloc] init];
        [msc setHandleSlected:^(MGDepartmentModel *model) {
            MGOneBoxCell *cell = (MGOneBoxCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell resetCell];
            cell.lblContent.text = kUnNilStr(model.deptName);
            self.detailModel.deptId = model._id;
            self.detailModel.deptName = model.deptName;
            
        }];
        [self.navigationController pushViewController:msc animated:YES];
        
    }
   }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    T2TButton *btn = [T2TButton btnWithFrame:CGRectMake(10, 0, kScreenWidth-20, 45) Img:kMGBtnColorIma];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionBtnOk) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 45;
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y < 0) {
        [self.view endEditing:YES];
    }
}

#pragma mark - textFiledDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    CGRect rect = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    [self.tableView setContentOffset:rect.origin animated:NO];
    return YES;
}

- (void)textFiledEditChange:(UITextField *)textFiled {
    
    if (textFiled.tag == 3) {
        self.detailModel.clientName = textFiled.text;
    } else {
        self.detailModel.taskName = textFiled.text;
    }
}

- (void)actionBtnOk{
    
    self.detailModel.type = self.type;
    self.detailModel.isSearch = @"1";
    (!self.answerBlock) ?:self.answerBlock(self.detailModel);
    [self navBackAction:nil];
    
}

#pragma mark - privateFunc
- (void)setDatePicview:(NSDateFormatter *)dateFormatter type:(int)type{
    
    __weak SearchViewController *weakSelf =self;
    T2TDatePikerActionSheet *sheet = [[T2TDatePikerActionSheet alloc] init];
    sheet.datePicker.minimumDate = [NSDate date];
    
    sheet.format = dateFormatter;
    [sheet setSelectedBlock:^(NSDictionary *dict) {
        if (type == 1) {
            weakSelf.detailModel.startDate = dict[kDateStrKey];
            weakSelf.detailModel.endDate = nil;
        }else{
            weakSelf.detailModel.startDate = nil;
            weakSelf.detailModel.endDate =dict[kDateStrKey];
        }
        [weakSelf.tableView reloadData];
    }];
    [sheet showInView:kCurrentWindow];
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
