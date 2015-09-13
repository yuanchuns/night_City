//
//  BoolViewController.m
//  Genechain
//
//  Created by nextone on 15/9/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "BoolViewController.h"

@interface BoolViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *arrData;

@end

@implementation BoolViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"类别";
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.arrData = [NSMutableArray arrayWithObjects:@"是",@"否", nil];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" initWithClass:[UITableViewCell class] Style:UITableViewCellStyleDefault];
    cell.textLabel.text =[self.arrData  objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        if (self.selectStr) {
            self.selectStr(@"是");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (indexPath.row==1){
        if (self.selectStr) {
            self.selectStr(@"否");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
