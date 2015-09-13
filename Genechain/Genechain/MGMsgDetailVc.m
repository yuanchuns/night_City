//
//  MGMsgDetailVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMsgDetailVc.h"
#import "EManggerMsg.h"
@interface MGMsgDetailVc ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (nonatomic, copy) T2TBacsicBlock delelteBlock;
@end

@implementation MGMsgDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text = [@"标题：" stringByAppendingString:self.model.title];
    self.lblTime.text = [@"时间：" stringByAppendingString:self.model.createDate];
    self.lblMsg.text = [@"内容：" stringByAppendingString:self.model.message];
    
    self.navigationItem.rightBarButtonItem = [T2TView ImageItemWithTarget:self act:@selector(actionRightBar) imgn:@"comm_del"];
    // Do any additional setup after loading the view from its nib.
}

- (void)setDeleteHandle:(T2TBacsicBlock)backBlock {

    self.delelteBlock = backBlock;
}

- (void)actionRightBar {
    EManggerMsg *manger = [EManggerMsg shareEManggerMsg];
    BOOL state = [manger deleteOneRecordWithId:self.model._id];
    if (state) {
        [self navBackAction:nil];
        (!self.delelteBlock) ?:self.delelteBlock();
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
