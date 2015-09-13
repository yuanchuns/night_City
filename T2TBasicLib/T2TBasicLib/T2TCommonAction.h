//
//  T2TCommonAction.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T2TBasicLib.h"
@interface T2TCommonAction : NSObject
#pragma mark -
//设置UIView禁用 过time秒后解禁  主要用于申请提交数据到后台避免重复提交
+(void)setView:(UIView *)v disEnabledFor:(float)time;
#pragma mark -  字符串占位处理
//获取NSAttributedString显示的高度
+(float)getAttributedStringHeightWithString:(NSAttributedString *)string WidthValue:(int)width;
//设置行间距
+(NSMutableAttributedString *)atsForStr:(NSString *)str lineHeight:(float) h;
//设置行间距 是否用于计算
+(NSMutableAttributedString *)atsForStr:(NSString *)str lineHeight:(float) h forCompute:(BOOL)forCompute;
//获取设置行间距的NSAttributedString的高度
+(float)heightForAtsWithStr:(NSString *)str font:(UIFont *)ft width:(float)w lineH:(float )lh;
//获取字符串显示的高度
+(float)heightFoStr:(NSString *)str font:(UIFont *)ft width:(float)w;
//获取字符串显示的高度 可设置最大行数
+(float)heightFoStr:(NSString *)str font:(UIFont *)ft width:(float)w maxLine:(NSUInteger)lineNum;
///获取设置行间距的NSAttributedString的高度 限制行数
+(float)heightForAtsWithStr:(NSString *)str font:(UIFont *)ft width:(float)w lineH:(float)lineGap maxLine:(NSUInteger)lineNum;
//获取文字的宽度
+(float)widthWithFont:(UIFont *)font str:(NSString *)str;

//获取给定size的换行符
+(NSString *)strOfLineForSize:(CGSize)s withFont:(UIFont *)ft;
//获取给定width的空格符
+(NSString *)strOfSpaceForWidth:(float)width withFont:(UIFont *)ft;

//根据cell的子视图获取cell的NSIndexPath
+(NSIndexPath *)indexPathForCellSubView:(UIView *)sv fromTable:(UITableView *)table;
//根据cell的子视图获取cell的row
+(NSUInteger)rowForCellSubView:(UIView *)sv fromTable:(UITableView *)table;
//根据cell的子视图获取cell的section
+(NSUInteger)sectionForCellSubView:(UIView *)sv fromTable:(UITableView *)table;

//给view设置边框
+(void)setViewBorder:(UIView *)view;

#pragma mark -

//获取.bundle里面资源的路径
+(NSString *)pathForResourceWithBundleName:(NSString *)strBundleName fileName:(NSString *)fileName;

#pragma mark -

+(void)saveImg:(UIImage *)img;

#pragma mark -

+(NSString *)dateStringForFormat:(NSString *)format timeInterval:(double)interval;

/**
 *  限定UITextField输入的字符长度
 *
 *  @param textFiled 需要限制的textFiled
 *  @param length    限定的长度
 */
+(void)limitTextFiledLength:(UITextField *)textFiled withLen:(NSUInteger)length;

/**
 *  限定textView的输入长度
 *
 *  @param textView 被限定的TextView
 *  @param length   限定输入的长度
 */
+(void)limitTextViewLength:(UITextView *)textView withLen:(NSUInteger)length;

@end
