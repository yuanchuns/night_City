//
//  MGSelectedAreaVc.h
//  Genechain
//
//  Created by mark_zhang on 15/8/12.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"
#import "MGAreaModel.h"
@interface MGSelectedAreaVc : T2TViewController
@property (nonatomic, strong) MGAreaModel *selectModel;
- (void)setselectAreaHandle:(T2TObjBlock) objBlock;
@end
