//
//  MGSchudleDetailModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGSchudleDetailModel : T2TObject
//"activityId": null,
//"activityName": "",
//"activityType": " ",
//"cityCode": "140601",
//"cityName": "朔州",
//"clientId": 692,
//"clientMan": null,
//"clientName": "内蒙古区烟草专卖局",
//"comment": null,
//"companyId": 6,
//"companyName": "百年优策",
//"deptId": 36,
//"deptName": "王金帅团队",
//"endDate": "2015-08-04 18:00",
//"id": 3493,
//"kind": "2",
//"kindName": "客户",
//"loginId": null,
//"loginName": null,
//"mailSendFlag": null,
//"projectId": null,
//"projectName": "",
//"startDate": "2015-08-01 09:00",
//"taskName": "拜访"

@property (nonatomic, assign) int cityCode;
@property (nonatomic, assign) int clientId;
@property (nonatomic, assign) int deptId;
@property (nonatomic, assign) int _id;
@property (nonatomic, assign) int kind;
@property (nonatomic, assign) int companyId;
@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, copy) NSString *activityName;
@property (nonatomic, copy) NSString *activityType;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *clientMan;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *deptName;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *kindName;
@property (nonatomic, copy) NSString *loginId;
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *mailSendFlag;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *subjectId;

@property(nonatomic,copy)NSString *isSearch;
@property (nonatomic, copy) NSString * deptIds;


//工作台
@property(nonatomic,copy)NSString *currentTime;//当前时间
@property(nonatomic,copy)NSString *taskPrice;//任务费用

@property (nonatomic, copy) NSString *expenseType;//费用类型
@property(nonatomic)NSInteger count;

@property (nonatomic) int advanceFlag;



@end
