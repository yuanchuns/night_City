//
//  MGAddTaskerVc.h
//  Genechain
//
//  Created by mark_zhang on 15/8/17.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"
#import "MGSchduleDetailTaskerModel.h"

typedef enum {

    changeTasker = 1,
    addTasker = 2
}taskerEditType;

typedef void (^takserEditTypeBlock) (MGSchduleDetailTaskerModel *model ,taskerEditType type);

@interface MGAddTaskerVc : T2TViewController
@property (nonatomic, assign) taskerEditType editType;
- (instancetype)initWithStarteDate:(NSString *)startDate endDate:(NSString *)endDate;
- (instancetype)initWithDetailModel:(MGSchduleDetailTaskerModel *)model;

- (void)setselectedTaskerModel:(takserEditTypeBlock )objBlock;
@end
