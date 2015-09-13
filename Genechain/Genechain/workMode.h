//
//  workMode.h
//  Genechain
//
//  Created by nextone on 15/8/31.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T2TObject.h"

@interface workMode : T2TObject

//
//advanceFlag = "<null>";
//comments = "<null>";
//companyId = "<null>";
//departDate = "2014-01-04";
//employeeName = "\U738b\U4e1c";
//employeeNo = "<null>";
//flag = 1;
//flight = Z3;
//fromCity = "\U5317\U4eac\U897f";
//id = 2192;
//passengerName = "\U738b\U4e1c";
//price = 12345;
//printDate = "2014-01-01";
//subjectId = 23;
//toCity = "\U4e0a\U6d77";

@property(nonatomic,copy)NSString *advanceFlag;
@property(nonatomic,copy)NSString *comments;
@property(nonatomic,copy)NSString *companyId;
@property(nonatomic,copy)NSString *departDate;
@property(nonatomic,copy)NSString *employeeName;
@property(nonatomic,copy)NSString *employeeNo;
@property(nonatomic,copy)NSString *flag;
@property(nonatomic,copy)NSString *flight;
@property(nonatomic,copy)NSString *fromCity;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *passengerName;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *printDate;
@property(nonatomic,copy)NSString *subjectId;
@property(nonatomic,copy)NSString *toCity;




@end

@interface workModeSecond : T2TObject

//advanceFlag = 0;
//clientId = "<null>";
//clientName = "\U4e91\U5357\U7701\U70df\U53f6\U590d\U70e4\U516c\U53f8";
//comments = "\U9879\U76ee";
//companyId = "<null>";
//createDate = 20150625161200;
//createUser = "\U7ba1\U7406\U5458";
//departDate = "2015-05-29";
//employeeName = "\U738b\U4f73";
//employeeNo = wangjia;
//expenseId = "<null>";
//flag = 2;
//flight = CA1492;
//fromCity = "\U6606\U660e";
//id = 2158;
//passengerName = "\U5f20\U5e86\U6587";
//price = 1050;
//printDate = "2015-05-22";
//projectId = "<null>";
//projectName = "\U4e2d\U5c42\U7ba1\U7406\U4eba\U5458\U9886\U5bfc\U529b\U57f9\U517b";
//subjectId = 7;
//taskId = "<null>";
//taskName = "\U9ad8\U6548\U56e2\U961f7\U5173\U952e";
//toCity = "\U5317\U4eac";
@property(nonatomic,copy)NSString *advanceFlag;
@property(nonatomic,copy)NSString *clientId;
@property(nonatomic,copy)NSString *clientName;
@property(nonatomic,copy)NSString *comments;
@property(nonatomic,copy)NSString *companyId;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *createUser;
@property(nonatomic,copy)NSString *departDate;
@property(nonatomic,copy)NSString *employeeName;
@property(nonatomic,copy)NSString *employeeNo;
@property(nonatomic,copy)NSString *expenseId;
@property(nonatomic,copy)NSString *flag;
@property(nonatomic,copy)NSString *flight;
@property(nonatomic,copy)NSString *fromCity;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *passengerName;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *printDate;
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,copy)NSString *projectName;
@property(nonatomic,copy)NSString *taskId;
@property(nonatomic,copy)NSString *taskName;
@property(nonatomic,copy)NSString *toCity;
@property(nonatomic,copy)NSString *subjectId;


@end
//comments = "SPOT\U56e2\U961f\U5f15\U5bfc\U5de5\U4f5c\U574a";
//companyId = "<null>";
//employeeName = "\U5b8b\U6668\U9633";
//employeeNo = "<null>";
//expressAmount = 0;
//flag = 1;
//id = 147;
//leaveDate = "2015-03-15";
//toolsAmount = 926;
//toolsName = "SPOT\U56e2\U961f\U5f15\U5bfc\U5de5\U4f5c\U574a";


@interface bookMode : T2TObject
@property(nonatomic,copy)NSString *comments;
@property(nonatomic,copy)NSString *companyId;
@property(nonatomic,copy)NSString *employeeName;
@property(nonatomic,copy)NSString *employeeNo;
@property(nonatomic,copy)NSString *expressAmount;
@property(nonatomic,copy)NSString *flag;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *leaveDate;
@property(nonatomic,copy)NSString *toolsAmount;
@property(nonatomic,copy)NSString *toolsName;


