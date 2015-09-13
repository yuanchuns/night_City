//
//  MGSchduleDetailVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSchduleDetailVc.h"
#import "MGSchduleDetailTaskerModel.h"
#import "MGSchudleDetailModel.h"
#import "MGOneBoxCell.h"
#import "MGTwoBoxCell.h"
#import "MGTaskerCell.h"
#import "MGSchduleDetailVc+Other.h"
@interface MGSchduleDetailVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrTasker;

@end

@implementation MGSchduleDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日程查看";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.height -= kNavBarHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    [self.tableView registerNibName:MGOneBoxCellClassName forCellReuseIdentifier:MGOneBoxCellClassName];
    [self.tableView registerNibName:MGTwoBoxCellClassName forCellReuseIdentifier:MGTwoBoxCellClassName];
    [self.tableView registerNibName:MGTaskerCellClassName forCellReuseIdentifier:MGTaskerCellClassName];
    [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
    }];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)requestData{
//word={"status":{"userName":"伍然","beanName":"status","parameter":"1","ver":"1.0.0","sessionId":"224AFB8D26887D041C995B79D86679FF","loginName":"wuran"},"object":{"scheduleId":"3296"}}
    self.arrTasker = [NSMutableArray array];
    NSDictionary *dicInfo = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"scheduleId":kUnNilStr(self.schduleId)}};
    NSString *urlStr = [NSString stringWithFormat:kMGDefaultURL,kMGScheduleDetailUrl,[dicInfo JSONString]];
    [T2THttpManager getWithUrl:urlStr success:^(T2TResponse *responseObject) {
        
        if (responseObject.code == kMGOkStatuCode) {
            [MGLodingView removeFromSuperView:self.view];
            self.detailModel = [[MGSchudleDetailModel alloc] initWithDic:responseObject.object];
            if ([responseObject.list isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in responseObject.list) {
                    MGSchduleDetailTaskerModel *model = [[MGSchduleDetailTaskerModel alloc] initWithDic:dic];
                    [self.arrTasker addObject:model];
                }
                [self.tableView reloadData];
            }else{
                [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
                    [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
                    [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
                }];
            }
        }
    } failure:^(id error) {
        [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
    } otherHttpHeader:MGGetOtherHttpHear()];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrTasker.count + 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        [cell hidenRightRowImav];
        cell.lblFir.text = [self getFirstLineFirBoxStr];
        cell.lblSec.text = [self getFirstLineSecBoxStr];
        return cell;
    }else if (indexPath.row == 1){
    
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        [cell hidenRightRowImav];
        cell.lblFir.text = [self getSecondLineFirBoxStr];
        cell.lblSec.text = [self getSecondLineSecBoxStr];
        return cell;
    }else if (indexPath.row == 2){
    
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        [cell hidenRightRowImav];
        cell.lblContent.text = [self getThiredLineStr];
        return cell;
    }else if (indexPath.row == 3){
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        [cell hidenRightRowImav];
        cell.lblContent.text = [self getFourLineStr];
        return cell;

    }else if (indexPath.row == 4){
        MGOneBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGOneBoxCellClassName];
        [cell hidenRightRowImav];
        cell.lblContent.text = [self getFiveLineStr];
        return cell;
        
    }else if (indexPath.row == 5){
        MGTwoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTwoBoxCellClassName];
        [cell hidenRightRowImav];
        cell.lblFir.text = [self getSixLineFirBoxStr];
        cell.lblSec.text = [self getSixLineSecBoxStr];
        return cell;
        
    }
    MGTaskerCell *cell = [tableView dequeueReusableCellWithIdentifier:MGTaskerCellClassName];
    if (self.arrTasker.count > 0) {
     [cell setUIValueWithModel:self.arrTasker[indexPath.row - 6]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.detailModel) {
        return 0;
    }
    
    if (indexPath.row >= 6) {
        return  [MGTaskerCell getCellHeightWithModel:self.arrTasker[indexPath.row - 6]];
    }else if (indexPath.row == 0){
        return MgSchduleDetailCellHeight;
    }else if (indexPath.row == 1){
        return [self getSecLineHeight];
    }else if (indexPath.row == 2){
        return [self getThiredLineHeight];
    
    }else if (indexPath.row == 3){
        return [self getFourLineHeight];
    
    }else if (indexPath.row == 4){
        return [self getFiveLineHeight];
        
    }else if (indexPath.row == 5){
        return MgSchduleDetailCellHeight;
    }
    return 0;
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
