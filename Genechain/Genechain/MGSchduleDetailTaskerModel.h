//
//  MGSchduleDetailTaskerModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGSchduleDetailTaskerModel : T2TObject
//"mail": null,
//"mobile": null,
//"taskerComment": "备注1",
//"taskerEndDate": "2015-08-04 18:00",
//"taskerId": 7778,
//"taskerName": "仇宇鹏",
//"taskerNo": "qiuyupeng",
//"taskerStartDate": "2015-08-01 09:00",
//"taskerType": "1"

@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *taskerComment;
@property (nonatomic, copy) NSString *taskerEndDate;
@property (nonatomic, copy) NSString *taskerName;
@property (nonatomic, copy) NSString *taskerNo;
@property (nonatomic, copy) NSString *taskerStartDate;
@property (nonatomic, assign) int taskerId;
@property (nonatomic, assign) int taskerType;
@end
