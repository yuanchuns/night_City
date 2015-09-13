//
//  MGSelectedActivityVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSelectedActivityVc.h"
#import "EAskSelectTypeBar.h"
@interface MGSelectedActivityVc ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, assign) int indexSelect;
@property (nonatomic, strong) selectedActivityBlock objBlock;
@property (nonatomic, weak) UITextField *textFiled;
@property (nonatomic, copy) NSString *clientName;
@end

@implementation MGSelectedActivityVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动选择";
    
    EAskSelectTypeBar *selectbar = [EAskSelectTypeBar loadNibNamed:EAskSelectTypeBarClassName owner:nil options:nil];
    selectbar.frame = CGRectMake(0, 0, kScreenWidth, 40);
    [selectbar.btnOneBox setTitle:@"招生" forState:UIControlStateNormal];
    [selectbar.btnTwoBox setTitle:@"展会" forState:UIControlStateNormal];
    [selectbar setSelectedHandle:^(selectedType type) {
        self.indexSelect = type;
        [self.arrData removeAllObjects];
        [self startPullDownRefreshing];
    }];
    [self.view addSubview:selectbar];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btn setTitle:@"招生" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
//    btn.tag = 1;
//    btn.frame = CGRectMake(0, 0, kScreenWidth/2, 40);
//    [self.view addSubview:btn];
//    
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btn1 setTitle:@"展会" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
//    btn1.tag = 2;
//    btn1.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 40);
//    [self.view addSubview:btn1];
    
    self.indexSelect = 1;
    
    [self.tableView registerNibName:MGActivityCellClassName forCellReuseIdentifier:MGActivityCellClassName];
    self.tableView.top = 40;
    self.tableView.height -= 40;
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = @"活动名称";
    self.textFiled = text;
    text.delegate = self;
    text.returnKeyType = UIReturnKeySearch;
    
    UIBarButtonItem *bar= [[UIBarButtonItem alloc] initWithCustomView:text];
    self.navigationItem.rightBarButtonItem = bar;
    // Do any additional setup after loading the view from its nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
    [self.textFiled resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
//    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
        self.clientName = self.textFiled.text;
        [self startPullDownRefreshing];
//    }
    return YES;
}
- (void)actionBtn:(UIButton *)btn {

    self.indexSelect = (int)btn.tag;
    [self.arrData removeAllObjects];
    [self startPullDownRefreshing];
    
}

- (void)setSelectedActivityHandle:(selectedActivityBlock)objBlock {

    self.objBlock = objBlock;
}

#pragma mark - override

- (NSString *)getRequestUrlStr {
    MGUserModel *model = [MGUserModel shareMGUserModel];
    NSDictionary *dicInfo = @{@"activityName":kUnNilStr(self.clientName),@"pageNo":@(self.curIndex),@"loginName":kUnNilStr(model.loginName)};
    if (self.indexSelect == 2) {
        dicInfo = @{@"expositionName":kUnNilStr(self.clientName),@"pageNo":@(self.curIndex),@"loginName":kUnNilStr(model.loginName)};
    }
    NSDictionary *dicGet = @{@"status":MGGetStatusDicHaveUserName(),@"object":dicInfo};
    NSString *urlStr = [NSString stringWithFormat:kMGDefaultURL,(self.indexSelect == 1)?kMGActivitySelectedUrl_Action:kMGActivitySelectedUrl_Exposition,[dicGet JSONString]];
    return urlStr;
}

- (void)handleContentResponse:(T2TResponse *)content {

    
    if (content.code == kMGOkStatuCode && [content.list isKindOfClass:[NSArray class]]) {
        
            for (NSDictionary *dicInfo in content.list) {
                id model ;
                if (self.indexSelect == 1) {
                    model = [[MGActivetyOfEnrollmentModel alloc] initWithDic:dicInfo];
                } else {
             
                    model = [[MGActivetyOfExhibition alloc] initWithDic:dicInfo];
                }
                [self.arrData addObject:model];
            }
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:MGActivityCellClassName];
    if (self.arrData.count > indexPath.row) {
        if (self.indexSelect == 1) {
            [cell setUIValueWithEnrollmentModel:self.arrData[indexPath.row]];
        } else {
        
             [cell setUIValueWithExhibitionModel:self.arrData[indexPath.row]];
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.arrData.count > indexPath.row) {
        if (self.indexSelect == 1) {
            return [MGActivityCell getCellHeightWithEnrollmentModel:self.arrData[indexPath.row]];
        }
        
        return [MGActivityCell getCellHeightWithExhibitionModel:self.arrData[indexPath.row]];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    (!self.objBlock) ?: self.objBlock(self.arrData[indexPath.row],self.indexSelect);
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
