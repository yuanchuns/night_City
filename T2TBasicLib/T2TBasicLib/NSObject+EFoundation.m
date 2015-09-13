//
//  NSObject+EFoundation.m
//  T2TBasicLib
//
//  Created by luoluo on 14/12/22.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "NSObject+EFoundation.h"

@implementation NSObject (EFoundation)

@end

void RUN_ON_UI_THREAD(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}