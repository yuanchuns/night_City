//
//  T2TResponse.h
//  T2TBasicLib
//
//  Created by mark on 15/1/5.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface T2TResponse : T2TObject
@property (nonatomic,strong) id data;
@property(nonatomic, assign)NSUInteger s;//服务器状态码
@property(nonatomic, strong)NSString *msg;//登陆信息
@property(nonatomic,strong)id list;//符合条件的信息
@property(nonatomic,assign)NSUInteger pgIndex;//第几页
@property(nonatomic,assign)NSUInteger count;//总消息条数
@property(nonatomic,assign)NSUInteger pgSize;

@property (nonatomic, assign)int code;
@property (nonatomic, copy) NSString *reson;
@property (nonatomic, copy) NSString *beanName;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) id object;
//@property (nonatomic, strong) 
//@property (nonatomic, )
@end
