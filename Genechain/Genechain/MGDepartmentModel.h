//
//  MGDepartmentModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGDepartmentModel : T2TObject
//"deptName": "百年优学",
//"id": 17,
//"parentId": 8
@property (nonatomic, copy) NSString *deptName;
@property (nonatomic, assign) int _id;
@property (nonatomic, assign) int parentId;
@property (nonatomic, strong) NSMutableArray *arrChildren;
+ (void)getDeptArrListWithObjBlock:(T2TObjBlock)block parentId:(int)parentId;
@end
