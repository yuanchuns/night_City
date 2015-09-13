//
//  MGMineTaskVc.m
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMineTaskVc.h"
#import "T2TActionTaskVc.h"
#import "MGMineTaskCell.h"
@interface MGMineTaskVc ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) NSString *clientName;
@end

@implementation MGMineTaskVc

#pragma mark - vcLifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的任务";
    self.tableView.height -= kTabBarHeight;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNibName:MGMineTaskCellClassName forCellReuseIdentifier:MGMineTaskCellClassName];
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = @"客户名称";
    self.textFiled = text;
    text.delegate = self;
    text.returnKeyType = UIReturnKeySearch;
    UIBarButtonItem *bar= [[UIBarButtonItem alloc] initWithCustomView:text];
    self.navigationItem.rightBarButtonItem = bar;
    // Do any additional setup after loading the view.
}

#pragma mark - textFiledDelgate 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    //    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
    self.clientName = self.textFiled.text;
    [self startPullDownRefreshing];
    //    }
    return YES;
}

#pragma mark - override

- (NSString *)getRequestUrlStr{
    //http://223.4.94.140:8091/pm/appTask!p201MyTaskList.action?word={"status":{"userName":"伍然","beanName":"status","parameter":"2","ver":"1.0.0","sessionId":"C9C5F778A2419EE36C2EACA9BD4B13D8","loginName":"wuran"},"object":{"pageNo":1,"clientName":""}}
//    NSString *indexStr = [NSString stringWithFormat:@"%ld",self.curIndex];
    NSString *str = [NSString stringWithFormat:kMGDefaultURL,kMGMineTaskUrl,[@{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"pageNo":@(self.curIndex),@"clientName":kUnNilStr(self.clientName)}} JSONString]];
    return str;
}

- (void)handleContentResponse:(T2TResponse *)content{

    if ([content.list isKindOfClass:[NSArray class]] && content.code == kMGOkStatuCode) {
        for (NSDictionary *dic in content.list) {
            MGMineTaskModel *model = [[MGMineTaskModel alloc] initWithDic:dic];
            [self.arrData addObject:model];
        }
    }
}


#pragma mark - privateFunc
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - tableViewDelegateAndDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MGMineTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:MGMineTaskCellClassName];
    if (self.arrData.count > indexPath.row) {
        [cell setUIValueWithModel:self.arrData[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.arrData.count > indexPath.row) {
        return [MGMineTaskCell getCellHeightWithModel:self.arrData[indexPath.row]];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MGMineTaskModel *model = self.arrData[indexPath.row];
    T2TActionTaskVc *tvc = [[T2TActionTaskVc alloc] initWithNibName:@"T2TActionTaskVc" bundle:nil];
    tvc.taskId = model._id;
    [tvc setHandleBlock:^{
        [self.arrData removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }];
    [self.navigationController pushViewController:tvc animated:YES];
    
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
