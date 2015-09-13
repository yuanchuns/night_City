//
//  MGToolHomeVC.m
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGToolHomeVC.h"

@interface MGToolHomeVC ()

@end

@implementation MGToolHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工具";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
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
