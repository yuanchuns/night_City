//
//  MGMsgDetailVc.h
//  Genechain
//
//  Created by mark_zhang on 15/8/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"
#import "MGMsgModel.h"
@interface MGMsgDetailVc : T2TViewController
@property (nonatomic, strong) MGMsgModel *model;
- (void)setDeleteHandle:(T2TBacsicBlock)backBlock;
@end
