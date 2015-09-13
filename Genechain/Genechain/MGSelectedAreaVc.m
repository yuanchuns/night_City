//
//  MGSelectedAreaVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/12.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSelectedAreaVc.h"
#import "MGAreaModel.h"

static NSString *const CellReuseIdentifier = @"cell";

@interface MGSelectedAreaVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *proviceTable;
@property (nonatomic, strong) UITableView *cityTable;
@property (nonatomic, strong) NSArray *arrProvice;
@property (nonatomic, strong) MGAreaModel *cityModel;
//@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) T2TObjBlock objBlock;
@end

@implementation MGSelectedAreaVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrProvice = [MGAreaModel getAreaInfo];
    
    self.proviceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 180,kScreenHeight-kNavBarHeight )];
    self.proviceTable.delegate = self;
    self.proviceTable.dataSource = self;
    self.proviceTable.tableFooterView = [UIView new];
    [self.proviceTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.proviceTable.showsHorizontalScrollIndicator = NO;
    self.proviceTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.proviceTable];
    
    self.cityTable = [[UITableView alloc] initWithFrame:CGRectMake(180, 0,kScreenWidth - 180,kScreenHeight-kNavBarHeight )];
    self.cityTable.delegate = self;
    self.cityTable.dataSource = self;
    self.cityTable.tableFooterView = [UIView new];
    self.cityTable.showsHorizontalScrollIndicator = NO;
    self.cityTable.showsVerticalScrollIndicator = NO;
    [self.cityTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    [self.view addSubview:self.cityTable];
    
    if (self.selectModel == nil) {
        self.cityModel = [self.arrProvice firstObject];
        self.selectModel = [self.cityModel.arrCitys firstObject];
    } else {
    
        for (MGAreaModel *model in self.arrProvice) {
            if ([self.selectModel.code hasPrefix:model.headCode]) {
                self.cityModel = model;
                break;
            }
        }
    }
    
    // Do any additional setup after loading the view.
}

- (void)setselectAreaHandle:(T2TObjBlock)objBlock {

    self.objBlock = objBlock;
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == self.proviceTable) {
        return self.arrProvice.count;
    }
    
    return self.cityModel.arrCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    [cell adjustSeparator];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == self.proviceTable) {
        MGAreaModel *model = self.arrProvice[indexPath.row];
        cell.textLabel.text = model.name;
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([self.cityModel.code isEqualToString:model.code]) {
            
            [T2TView setBgColorForCell:cell bgColor:[UIColor colorWithHexString:@"#f2f2f2"]];
        }else{
            [T2TView setBgColorForCell:cell bgColor:[UIColor whiteColor]];

        }
    } else {
        MGAreaModel *model = self.cityModel.arrCitys[indexPath.row];
        cell.textLabel.text = model.name;
        [T2TView setBgColorForCell:cell bgColor:[UIColor whiteColor]];
        if ([model.code isEqualToString:self.selectModel.code]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
        
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == self.proviceTable) {
        return 35;
    }
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.proviceTable) {
        self.cityModel = self.arrProvice[indexPath.row];
        [self.proviceTable reloadData];
        [self.cityTable reloadData];
    }else{
    (!self.objBlock) ?: self.objBlock(self.cityModel.arrCitys[indexPath.row]);
        [self navBackAction:nil];
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
