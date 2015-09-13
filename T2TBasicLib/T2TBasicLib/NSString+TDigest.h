//
//  NSString+TDigest.h
//  HouseKeeper
//
//  Created by mark to on 14-12-12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T2TBasicLib.h"

typedef enum {
   psdLowRank = 1,
    psdMidRank = 2,
    psdHighRank = 3
}psdRank;

@interface NSString (TDigest)

//md5 16位加密
- (NSString *)getMd5_16Bit;

//md5 32位加密
- (NSString *)getMd5_32Bit;

/**
 *  设置关键字字体大小和颜色
 *
 *  @param aString 关键字
 *  @param font    关键字字体大小
 *  @param color   关键字字体颜色
 *
 *  @return 格式字符串
 */
- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)font color:(UIColor *)color;

/**
 *  设置关键字大小
 *
 *  @param aString 关键字
 *  @param font    字体大小
 *
 *  @return 设置好 后的格式字符串
 */
- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)font;

/**
 *  设置特殊字的字体和颜色
 *
 *  @param aString    关键字
 *  @param rangeFont  关键字字体大小
 *  @param rangeColor 关键字颜色
 *  @param font       其他文字字体大小
 *  @param color      其他字体颜色
 *
 *  @return 设置好后的格式字符串
 */
-(NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)rangeFont  rangeColor:(UIColor*)rangeColor otherStrFont:(UIFont *)font clolor:(UIColor *)color;

//不区分大小写查找文字，并添加颜色
- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString color:(UIColor *)color;

/**
 *  去掉空格后字符串的长度
 *
 *  @return 去掉字符串后的字符串
 */
- (NSString *)trimSpace;

/**
 *  替换掉空格后字符串的长度
 *
 *  @return
 */
- (NSString *)trimAllSpace;

/**
 *  字符串字节长度
 *
 *  @return 长度
 */
-(NSUInteger)t_lenght;
/**
 *  判断字符串是否全部是数字
 *
 *
 *  @return yes表示是 no表示不全是数字
 */
-(BOOL)isAllNum;

/**
 *  剔除html中的标签
 *
 *  @param html 原html内容
 *
 *  @return 剔除后的html内容
 */
-(NSString *)filterHTML:(NSString *)html;

///判断密码强度
+ (psdRank) judgePasswordStrength:(NSString*) _password;

@end
