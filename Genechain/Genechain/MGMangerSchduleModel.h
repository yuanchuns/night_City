//
//  MGMangerSchduleModel.h
//  Genechain
//
//  Created by mark_zhang on 15/7/30.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGMangerSchduleModel : T2TObject
@property (nonatomic, copy) NSString *activityName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *createrName;
@property (nonatomic, copy) NSString *createrNo;
@property (nonatomic, copy) NSString *deptName;
@property (nonatomic, copy) NSString *editFlag;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) int kind;
@property (nonatomic, copy) NSString *kindName;
@property (nonatomic, copy) NSString *persons;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *scheduleId;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, copy) NSString *taskerName;
@property (nonatomic, copy) NSString *taskerNo;

@end
