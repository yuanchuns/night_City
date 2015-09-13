//
//  MGEmployeeModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGEmployeeModel : T2TObject
//"employeeName": "andy chen",
//"employeeNo": "144",
//"id": 144,
//"mail": "liu_lianwang@126.com",
//"mobile": "13810265878"
@property (nonatomic, copy) NSString *employeeName;
@property (nonatomic, copy) NSString *employeeNo;
@property (nonatomic, assign) int _id;
@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *mobile;
@end
