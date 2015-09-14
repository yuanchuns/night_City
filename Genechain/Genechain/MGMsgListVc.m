//
//  MGMsgListVc.m
//  Genechain
//
//  Created by mark_zhang on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMsgListVc.h"
#import "EManggerMsg.h"
#import "EMineOtherInfoCell.h"
#import "MGMsgDetailVc.h"
@interface MGMsgListVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MGMsgListVc


//-(void)viewWillAppear:(BOOL)animated{
//    [MGMsgModel getNewMsgWithFinishBlock:^(id error) {
//        if ([error isKindOfClass:[NSArray class]]) {
//            self.arrData = error;
//            [self.tableView reloadData];
//            NSLog(@"=++==+++==%@",self.arrData);
//        }
//    }];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息列表";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.height -= kNavBarHeight;
    self.tableView.rowHeight = 44.0f;
    [self.view addSubview:self.tableView];
    [self.tableView registerNibName:kEMineOtherInfoCellKey forCellReuseIdentifier:kEMineOtherInfoCellKey];
    [self getDataFromDataBase];
    // Do any additional setup after loading the view.
}
- (void)getDataFromDataBase {

    
    [MGLodingView removeFromSuperView:self.view];
    [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
        [self performSelector:@selector(getDataFromDataBase) withObject:nil afterDelay:1];
    }];
    EManggerMsg *manger = [EManggerMsg shareEManggerMsg];
    
    self.arrData = [manger getAllMsgRecord];
    
    if (self.arrData.count > 0) {
        [self.tableView reloadData];
        [MGLodingView removeFromSuperView:self.view];
    } else {
        [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
    };
    
    
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EMineOtherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kEMineOtherInfoCellKey];
    
    MGMsgModel *model = self.arrData[indexPath.row];
    cell.lblTitle.text = model.title;
    cell.lblInfo.text = model.createDate;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


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
