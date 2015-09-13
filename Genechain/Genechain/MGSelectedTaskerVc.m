//
//  MGSelectedTaskerVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSelectedTaskerVc.h"
#import "EAskSelectTypeBar.h"
@interface MGSelectedTaskerVc ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, assign) int indexSelect;
@property (nonatomic, copy) NSString *employeeName;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) T2TObjBlock objBlock;
@end

@implementation MGSelectedTaskerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人员列表";
    EAskSelectTypeBar *selectbar = [EAskSelectTypeBar loadNibNamed:EAskSelectTypeBarClassName owner:nil options:nil];
    selectbar.frame = CGRectMake(0, 0, kScreenWidth, 40);
    [selectbar.btnOneBox setTitle:@"员工" forState:UIControlStateNormal];
    [selectbar.btnTwoBox setTitle:@"外部" forState:UIControlStateNormal];
    [selectbar setSelectedHandle:^(selectedType type) {
        self.indexSelect = type;
        [MGLodingView removeFromSuperView:self.tableView];
        [MGLodingView showLodingViewOn:self.tableView withEditBlock:nil withRefreshBlock:^{
            [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.tableView];
            [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
        }];
        [self requestData];
    }];
    [self.view addSubview:selectbar];
    self.indexSelect = 1;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, selectbar.bottom, kScreenWidth, kScreenHeight-40-kNavBarHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView registerNibName:MGEmployeeCellClassName forCellReuseIdentifier:MGEmployeeCellClassName];
    self.indexSelect = 1;
    
    [MGLodingView showLodingViewOn:self.tableView withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.tableView];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
    }];
    [self requestData];
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = @"姓名";
    self.textField = text;
    text.delegate = self;
    text.returnKeyType = UIReturnKeySearch;
    
    UIBarButtonItem *bar= [[UIBarButtonItem alloc] initWithCustomView:text];
    self.navigationItem.rightBarButtonItem = bar;
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    //    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
    self.employeeName = self.textField.text;
    [MGLodingView removeFromSuperView:self.tableView];
    [MGLodingView showLodingViewOn:self.tableView withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.tableView];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
    }];
    [self requestData];
    
    //    }
    return YES;
}

- (void)requestData {

    self.arrData = [NSMutableArray array];
     NSDictionary *dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"employeeName":kUnNilStr(self.employeeName)}};
    
    NSString *urlStr = [NSString stringWithFormat:kMGDefaultURL,(self.indexSelect == 1)?kMGEmployeeSelectedUrl:kMGEmployeeSelectedUrl_Teacher,[dicPost JSONString]];
    
    [T2THttpManager getWithUrl:urlStr success:^(T2TResponse *responseObject) {
       
        if ([responseObject.list isKindOfClass:[NSArray class]] && responseObject.code == kMGOkStatuCode) {
          [MGLodingView removeFromSuperView:self.tableView];
            for (NSDictionary *dicInfo in responseObject.list) {
                MGEmployeeModel *model = [[MGEmployeeModel alloc] initWithDic:dicInfo];
                [self.arrData addObject:model];
                [self.tableView reloadData];
            }
            
        } else {
        [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.tableView];
        }
        
    } failure:^(id error) {
        [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.tableView];
    } otherHttpHeader:MGGetOtherHttpHear()];
    
}

- (void)setSelectedEmployModelHandle:(T2TObjBlock)objBlock {

    self.objBlock = objBlock;
}

- (void)actionBtn:(UIButton *)btn {
    
    self.indexSelect = (int)btn.tag;
    [MGLodingView removeFromSuperView:self.tableView];
    [MGLodingView showLodingViewOn:self.tableView withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.tableView];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
    }];
    [self requestData];
    
}


#pragma mark - tableDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGEmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:MGEmployeeCellClassName];
    if (self.arrData.count > indexPath.row) {
        [cell setUIValueWithModel:self.arrData[indexPath.row]];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    (!self.objBlock) ?:self.objBlock(self.arrData[indexPath.row]);
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
