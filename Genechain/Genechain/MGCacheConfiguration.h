//
//  MGCacheConfiguration.h
//  Genechain
//
//  Created by mark_zhang on 15/8/5.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGCacheConfiguration : T2TObject

//获取项目类别
+ (void)getProjectTypeWithObjBlock:(T2TObjBlock)objBlock;

//获取公司名称
+ (void)getCommpanyNameWithObjBlock:(T2TObjBlock)objBlock;

//获取公司部门
+ (void)getCommpanyDepartmentWithObjBlock:(T2TObjBlock)objBlock parentId:(int)parentId;

@end
