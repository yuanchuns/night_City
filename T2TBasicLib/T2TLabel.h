//
//  T2TLabel.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T2TLabel : UILabel
{
    UIEdgeInsets _textEdge;
}

/*
 
 参数：
 rect   位置大小
 font   字体大小，可传UIFont格式或NSNumber格式,NSNumber默认转化为[UIFont systemFontOfSize:[number floatValue]]; 可为nil
 text   显示的文字 可为nil
 aColor  文字颜色 可为nil
 align   对齐方式
 num   行数
 
 */
+(T2TLabel *)lblWithFram:(CGRect)rect font:(id)font;
+(T2TLabel *)lblWithFram:(CGRect)rect str:(NSString *)text;
+(T2TLabel *)lblWithFram:(CGRect)rect font:(id)font str:(NSString *)text;
+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor font:(id)font;
+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor str:(NSString *)text font:(id)font;
+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor font:(id)font align:(NSTextAlignment)align;
+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor str:(NSString *)text lineNum:(NSInteger)num;
+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor str:(NSString *)text lineNum:(NSInteger)num font:(id)font;
+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor bgColor:(UIColor *)bgColor str:(NSString *)text font:(id)font;
+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor str:(NSString *)text font:(id)font align:(NSTextAlignment)align;

//设置行间距，已经对一行的情况做设置行间距为0的处理
-(void)setAtsWithStr:(NSString *)str lineGap:(float)lineGap;

-(void)setEdgeInsets:(UIEdgeInsets)edge;
@end
