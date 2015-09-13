//
//  T2TObject.m
//  T2TBasicLib
//
//  Created by mark on 14/12/11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TObject.h"
#import "NSObject+Model.h"

@interface T2TObject (){
    NSMutableArray* _selfRetains;
}

@end

@implementation T2TObject

-(id)init{
    self = [super init];
    if (self) {
        _selfRetains = [NSMutableArray array];
    }
    return self;
}


-(id)retainSelf
{
    [_selfRetains addObject:self];
    return self;
}
-(void)releaseSelf
{
    [_selfRetains removeLastObject];
}


//将数据映射到属性
-(id)initWithDic:(NSDictionary *)dict{
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        [self reflectDataFromOtherObject:dict];
    }
    return self;
}
//将属性名和对应的值组成字典返回
-(NSDictionary *)dicData{
    return [self getAllPropertiesAndVaules];
}

-(NSString *)description{
    return [self dicData].description;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    [TLog log:[NSString stringWithFormat:@"value:%@,UndefinedKey:%@",value,key]];
}
@end
