//
//  MGSecurityHomeVc.m
//  Genechain
//
//  Created by mark_zhang on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSecurityHomeVc.h"
#import "EMineOtherInfoCell.h"
#import "EMineSeitchCell.h"

#import "MGPsdSecurityVc.h"
#import "MGMsgListVc.h"
#import "MGHeadImaVc.h"
#import "MGAbooutVc.h"
#import "GestureViewController.h"
#import "GestureVerifyViewController.h"
#import "MGChangeHeadImaVc.h"
#import "AppDelegate.h"
@interface MGSecurityHomeVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *arrTitles;
@end

@implementation MGSecurityHomeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kDefaultBackgroundColor;
    self.title = @"安全设置";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNibName:kEMineOtherInfoCellKey forCellReuseIdentifier:kEMineOtherInfoCellKey];
    [self.tableView registerNibName:kEMineSeitchCellKey forCellReuseIdentifier:kEMineSeitchCellKey];
    
    self.arrTitles = @[@[@"手势密码"],@[@"推送设置"],@[@"密码安全",@"消息列表",@"头像",@"关于"]];
    
    
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.tableView reloadData];
 
}

- (void)handleGesturWithState:(BOOL)state{

    if (state) {
        GestureViewController *gvc = [[GestureViewController alloc] init];
        gvc.type = GestureViewControllerTypeSetting;
        [gvc setHandleSuccessBlock:^{
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:gvc animated:YES];
    }else{
        GestureVerifyViewController *gvc = [[GestureVerifyViewController alloc] init];
        gvc.isToSetNewGesture = NO;
        [gvc setHandleSuccessBlock:^{
            [kUserDefaults removeObjectForKey:MGGestureFinalSaveKey];
            [kUserDefaults removeObjectForKey:MGGestureOneSaveKey];
            [kUserDefaults synchronize];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:gvc animated:YES];
    }

}

#pragma mark -  tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.arrTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrTitles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section != 2){
    
        EMineSeitchCell *cell = [tableView dequeueReusableCellWithIdentifier:kEMineSeitchCellKey];
        cell.lblTitle.text = self.arrTitles[indexPath.section][indexPath.row];
        
        if (indexPath.section == 0) {
            cell.switchInfo.on = ([kUserDefaults objectForKey:MGGestureFinalSaveKey] != nil);
        } else {
        
            NSNumber *numBool = [kUserDefaults objectForKey:kMGMsgSwitchKey];
            cell.switchInfo.on = [numBool boolValue];
            
            
        }
        
        [cell setSwitchHandle:^(BOOL state) {
    
            if (indexPath.section == 0) {
                [self handleGesturWithState:state];
            } else {
                BOOL numBool = [[kUserDefaults objectForKey:kMGMsgSwitchKey] boolValue];
                [kUserDefaults setObject:[NSNumber numberWithBool:!numBool] forKey:kMGMsgSwitchKey];
                if (!numBool) {
                    //表示去更新一次消息
                    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
                    [appdelegate updateMsg];
                }

            }

        }];
        return cell;
    }
    
    EMineOtherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kEMineOtherInfoCellKey];
    cell.lblTitle.text = self.arrTitles[indexPath.section][indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section == 0 || indexPath.section == 1) return;
    
    if (indexPath.row == 2) {
        MGChangeHeadImaVc *mvc = [[MGChangeHeadImaVc alloc] initWithNibName:@"MGChangeHeadImaVc" bundle:nil];
        [self.navigationController pushViewController:mvc animated:YES];
        return;
    } else if ( indexPath.row == 3) {
    
        MGAbooutVc *avc = [[MGAbooutVc alloc] initWithNibName:@"MGAbooutVc" bundle:nil];
        [self.navigationController pushViewController:avc animated:YES];
        return;
    }
    
    NSArray *arrClass = @[@"MGPsdSecurityVc",@"MGMsgListVc",@"MGHeadImaVc",@"MGAbooutVc"];
    Class class = NSClassFromString(arrClass[indexPath.row]);
    
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.001f;
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
