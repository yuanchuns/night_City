//
//  T2TView.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T2TBasicLib.h"
#define kSuccessHUDImgName @"HUD_success"
#define kFailHUDImgName @"HUD_fail"
#define FONT_BBI [UIFont fontWithName:@"STHeitiSC-Light" size:13]
@interface T2TView : UIView

#pragma mark - textfield

/**
 *  创建UITextFiled
 *
 *  @param rect frame
 *
 *  @return 返回的textFiled
 */
+(UITextField *)tfWithFrame:(CGRect)rect;

/**
 *  创建带边框颜色的UITextFiled
 *
 *  @param rect    frame
 *  @param bdColor 边框颜色
 *
 *  @return 返回的textFiled
 */
+(UITextField *)tfWithFrame:(CGRect)rect borderColor:(UIColor *)bdColor;

/**
 *  创建带边框，提示文字，和设置delegate
 *
 *  @param rect    frame
 *  @param bdColor 边框颜色
 *  @param str     提示文字
 *  @param tar     代理
 *
 *  @return 返回的textFiled
 */
+(UITextField *)tfWithFrame:(CGRect)rect borderColor:(UIColor *)bdColor placeholder:(NSString *)str delegate:(id)tar;

/**
 *  创建带边框样式，提示文字，设置代理
 *
 *  @param rect frame
 *  @param bs   边框样式
 *  @param str  提示文字
 *  @param tar  代理对象
 *
 *  @return 返回的textFiled
 */
+(UITextField *)tfWithFrame:(CGRect)rect borderstyle:(UITextBorderStyle)bs placeholder:(NSString *)str  delegate:(id)tar;
/**
 *  创建带背景图片、提示文字以及设置代理对象
 *
 *  @param rect frame
 *  @param img  图片名称
 *  @param str  提示文字
 *  @param tar  代理对象
 *
 *  @return 返回的textFiled
 */
+(UITextField *)tfWithFrame:(CGRect)rect bgImg:(UIImage *)img placeholder:(NSString *)str delegate:(id)tar;



#pragma mark - HUD

/**
 *  在HUD上显示自定义的提示
 *
 *  @param HUD     自定义的图片
 *  @param imgname 自定义图片名称
 *  @param text    自定义的提示语
 */
+(void)SHOWHUDWITHHUD:(MBProgressHUD *)HUD imgn:(NSString *)imgname test:(NSString *)text;

/**
 *  显示自定义的HUD
 *
 *  @param imgname 自定图片的名称
 *  @param text    自定义的提示语
 */
+(void)SHOWHUDWITHImgn:(NSString *)imgname test:(NSString *)text;

/**
 *  在HUD上显示提示成功提示
 *
 *  @param HUD  显示的HUD
 *  @param text 提示语
 */
+(void)showOKHUDWithHUD:(MBProgressHUD *)HUD test:(NSString *)text;


/**
 *  显示提示成功提示
 *
 *  @param text 成功后的提示语
 */
+(void)showOKHUDWithText:(NSString *)text;

/**
 *  显示失败的提示 在HUD上显示
 *
 *  @param HUD  显示的HUD
 *  @param text 提示语
 */
+(void)showFailHUDWithHUD:(MBProgressHUD *)HUD text:(NSString *)text;

/**
 *  显示失败的提示
 *
 *  @param text 失败后的提示语
 */
+(void)showFailHUDWithText:(NSString *)text;

#pragma mark - RoundCornar
/**
 *  设置圆角
 *
 *  @param _v 设置的view
 *  @param r  弧度
 */
+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r;
/**
 *  设置圆角和边框的颜色（默认边框线的宽度为1像素）
 *
 *  @param _v   设置的view
 *  @param r    弧度
 *  @param c_bd 边框颜色
 */
+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r bdColor:(UIColor *)c_bd;

/**
 *  设置 圆角和边框的颜色以及边框的线的像素（默认的粗细是1像素）
 *
 *  @param _v   设置的view
 *  @param r    弧度
 *  @param c_bd 边框线的颜色
 *  @param w_bd 边框线的宽度
 */
+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r bdColor:(UIColor *)c_bd bdW:(float)w_bd;

/**
 *  设置  给指定的叫设定圆角
 *
 *  @param view        设置的view
 *  @param reectCorner 设置的角度的枚举
 *  @param size        角度大小
 */

+(void)setRonundCornerFor:(UIView *)view byRoundingCorners:(UIRectCorner)reectCorner withSize:(CGSize)size;

#pragma mark - bbi

/**
 *  返回自定义的barItem
 *
 *  @param tar  target
 *  @param act  点击后的方法
 *  @param text title
 *
 *  @return barItem
 */
+(UIBarButtonItem *)borderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text;


//返回返回的UIBarButtonItem action为navBackAction： 在UIViewController+navBack.h默认实现为popViewControllerAnimated： 可在tar里重写
+(UIBarButtonItem *)backItemWithTarget:(id)tar;



/**
 *  生成不带边框的barItem
 *
 *  @param tar  target
 *  @param act  点击后的方法
 *  @param text title
 *  @param textColor 正常  高亮

 *  @return <#return value description#>
 */

+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text textColor:(UIColor *)tColor textHColor:(UIColor *)hColor;



/**
 *  生成不带边框的barItem
 *
 *  @param tar  target
 *  @param act  点击后的方法
 *  @param text title
 *
 *  @return <#return value description#>
 */
+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text;

/**
 *  返回带图片的barItem
 *
 *  @param tar  target
 *  @param act  点击后的方法
 *  @param imgn 背景图片
 *
 *  @return 生成号的barItem
 */
+(UIBarButtonItem *)ImageItemWithTarget:(id)tar act:(SEL)act imgn:(NSString *)imgn;

+(UIBarButtonItem *)ImageItemWithTarget:(id)tar act:(SEL)act title:(NSString *)title ima:(UIImage *)ima;

#pragma mark - cell

/**
 *  设置cell的背景颜色
 *
 *  @param cell  操作的cell
 *  @param color 颜色
 */
+(void)setBgColorForCell:(UITableViewCell *)cell bgColor:(UIColor *)color;


@end
