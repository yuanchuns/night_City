//
//  MGSelectProjectVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/12.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSelectProjectVc.h"
#import "MGProjectCell.h"
@interface MGSelectProjectVc ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) T2TObjBlock objBlock;
@property (nonatomic, weak) UITextField *textFiled;
@end

@implementation MGSelectProjectVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部项目";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNibName:MGProjectCellClassName forCellReuseIdentifier:MGProjectCellClassName];
    
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

- (void)setSelectedHandle:(T2TObjBlock)objBlock {

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
    [self.textFiled resignFirstResponder];
}

#pragma mark - override
- (NSString *)getRequestUrlStr {



    NSDictionary *dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"pageNo":@(self.curIndex),@"clientName":kUnNilStr(self.clientName)}};
    NSString *urlStr = [NSString stringWithFormat:kMGDefaultURL,kMGProjectSelectUrl,[dicPost JSONString]];
    return urlStr;
}

- (void)handleContentResponse:(T2TResponse *)content {

    if (content.code == kMGOkStatuCode && [content.list isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dicInfo in content.list) {
            MGProjectModel *model = [[MGProjectModel alloc] initWithDic:dicInfo];
            [self.arrData addObject:model];
        }
    }
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MGProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:MGProjectCellClassName];
    if (self.arrData.count > indexPath.row) {
        [cell setUIValueWithModel:self.arrData[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.arrData.count > indexPath.row) {
        
        return [MGProjectCell getCellHeightWithModel:self.arrData[indexPath.row]];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    (!self.objBlock) ?:self.objBlock (self.arrData[indexPath.row]);
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
