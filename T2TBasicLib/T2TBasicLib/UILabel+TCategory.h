//
//  UILabel+TCategory.h
//  TBasicLib
//
//  Created by mark on 14-12-12.
//  Copyright (c) 2014年 233. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "T2TBasicLib.h"
@interface UILabel (TCategory)
/**
 *  设置带行距的text
 *
 *  @param str     文字
 *  @param lineGap 行距大小
 */
-(void)setAtsWithStr:(NSString *)str lineGap:(float)lineGap;

@end