@end

//clientId = "<null>";
//clientName = "\U767e\U5ea6\U6280\U672f\U5b66\U9662";
//comments = "\U9879\U76ee";
//companyId = "<null>";
//createDate = 20150627233315;
//createUser = "\U7ba1\U7406\U5458";
//deleteFlag = 0;
//employeeName = "\U738b\U91d1";
//employeeNo = wangjin2014;
//expenseId = 16860;
//expressAmount = 37;
//flag = 2;
//id = 155;
//leaveDate = "1900-01-01";
//projectId = "<null>";
//projectName = "\U57f9\U8bad\U6846\U67b6\U534f\U8bae";
//taskId = "<null>";
//taskName = "\U6fc0\U52b1\U8bfe\U7a0b\U6388\U8bfe";
//toolsAmount = 0;
//toolsName = "\U5feb\U9012\U300a\U6fc0\U52b1\U300b\U5b8b\U6e58\U751f\U5b66\U5458\U624b\U518c";
//updateDate = 20150629093642;
//updateUser = "\U738b\U91d1";


@interface bookModeFinish : T2TObject
@property(nonatomic,copy)NSString *clientId;
@property(nonatomic,copy)NSString *clientName;
@property(nonatomic,copy)NSString *comments;
@property(nonatomic,copy)NSString *companyId;
@property(nonatomic,copy)NSString *toolsName;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *createUser;
@property(nonatomic,copy)NSString *deleteFlag;
@property(nonatomic,copy)NSString *employeeName;
@property(nonatomic,copy)NSString *employeeNo;
@property(nonatomic,copy)NSString *expenseId;
@property(nonatomic,copy)NSString *expressAmount;
@property(nonatomic,copy)NSString *flag;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *leaveDate;
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,copy)NSString *projectName;
@property(nonatomic,copy)NSString *taskId;
@property(nonatomic,copy)NSString *taskName;
@property(nonatomic,copy)NSString *toolsAmount;
@property(nonatomic,copy)NSString *updateDate;
@property(nonatomic,copy)NSString *updateUser;

@end






@interface searchMode : T2TObject
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *dateString;
@property(nonatomic,copy)NSString *deptName;
@property(nonatomic,copy)NSString *clientName;
@property(nonatomic,copy)NSString *taskName;

@end


//amount = 20000;
//commissionFlag = 0;
//companyId = 7;
//companyName = "\U767e\U5e74\U4f18\U624d";
//deptId = 5;
//deptName = "\U4f0d\U7136\U56e2\U961f";
//endDate = "2015-06-16";
//finishFlag = 1;
//id = 3363;
//invoiceKind = 1;
//projectId = 1604;
//reportType = "\U4e2a\U4eba";
//scheduleId = 3453;
//sellCost = "<null>";
//sellPrice = "<null>";
//startDate = "2015-06-16";
//taskDays = 1;
//taskName = "\U9879\U76ee\U8c03\U7814";
//taskPersons = 0;
//taskType = "\U54a8\U8be2\U670d\U52a1";
//teacherPositon = "\U5357\U660c";
//testTool = 1;

@interface taskMode : T2TObject
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *commissionFlag;
@property(nonatomic,copy)NSString *companyId;
@property(nonatomic,copy)NSString *companyName;
@property(nonatomic,copy)NSString *deptId;
@property(nonatomic,copy)NSString *deptName;
@property(nonatomic,copy)NSString *endDate;
@property(nonatomic,copy)NSString *finishFlag;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *invoiceKind;
@property(nonatomic,copy)NSString *projectId;
@property(nonatomic,copy)NSString *reportType;
@property(nonatomic,copy)NSString *scheduleId;
@property(nonatomic,copy)NSString *sellCost;
@property(nonatomic,copy)NSString *sellPrice;
@property(nonatomic,copy)NSString *startDate;
@property(nonatomic,copy)NSString *taskDays;
@property(nonatomic,copy)NSString *taskName;
@property(nonatomic,copy)NSString *taskPersons;
@property(nonatomic,copy)NSString *taskType;
@property(nonatomic,copy)NSString *teacherPositon;
@property(nonatomic,copy)NSString *testTool;






@end


