//
//  T2TModelView.h
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
@class T2TModelBackGroudView;

#import "T2TBasicLib.h"
@interface T2TModelView : NSObject

//+(void)closeMoreModelViewFromView:(UIView *)aView;

/**
 *  弹出视图
 *
 *  @param v 弹出后显示的视图
 */
+(void)showWithContentView:(UIView *)v;
/**
 *  弹出视图
 *
 *  @param v  弹出显示的视图
 *  @param rt 显示视图的frame
 */
+(void)showWithContentView:(UIView *)v fromRect:(CGRect)rt;

/**
 *  弹出视图
 *
 *  @param v_content 弹出显示的视图
 *  @param a_bg      背景的透明度
 */
+(void)showWithContentView:(UIView *)v_content bgAlpha:(float)a_bg;

/**
 *  弹出视图
 *
 *  @param v_content  显示的视图
 *  @param rt         显示视图的frame
 *  @param c_bg       背景颜色
 *  @param a_bg       背景的透明度
 *  @param editHandle 弹出时的属性
 */
+(void)showWithContentView:(UIView *)v_content fromRect:(CGRect)rt bgColor:(UIColor *)c_bg bgAlpha:(float)a_bg editBgViewHandle:(void (^)(T2TModelBackGroudView *))editHandle;

/**
 *  弹出视图
 *
 *  @param superView  承载的父视图
 *  @param aView      显示的视图
 *  @param editHandle 编辑视图的block
 */
+(void)showInView:(UIView *)superView contentVIew:(UIView *)aView editBgViewHandle:(void (^)(T2TModelBackGroudView *viewBg))editHandle;

//关闭modelView，aView为内容视图或内容视图的子视图
+(void)closeModelViewWithContentView:(UIView *)aView;
/**
 *  关闭modelView
 *
 *  @param aView modelView的父视图，不知道父视图可以传windows
 */
+(void)closeModelViewFromView:(UIView *)aView;
/**
 *  关闭modelView,  说明：调用的是[self closeModelViewFromView:kCurrentWindow];，缺点是可能更耗性能；
 */
+(void)close;

+(void)closeMoreModelViewFromView:(UIView *)aView;

@end

@interface T2TModelBackGroudView : UIImageView
@property (nonatomic,assign) float animateWithDuration;
@property (nonatomic,strong) T2TBasicBlock blockCloseAnimate;//关闭后的block回调
@property (nonatomic,strong) T2TBasicBlock blockCloseHandle;

@end