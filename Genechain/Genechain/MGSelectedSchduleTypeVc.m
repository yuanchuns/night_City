//
//  MGSelectedSchduleTypeVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSelectedSchduleTypeVc.h"
#import "MGProjectTypeModel.h"
@interface MGSelectedSchduleTypeVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, copy) T2TObjBlock objBlock;
@end

@implementation MGSelectedSchduleTypeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目类别";
    self.arrData = [NSMutableArray array];

    self.tableView  = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
    }];
    if (self.type==0) {
        [self requestData];

    }else{
        [self request_TravelSelectKind_Lsit_connection];

    }
    // Do any additional setup after loading the view.
}

- (void)setHandleBlock:(T2TObjBlock)objBlock{

    self.objBlock = objBlock;
}
//差旅选择类别
-(void)request_TravelSelectKind_Lsit_connection{
    
    [T2THttpManager getWithUrl:[NSString stringWithFormat:kMGDefaultURL,kMGTravel_Select_Kind_ScheduleUrl,[MGGetStatusDicHaveUserName() JSONString]] success:^(T2TResponse *responseObject) {
        if ([responseObject.list isKindOfClass:[NSArray class]] && responseObject.code == kMGOkStatuCode) {
            [MGLodingView removeFromSuperView:self.view];
            for (NSDictionary *dicInfo in responseObject.list) {
                MGProjectTypeModel *model = [[MGProjectTypeModel alloc] initWithDic:dicInfo];
                [self.arrData addObject:model];
            }
            [self.tableView reloadData];
             NSLog(@"responseObject===%@",responseObject);
        }else{
            
            [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
        }
        
    } failure:^(id error) {
        [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
    } otherHttpHeader:MGGetOtherHttpHear()];

}

- (void)requestData{

//    http://223.4.94.140:8091/pm/appSchedule!s100ScheduleKind.action?word={"status":{"userName":"伍然","beanName":"status","parameter":"2","ver":"1.0.0","sessionId":"C254240C1285B11110A0A10005A9CEE1","loginName":"wuran"}}
    

    [T2THttpManager getWithUrl:[NSString stringWithFormat:kMGDefaultURL,KMGProjectTypeUrl,[MGGetStatusDicHaveUserName() JSONString]] success:^(T2TResponse *responseObject) {
        if ([responseObject.list isKindOfClass:[NSArray class]] && responseObject.code == kMGOkStatuCode) {
            [MGLodingView removeFromSuperView:self.view];
            for (NSDictionary *dicInfo in responseObject.list) {
              MGProjectTypeModel *model = [[MGProjectTypeModel alloc] initWithDic:dicInfo];
                [self.arrData addObject:model];
            }
            [self.tableView reloadData];
        }else{
        
            [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
        }
        NSLog(@"responseObject===%@",responseObject);

    } failure:^(id error) {
        [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
    } otherHttpHeader:MGGetOtherHttpHear()];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" initWithClass:[UITableViewCell class] Style:UITableViewCellStyleDefault];
    [cell adjustSeparator];
    MGProjectTypeModel *model = self.arrData[indexPath.row];
    if (self.type==1) {
        cell.textLabel.text = model.denfineName;

    }else{
        cell.textLabel.text = model.kindName;

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 MGProjectTypeModel *model = self.arrData[indexPath.row];
    (!self.objBlock) ?:self.objBlock(model);
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
