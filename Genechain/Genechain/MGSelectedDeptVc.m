//
//  MGSelectedDeptVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSelectedDeptVc.h"
#import "RATreeView.h"
#import "MGDepartmentModel.h"
#import "MGDeptCell.h"
@interface MGSelectedDeptVc ()<RATreeViewDataSource,RATreeViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) RATreeView *treeView;
@property (nonatomic, copy) T2TObjBlock objBlock;
@end

@implementation MGSelectedDeptVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"部门选择";
    self.treeView = [[RATreeView alloc] initWithFrame:self.view.bounds];
    self.treeView.dataSource = self;
    self.treeView.delegate = self;
    self.treeView.height -= kNavBarHeight;
    self.treeView.treeFooterView = [UIView new];
    [self.view addSubview:self.treeView];
    [self.treeView registerNib:[UINib nibWithNibName:MGDeptCellClassName bundle:nil] forCellReuseIdentifier:MGDeptCellClassName];
    
    [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
    }];
//    self.parentId = -1;
    [self requestData];
    // Do any additional setup after loading the view.
    
}

- (void)setHandleSlected:(T2TObjBlock)objBlock{

    self.objBlock = objBlock;
}

- (void)requestData{

  self.parentId = (self.parentId == 0)?-1:self.parentId;
    [MGDepartmentModel getDeptArrListWithObjBlock:^(NSArray * arr) {
        if ([arr isKindOfClass:[NSArray class]]) {
            [MGLodingView removeFromSuperView:self.view];
            self.arrData = [NSMutableArray arrayWithArray:arr];
            [self.treeView reloadData];
        }else{
            [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
        }
    } parentId:self.parentId];
    
}

#pragma mark - treeViewDelegate

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo {

    MGDeptCell *cell = [treeView dequeueReusableCellWithIdentifier:MGDeptCellClassName];
   
     MGDepartmentModel *model = item;
    if (model.arrChildren.count > 0) {
        cell.lblText.text = [NSString stringWithFormat:@"%@(%ld)",model.deptName,model.arrChildren.count];
    }else{
        cell.lblText.text = model.deptName;
    }
   
    return cell;
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item {

    if (item == nil) {
        return self.arrData[index];
    }
    MGDepartmentModel *model = item;
    return model.arrChildren[index];
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item {

    if (item == nil) {
        return self.arrData.count;
    }
     MGDepartmentModel *model = item;
    return model.arrChildren.count;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel
{
    //默认是展开的
    return YES;
}

- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo {
   MGDepartmentModel *model = item;
    if (model.arrChildren.count == 0) {
        (!self.objBlock) ?:self.objBlock(model);
        [self navBackAction:nil];
    }
    
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo {
    MGDeptCell *deptCell = (MGDeptCell *)cell;
    if (treeNodeInfo.treeDepthLevel == 0) {
        deptCell.contLblTextHead.constant = 10;
    } else if (treeNodeInfo.treeDepthLevel == 1) {
       deptCell.contLblTextHead.constant = 25;
    } else if (treeNodeInfo.treeDepthLevel == 2) {
        deptCell.contLblTextHead.constant = 40;
    }else if (treeNodeInfo.treeDepthLevel == 3){
    
        deptCell.contLblTextHead.constant = 55;
    }else if (treeNodeInfo.treeDepthLevel == 4){
    
        deptCell.contLblTextHead.constant = 70;
    }
}

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 45;
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
