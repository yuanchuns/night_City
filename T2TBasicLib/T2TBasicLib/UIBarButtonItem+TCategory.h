//
//  UIBarButtonItem+TCategory.h
//  TBasicLib
//
//  Created by mark on 14-12-12.
//  Copyright (c) 2014年 mark. All rights reserved.
//  封装常用的BarButtonItem

#import <UIKit/UIKit.h>

//带边框的UIBarButtonItem的背景图片名，每个app需要定义该宏
//#ifndef kBorderBBIBgImgName
//#warning no kBorderBBIBgImgName
//#define kBorderBBIBgImgName @"bbi_border"
//#endif
//
////返回的UIBarButtonItem的图片名，每个app需要定义该宏
//#ifndef kBackBBIImgName
//#warning no kBackBBIImgName
//#define kBackBBIImgName @"bbi_back"
//#endif

@interface UIBarButtonItem (TCategory)

//返回带边框的UIBarButtonItem
+(UIBarButtonItem *)borderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text;
//返回返回的UIBarButtonItem action为navBackAction： 在UIViewController+navBack.h默认实现为popViewControllerAnimated： 可在tar里重写
+(UIBarButtonItem *)backItemWithTarget:(id)tar;
//返回不带边框的UIBarButtonItem
+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text;
//返回图片样式的UIBarButtonItem
+(UIBarButtonItem *)ImageItemWithTarget:(id)tar act:(SEL)act imgn:(NSString *)imgn;
//返回图片样式的UIBarButtonItem 传uiimage
+(UIBarButtonItem *)ImageItemWithTarget:(id)tar act:(SEL)act img:(UIImage *)img;


/**
 *  设置barItem是否可点击
 *
 *  @param isEnable yes为可选no为不可选
 */
-(void)setTextItemEnable:(BOOL)isEnable;

/**
 *  设置barItem不可选以及不可选的颜色
 *
 *  @param isEnable yes为可选no为不可选
 *  @param color    文字颜色
 */
-(void)setTextItemEnable:(BOOL)isEnable diaEnableColor:(UIColor *)color;

/**
 *  设置barItem文字颜色
 *
 *  @param color 颜色值
 */
-(void)setTextItemTextColor:(UIColor *)color;

@end
