//
//  MGPsdSecurityVc.m
//  Genechain
//
//  Created by mark_zhang on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGPsdSecurityVc.h"
#import "EMineOtherInfoCell.h"
#import "EMineSeitchCell.h"
#import "MGChangePsdVc.h"
#import "GestureVerifyViewController.h"
@interface MGPsdSecurityVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MGPsdSecurityVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码安全";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNibName:kEMineOtherInfoCellKey forCellReuseIdentifier:kEMineOtherInfoCellKey];

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [kUserDefaults objectForKey:MGGestureFinalSaveKey]?2:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    EMineOtherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kEMineOtherInfoCellKey];
    cell.lblTitle.text = (indexPath.row == 0)?@"修改登陆密码":@"修改手势密码";
    if (indexPath.row == 1 ) {
        cell.lblInfo.hidden = NO;
        cell.lblInfo.text = ([kUserDefaults objectForKey:MGGestureFinalSaveKey])?@"已开启":@"未开启";
    }else{
        cell.lblInfo.hidden = YES;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 1) {
        [self handleGestur];
    }else{
    
        MGChangePsdVc *cvc = [[MGChangePsdVc alloc] initWithNibName:@"MGChangePsdVc" bundle:nil];
        [self.navigationController pushViewController:cvc animated:YES];
    }
}

- (void)handleGestur{

    //验证之后去设置新的密码
    GestureVerifyViewController *gvc = [[GestureVerifyViewController alloc] init];
    gvc.isToSetNewGesture = YES;

    [self.navigationController pushViewController:gvc animated:YES];
    
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
