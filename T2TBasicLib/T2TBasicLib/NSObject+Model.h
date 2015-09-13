//
//  NSObject+Model.h
//  TBasicLib
//
//  Created by mark.zhang on 14-12-10.
//  Copyright (c) 2014年 233. All rights reserved.
//  将数据映射到model

#import <Foundation/Foundation.h>

@interface NSObject (Model)

//给属性赋值，数组或字典属性需要特殊处理的则给给该属性重新赋值
-(BOOL)reflectDataFromOtherObject:(NSObject*)dataSource;
//获取属性和值的键值对
- (NSDictionary *)getAllPropertiesAndVaules;

@end
