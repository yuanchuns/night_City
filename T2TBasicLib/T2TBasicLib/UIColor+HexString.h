//
//  UIColor+HexString.h
//  Class to convert hex string to UIColor
//  Support #RGB # ARGB #RRGGBB #AARRGGBB
//  Usage: [UIColor colorWithHexString:@"#f5e6a1"];
//  Created by Zhu Yuzhou on 1/20/13.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

/**
 *  根据十六进制数生成颜色值
 *
 *  @param hexString 十六进制字符串
 *
 *  @return 文字颜色
 */
+ (UIColor *) colorWithHexString: (NSString *) hexString;

/**
 *  根据十六进制生成颜色
 *
 *  @param hexString 十六进制字符串
 *  @param alpha     透明度
 *
 *  @return 颜色
 */
+(UIColor *) colorWithHexString: (NSString *) hexString alpha:(float)alpha;

//+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;

@end
