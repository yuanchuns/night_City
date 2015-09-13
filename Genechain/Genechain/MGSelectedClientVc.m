//
//  MGSelectedClientVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/12.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSelectedClientVc.h"
#import "MGClientCell.h"
@interface MGSelectedClientVc ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, copy) T2TObjBlock objBlock;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, weak) UITextField *textFiled;
@end

@implementation MGSelectedClientVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择客户";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNibName:MGClientCellClassName forCellReuseIdentifier:MGClientCellClassName];
      MGUserModel *model = [MGUserModel shareMGUserModel];
    self.clientName = model.loginName;
    
    self.clientName = @"";
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = @"客户/负责人";
    self.textFiled = text;
    text.delegate = self;
    text.returnKeyType = UIReturnKeySearch;
    
    UIBarButtonItem *bar= [[UIBarButtonItem alloc] initWithCustomView:text];
    self.navigationItem.rightBarButtonItem = bar;
    // Do any additional setup after loading the view.
}

- (void)setSelectHanle:(T2TObjBlock)objBlock {

    self.objBlock = objBlock;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
//    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
        self.clientName = self.textFiled.text;
        [self startPullDownRefreshing];
//    }
    return YES;
}

#pragma mark - overRide

- (NSString *)getRequestUrlStr {

    MGUserModel *model = [MGUserModel shareMGUserModel];
    
    if(!self.clientName ) self.clientName = @"";
    NSDictionary *dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"pageNo":@(self.curIndex),@"employeeName":kUnNilStr(model.loginName),@"clientName":self.clientName}};
    NSString *urlStr = [NSString stringWithFormat:kMGDefaultURL,kMGClientSelectedUrl,[dicPost JSONString]];
    
    return urlStr;
}

- (void)handleContentResponse:(T2TResponse *)content {

    if (content.code == kMGOkStatuCode && [content.list isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dicIndo in content.list) {
            MGClientModel *model = [[MGClientModel alloc] initWithDic:dicIndo];
            [self.arrData addObject:model];
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [self.view endEditing:YES];
    [self.textFiled resignFirstResponder];
}

#pragma mark - tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MGClientCell *cell = [tableView dequeueReusableCellWithIdentifier:MGClientCellClassName];
    if (self.arrData.count > indexPath.row) {
        [cell setUIValueWithModel:self.arrData[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.arrData.count > indexPath.row) {
        return [MGClientCell getCellHeightWithModel:self.arrData[indexPath.row]];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    (!self.objBlock) ?: self.objBlock(self.arrData[indexPath.row]);
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
