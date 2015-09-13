//
//  MGSchduleQueryVc.h
//  Genechain
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//
#import "MGSchudleDetailModel.h"
#import "T2TViewController.h"
static NSString *const kindKey = @"kind";
static NSString *const deptIdKey = @"deptId";
static NSString *const taskerNameKey = @"taskerName";
static NSString *const clientNameKey = @"clientName";
static NSString *const yearMonthKey = @"yearMonth";
static NSString *const yearMonthDayKey = @"yearMonthDay";
@interface MGSchduleQueryVc : T2TViewController
@property (nonatomic, strong) MGSchudleDetailModel *detailModel;
//@property (nonatomic, strong) NSDictionary *dicInfo;
- (void)setOkHandle:(T2TObjBlock)dicInfo;
@end
