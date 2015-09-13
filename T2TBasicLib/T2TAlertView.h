//
//  T2TAlertView.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Define_block.h"
@interface T2TAlertView : UIAlertView

/**
 *  初始化方法
 *
 *  @param title   标题
 *  @param message 提示语
 *
 *  @return self
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  添加点击按钮
 *
 *  @param title 按钮的标题
 *  @param block 按钮点击后的回调block
 */
- (void)addButtonWithTitle:(NSString *)title block:(T2TBasicBlock)block;

/**
 *  设置将要显示的block
 *
 *  @param block 设置的block
 */
- (void)setWillDismissBlock:(T2TBasicBlock)block;
/**
 *  设置已经显示的block
 *
 *  @param block 设置的block
 */
- (void)setDidDismissBlock:(T2TBasicBlock)block;

/**
 *  设置父视图将要显示的block
 *
 *  @param block 设置的block
 */
- (void)setWillPresentBlock:(T2TBasicBlock)block;

/**
 *  设置父视图已经显示的block
 *
 *  @param block 设置的block
 */
- (void)setDidPresentBlock:(T2TBasicBlock)block;
@end
