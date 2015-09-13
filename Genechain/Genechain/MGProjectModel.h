//
//  MGProjectModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGProjectModel : T2TObject
//"clientId": 4551,
//"clientName": "海信冰箱公司",
//"managerName": "仇宇鹏",
//"projectId": 1613,
//"projectName": "六顶思考帽与计划管理",
//"statusName": "已建立"

@property (nonatomic, assign) int clientId;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) NSString *managerName;
@property (nonatomic, assign) int projectId;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *statusName;
@end
