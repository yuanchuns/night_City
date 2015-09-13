//
//  MGSelectedCompanyVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/15.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSelectedCompanyVc.h"
#import "MGCommpanyModel.h"
@interface MGSelectedCompanyVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic, copy) T2TObjBlock objBlock;
@end

@implementation MGSelectedCompanyVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
    }];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)setSelectedHandle:(T2TObjBlock)objBlock {

    self.objBlock = objBlock;
}

- (void)requestData {

//     http://223.4.94.140:8091/pm/appDept!d100CompayList.action?word={"status":{"userName":"伍然","beanName":"status","parameter":"2","ver":"1.0.0","sessionId":"C254240C1285B11110A0A10005A9CEE1","loginName":"wuran"}
    self.arrData = [NSMutableArray array];
    [T2THttpManager getWithUrl:[NSString stringWithFormat:kMGDefaultURL,kMGCommpanyUrl,[@{@"status":MGGetStatusDicHaveUserName()} JSONString]] success:^(T2TResponse *responseObject) {
        
        if (responseObject.code == kMGOkStatuCode && [responseObject.list isKindOfClass:[NSArray class]]) {
            [MGLodingView removeFromSuperView:self.view];
            for (NSDictionary *dicInfo in responseObject.list) {
                MGCommpanyModel *model = [[MGCommpanyModel alloc] initWithDic:dicInfo];
                [self.arrData addObject:model];
            }
            [self.tableView reloadData];
        }else {
            [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
        }
        
    } failure:^(id error) {
        
        [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
        
    } otherHttpHeader:MGGetOtherHttpHear()];
    
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell adjustSeparator];
    if (self.arrData.count > indexPath.row) {
        MGCommpanyModel *model = self.arrData[indexPath.row];
        cell.textLabel.text = model.denfineName;
    }
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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
