//
//  MGSchduleQueryVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSchduleQueryVc.h"
#import "MGOneBoxCell.h"
#import "MGTextFiledCell.h"
#import "T2TDatePikerActionSheet.h"
#import "MGSelectedSchduleTypeVc.h"
#import "MGSelectedDeptVc.h"
#import "MGSchudleDetailModel.h"
@interface MGSchduleQueryVc ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableDictionary *dicSelected;
@property (nonatomic, copy) T2TObjBlock dicBlock;

@end

@implementation MGSchduleQueryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询条件";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
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
//    self.detailModel = [[MGSchudleDetailModel alloc] init];
    
//    self.navigationItem.rightBarButtonItem = [T2TView unborderItemWithTarget:self act:@selector(actionRightBar) title:@"清空" textColor:[UIColor whiteColor] textHColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)setOkHandle:(T2TObjBlock)dicInfo{

    self.dicBlock = dicInfo;
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if ([self.detailModel.startDate isKindOfClass:[NSString class]]) {
            [cell resetCell];
            cell.lblContent.text = self.detailModel.startDate;
        }else{
        [cell setPlaceholder:@"请选择月份"];
        }
        [cell setLongGesHandle:^{
            self.detailModel.startDate = nil;
            [tableView reloadData];
        }];
        return cell;
    }else if (indexPath.row == 1){
    
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if ([self.detailModel.endDate isKindOfClass:[NSString class]]) {
            [cell resetCell];
            cell.lblContent.text = self.detailModel.endDate;
        }else{
            [cell setPlaceholder:@"请选择日"];
            
        }
        [cell setLongGesHandle:^{
            self.detailModel.endDate = nil;
            [tableView reloadData];
        }];
        return cell;
    }else if(indexPath.row == 2){
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        if ([self.detailModel.kindName isKindOfClass:[NSString class]]) {
            [cell resetCell];
            cell.lblContent.text = self.detailModel.kindName;
        }else{
        cell.placeholder = @"选择日程类别";
        }
        
        [cell setLongGesHandle:^{
            self.detailModel.kind = 0;
            self.detailModel.kindName = nil;
            [tableView reloadData];
        }];
        
        return cell;
    }else if (indexPath.row == 3){
        MGTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTextFiledCellClassName];
        cell.textFiled.tag = indexPath.row;
        cell.textFiled.delegate = self;
        if ([self.detailModel.clientName isKindOfClass:[NSString class]] && self.detailModel.clientName.length > 0) {
            cell.textFiled.text = self.detailModel.clientName;
        }else{
            cell.textFiled.text = nil;
           cell.textFiled.placeholder = @"输入客户名称";
        }
        [cell.textFiled addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }else if(indexPath.row == 4){
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
    if ([self.detailModel.taskName isKindOfClass:[NSString class]] && self.detailModel.taskName.length > 0) {
        cell.textFiled.text = self.detailModel.taskName;
    }else{
        cell.textFiled.text = nil;
         cell.textFiled.placeholder = @"输入任务人";
    }
    [cell.textFiled addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
         [dateForMatter setDateFormat:@"yyyyMM"];
        [self setDatePicview:dateForMatter type:1];
    }else if (indexPath.row == 1){
        NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
        [dateForMatter setDateFormat:@"yyyyMMdd"];
        [self setDatePicview:dateForMatter type:2];
        
    }else if (indexPath.row == 2){
    
        MGSelectedSchduleTypeVc *svc = [[MGSelectedSchduleTypeVc alloc] init];
        [svc setHandleBlock:^(MGProjectTypeModel *model) {
            MGOneBoxCell *cell = (MGOneBoxCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell resetCell];
            cell.lblContent.text = model.kindName;

            self.detailModel.kind = model.kindId;
            self.detailModel.kindName = model.kindName;
            
        }];
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (indexPath.row == 4){
    
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

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//
//    if (textField.tag == 3) {
////        [self.dicSelected setObject:kUnNilStr(textField.text) forKey:clientNameKey];
//        self.detailModel.clientName = textField.text;
//    }else{
////        [self.dicSelected setObject:kUnNilStr(textField.text) forKey:taskerNameKey];
//
//    }
//}

#pragma mark - action
- (void)actionRightBar {
    
    self.detailModel = [[MGSchudleDetailModel alloc] init];
//    self.dicSelected = [NSMutableDictionary dictionary];
    [self.tableView reloadData];
    [self actionBtnOk];
}

- (void)actionBtnOk{
    (!self.dicBlock) ?:self.dicBlock(self.detailModel);
    [self navBackAction:nil];

}

#pragma mark - privateFunc
- (void)setDatePicview:(NSDateFormatter *)dateFormatter type:(int)type{

    T2TDatePikerActionSheet *sheet = [[T2TDatePikerActionSheet alloc] init];
    sheet.datePicker.minimumDate = [NSDate date];
    
    sheet.format = dateFormatter;
    [sheet setSelectedBlock:^(NSDictionary *dict) {
        if (type == 1) {
//            [self.dicSelected setObject:dict[kDateStrKey] forKey:yearMonthKey];
//            [self.dicSelected setObject:@"" forKey:yearMonthDayKey];
            self.detailModel.startDate = dict[kDateStrKey];
            self.detailModel.endDate = nil;
        }else{
//            [self.dicSelected setObject:dict[kDateStrKey] forKey:yearMonthDayKey];
            self.detailModel.endDate = dict[kDateStrKey];
            self.detailModel.startDate = nil;
//            [self.dicSelected setObject:@"" forKey:yearMonthKey];
        }
        [self.tableView reloadData];
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
