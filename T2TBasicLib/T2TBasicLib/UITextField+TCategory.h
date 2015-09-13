//
//  UITextField+TCategory.h
//  TBasicLib
//
//  Created by mark on 14-12-12.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define_block.h"

@interface UITextField (TCategory)

/**
 *  使用runtime判断textFiled是否编辑
 *
 *  @param aBlock 改变后回调的block
 */
-(void)setTextDidChangeHandle:(T2TBacsicBlock)aBlock;

@end
