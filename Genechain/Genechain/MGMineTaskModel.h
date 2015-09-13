//
//  MGMineTaskModel.h
//

//
//  Created by mark_zhang on 15/8/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGMineTaskModel : T2TObject
//"clientId": 2351,
//"clientName": "江西移动",
//"companyName": "百年优才",
//"finishFlag": "1",
//"id": 7841,
//"projectId": 1604,
//"projectName": "青干班培训项目",
//"projectTypeName": null,
//"taskId": 3363,
//"taskName": "项目调研",
//"taskType": "5",
//"taskTypeName": "咨询服务",
//"taskerComment": "咨询服务",
//"taskerDays": 1,
//"taskerEndDate": "2015-06-16",
//"taskerEndTime": "18:00",
//"taskerMain": "是",
//"taskerName": "伍然",
//"taskerNo": "wuran",
//"taskerStartDate": "2015-06-16",
//"taskerStartTime": "09:00",
//"taskerStatus": "1",
//"taskerType": "3",
//"taskerTypeName": "实施顾问"
@property (nonatomic, assign) int finishFlag;
@property (nonatomic, assign) int _id;
@property (nonatomic, assign) int projectId;
@property (nonatomic, assign) int clientId;
@property (nonatomic, assign) int taskId;
@property (nonatomic, assign) int taskType;
@property (nonatomic, assign) int taskerDays;
@property (nonatomic, assign) int taskerStatus;
@property (nonatomic, assign) int taskerType;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *projectTypeName;
@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, copy) NSString *taskTypeName;
@property (nonatomic, copy) NSString *taskerComment;
@property (nonatomic, copy) NSString *taskerEndDate;
@property (nonatomic, copy) NSString *taskerEndTime;
@property (nonatomic, copy) NSString *taskerMain;
@property (nonatomic, copy) NSString *taskerName;
@property (nonatomic, copy) NSString *taskerNo;
@property (nonatomic, copy) NSString *taskerStartDate;
@property (nonatomic, copy) NSString *taskerStartTime;
@property (nonatomic, copy) NSString *taskerTypeName;
@end
