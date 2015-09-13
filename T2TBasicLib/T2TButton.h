//
//  T2T2TButton.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T2TButton : UIButton
{
    UIColor *color_normal;
    UIColor *color_select;
    
    UIColor *border_color_normal;
    UIColor *border_color_select;
    
    UIColor *bgcolor_normal;
    UIColor *bgcolor_highlighted;
}
//用于多个btn之间的排序，默认为0，需要自己赋值；
@property (nonatomic,assign) NSInteger index;

//设置默认背景颜色、选中背景颜色
-(void)setNormalBgColor:(UIColor *)normal selectBgColor:(UIColor *)select;
//设置默认边框颜色、选中边框颜色
-(void)setNormalBorderColor:(UIColor *)normal selectBorderColor:(UIColor *)select;
//设置默认背景颜色、高亮背景颜色
-(void)setNormalBgColor:(UIColor *)normal hightlightBgColor:(UIColor *)highlighted;
//设置默认背景颜色、选中背景颜色、高亮背景颜色
-(void)setNormalBgColor:(UIColor *)normal selectBgColor:(UIColor *)select hightlightBgColor:(UIColor *)highlighted;

//设置边框orientation依次为0上，1右，2下，3左
-(void)setBtnBorder:(int)orientation Thickness:(float)lineThickness color:(UIColor *)lineColor;

#pragma mark -


+(T2TButton *)btnWithFrame:(CGRect)rect Img:(UIImage *)img;
+(T2TButton *)btnWithFrame:(CGRect)rect Img:(UIImage *)img title:(NSString *)title;
+(T2TButton *)btnWithFrame:(CGRect)rect Img:(UIImage *)img title:(NSString *)title line:(NSInteger)ln;
+(T2TButton *)btnWithFrame:(CGRect)rect Img:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act;

+(T2TButton *)btnWithImg:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act;
+(T2TButton *)btnWithImg:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act center:(CGPoint)ct;
+(T2TButton *)btnWithImg:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act titleColor:(UIColor *)color;
+(T2TButton *)btnWithImg:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act center:(CGPoint)ct titleColor:(UIColor *)color;

+(T2TButton *)backBtnForTaget:(id)tar action:(SEL)act;
+(T2TButton *)backBtnEvent:(id)tar CGrectMarkFrame:(CGRect)fra;
+(T2TButton *)backBtnNavHiddenEvent:(id)tar Action:(SEL)act;
+(T2TButton *)btnWithTitle:(NSString *)title aboveImg:(UIImage *)img target:(id)target Action:(SEL)act;
+(T2TButton *)btnWithTitle:(NSString *)title titleFont:(UIFont *)ft aboveImg:(UIImage *)img target:(id)target Action:(SEL)act;

+(T2TButton *)btnWithFrame:(CGRect)rect Title:(NSString *)title titleFont:(UIFont *)ft aboveImg:(UIImage *)img imgCenter:(CGPoint)ct_img target:(id)target Action:(SEL)act;
+(T2TButton *)greenBtnWithFrame:(CGRect)rect title:(NSString *)title target:(id)target Action:(SEL)act;

@end
