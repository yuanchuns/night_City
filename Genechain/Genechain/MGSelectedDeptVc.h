//
//  MGSelectedDeptVc.h
//  Genechain
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"
#import "MGDepartmentModel.h"
@interface MGSelectedDeptVc : T2TViewController
@property (nonatomic, assign) int parentId;
- (void)setHandleSlected:(T2TObjBlock)objBlock;


@end
