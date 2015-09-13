//
//  UIColor+HexString.m
//
//  Created by Zhu Yuzhou on 1/20/13.
//

#import "UIColor+HexString.h"

//@interface UIColor()
//
//+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;
//
//@end


@implementation UIColor(HexString)

+(UIColor *) colorWithHexString: (NSString *) hexString alpha:(float)alpha{
    if (![hexString isKindOfClass:[NSString class]] || hexString.length<1) {
        
        return nil;
    }
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat  red= 0.0, blue = 0.0, green = 0.0;
    switch ([colorString length]) {
        case 3: // #RGB
            
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            //            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
    
}

+ (UIColor *) colorWithHexString: (NSString *) hexString
{
    
    return [self colorWithHexString:hexString alpha:1];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

#pragma mark -

//id unrecognized(id self,SEL _cmd)
//{
//    [TLog logErrorInfo:[NSString stringWithFormat:@"%@ unrecognized:%s",self,sel_getName(_cmd)]];
//    return nil;
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    class_addMethod([self class], sel,(IMP)unrecognized, "@@:");
//    return [super resolveInstanceMethod:sel];
//}


@end
