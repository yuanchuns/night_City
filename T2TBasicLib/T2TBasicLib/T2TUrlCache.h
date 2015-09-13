//
//  T2TUrlCache.h
//  T2TBasicLib
//
//  Created by mark on 14/12/19.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *const typeIsWebKey = @"webKitKey";
@interface T2TUrlCache : NSURLCache

@property(nonatomic,assign)double catchTime;//设置缓存的时间 默认是1天

@end
