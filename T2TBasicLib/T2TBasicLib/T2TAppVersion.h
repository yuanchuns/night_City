//
//  T2TAppVersion.h
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
// 获取app的版本

#import <Foundation/Foundation.h>
#import "T2TBasicLib.h"

@interface T2TAppVersion : NSObject
{
    T2TTextBlock block_appVersion;
}
/**
 *  获取app的版本
 *
 *  @param block 获取到后的回调
 */
-(void)getAppVersionBlock:(T2TTextBlock)block;
@end
