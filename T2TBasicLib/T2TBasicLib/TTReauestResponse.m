//
//  TTReauestResponse.m
//  TTHttpManager
//
//  Created by mark on 14/12/11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "TTReauestResponse.h"
#import "NSObject+Model.h"
@implementation TTReauestResponse
-(id)initWithDic:(NSDictionary *)dict{
    
    self = [super init];//返回空还没处理
    if (self) {
      //  _errorCode = kErrorCodeOfNoData;
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [self reflectDataFromOtherObject:dict];
        }
        if (self.S != 10006) {
           // [TLog logErrorInfo:[NSString stringWithFormat:@"post err : %@",[self dicData]]];
        }
    }
    return self;
}

@end
