//
//  T2TActionTaskVc.h
//  Genechain
//
//  Created by mark_zhang on 15/8/24.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"

#import "RadioBox.h"
#import "RadioGroup.h"

@interface T2TActionTaskVc : T2TViewController
@property (nonatomic, assign) int taskId;
- (void)setHandleBlock:(T2TBacsicBlock)successBlock;

@end
