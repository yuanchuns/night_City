//
//  SearchViewController.h
//  Genechain
//
//  Created by nextone on 15/8/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "T2TViewController.h"
#import "MGSchudleDetailModel.h"
static NSString *const kindKey = @"kind";
static NSString *const deptIdKey = @"deptId";
static NSString *const taskerNameKey = @"taskerName";
static NSString *const clientNameKey = @"clientName";
static NSString *const yearMonthKey = @"yearMonth";
static NSString *const yearMonthDayKey = @"yearMonthDay";


typedef void(^AnswerWiththisMessage)(MGSchudleDetailModel *model);
@interface SearchViewController : T2TViewController
@property (nonatomic, strong) MGSchudleDetailModel *detailModel;
@property (nonatomic, copy) AnswerWiththisMessage answerBlock;
@property(nonatomic)BOOL isBook;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *DtepName;

@end
