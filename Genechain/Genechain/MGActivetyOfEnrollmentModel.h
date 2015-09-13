//
//  MGActivetyOfEnrollmentModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGActivetyOfEnrollmentModel : T2TObject
//"activityAddress": "",
//"activityId": 127,
//"activityName": "20150612 PDAL卓越绩效沙龙",
//"activityType": "公开课",
//"beginDate": "2015-6-12",
//"companyName": "百年基业",
//"createDate": "2015-05-19",
//"employeeName": "宋晨阳",
//"employeeNo": "songchenyang",
//"endDate": "2015-6-12",
//"price": null,
//"province": "北京市",
//"status": "1",
//"statusName": "销售中",
//"teacherId": "",
//"teacherName": null
@property (nonatomic, copy) NSString *activityAddress;
@property (nonatomic, assign) int activityId;
@property (nonatomic, copy) NSString *activityName;
@property (nonatomic, copy) NSString *activityType;
@property (nonatomic, copy) NSString *beginDate;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *employeeName;
@property (nonatomic, copy) NSString *employeeNo;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *teacherId;
@property (nonatomic, copy) NSString *teacherName;
@end
