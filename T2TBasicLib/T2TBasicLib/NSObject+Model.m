//
//  NSObject+Model.m
//  TBasicLib
//
//  Created by mark.zhang、mark on 14-12-10.
//  Copyright (c) 2014年 233. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)


#pragma mark - 私有方法
//获取到一个对象的所有属性名称
- (NSArray*)propertyKeys
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    
    return propertiesArray;
}


#pragma mark - 接口方法


- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource
{
    BOOL ret = NO;
    NSArray *arrPropertyKeys = [self propertyKeys];
    for (NSString *key in arrPropertyKeys) {
        
        NSString *strKeyOnDataSource = key;
        if ([strKeyOnDataSource hasPrefix:@"_"]) {
            strKeyOnDataSource = [strKeyOnDataSource substringFromIndex:1];
        }
        
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:strKeyOnDataSource]==nil)?NO:YES;
        }
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(strKeyOnDataSource)];//判断是否有key这个方法
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:strKeyOnDataSource];
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [self setValue:propertyValue forKey:key];
            }
        }else{
//            [TLog log:[NSString stringWithFormat:@"no values for key:%@  self:%@",key,self.description]];
        }
        
    }
    return ret;
}

//获取属性的内容
- (NSDictionary *)getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        if ([propertyName hasPrefix:@"_"]) {
            propertyName = [propertyName substringFromIndex:1];
        }
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}


//#pragma mark -
//
//NS_INLINE id unrecognized(id self,SEL _cmd){
//    [TLog logErrorInfo:[NSString stringWithFormat:@"%@ unrecognized:%s",self,sel_getName(_cmd)]];
//    return nil;
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel != @selector(descriptionWithLocale:) && sel != @selector(_copyFormattingDescription:)) {
//        class_addMethod([self class], sel,(IMP)unrecognized, "@@:");
//    }
//    return YES;
//}


@end
