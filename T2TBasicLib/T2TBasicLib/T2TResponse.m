//
//  T2TResponse.m
//  T2TBasicLib
//
//  Created by mark on 15/1/5.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TResponse.h"
#import "TLog.h"
@implementation T2TResponse
-(id)initWithDic:(NSDictionary *)dict{

    if (self = [super init]) {
        
    if ([dict isKindOfClass:[NSDictionary class]]) {
     [self reflectDataFromOtherObject:dict];
        if ([dict[@"status"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicStaus = dict[@"status"];
            self.code = [dicStaus[@"code"] intValue];
            self.parameter= dicStaus[@"parameter"];
            self.beanName = dicStaus[@"beanName"];
            self.reson = dicStaus[@"reson"];
        }
    }
   
 }
    return self;
}



@end
