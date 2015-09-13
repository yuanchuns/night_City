//
//  NSString+TDigest.m
//  HouseKeeper
//
//  Created by mark to on 12-12-12.
//  Copyright (c) 2014年 233. All rights reserved.
//

#import "NSString+TDigest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TDigest)


+ (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password

{
    
    NSRange range;
    
    BOOL result =NO;
    
    for(int i=0; i < [_termArray count]; i++)
        
    {
        
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        
        if(range.location != NSNotFound)
            
        {
            
            result =YES;
            
        }
        
    }
    
    return result;
    
}

//条件

+ (psdRank) judgePasswordStrength:(NSString*) _password

{
    
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    
    
    
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    
    
    
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
    
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
    
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
    
    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];
    
    
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    
    
    
    int intResult=0;
    
    for (int j=0; j<[resultArray count]; j++)
        
    {
        
        
        
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"])
            
        {
            
            intResult++;
            
        }
        
    }
    
//    NSString* resultString = [[NSString alloc] init];
    psdRank rankType = psdLowRank;
    if (intResult <2)
        
    {
        rankType = psdLowRank;
//        resultString = @"密码强度低，建议修改";
        
    }
    
    else if (intResult == 2&&[_password length]>=6)
    
    {
        rankType = psdMidRank;
//        resultString = @"密码强度一般";
        
    }
    
    if (intResult > 2&&[_password length]>=6)
        
    {
        rankType = psdHighRank;
//        resultString = @"密码强度高";
        
    }
    
    
    
    return rankType;
    
}

- (NSString *)md5Digest
{
    const char* cstr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, strlen(cstr), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}


- (NSString *)getMd5_16Bit
{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

- (NSString *)getMd5_32Bit
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}


-(NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)rangeFont  rangeColor:(UIColor*)rangeColor otherStrFont:(UIFont *)font clolor:(UIColor *)color{
 
   
    NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *att  = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributeWithRangeOfString:aString Font:rangeFont color:rangeColor]];
    if (range.location != 0 && range.length > 0) {
       NSRange rangePre = NSMakeRange(0, range.location);
        [att addAttribute:NSForegroundColorAttributeName value:color range:rangePre];
        [att addAttribute:NSFontAttributeName value:font range:rangePre];
      
    }
    if (range.location+range.length<self.length) {
        NSUInteger len = self.length-range.location-range.length;
        NSRange endRange = NSMakeRange(range.location+range.length,len);
        [att addAttribute:NSForegroundColorAttributeName value:color range:endRange];
        [att addAttribute:NSFontAttributeName value:font range:endRange];
    }
    return att;
}


- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString color:(UIColor *)color
{
    NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self];
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attribute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:range];
    return attribute;
}

- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)font{
    NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self];
    [attribute addAttribute:NSFontAttributeName value:font range:range];
    return attribute;
}

- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString Font:(UIFont *)font color:(UIColor *)color{
    NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self];
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attribute addAttribute:NSFontAttributeName value:font range:range];
    return attribute;

}

- (NSString *)trimSpace
{
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimAllSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSUInteger)t_lenght{
    
    NSUInteger len = 0;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    len = [self lengthOfBytesUsingEncoding:enc];
    return len;
   
}

-(BOOL)isAllNum{
    unichar c;
    for (int i=0; i<self.length; i++) {
        c=[self characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}


-(NSString *)filterHTML:(NSString *)html
{
//    NSScanner * scanner = [NSScanner scannerWithString:html];
//    NSString * text = nil;
//    while([scanner isAtEnd]==NO)
//    {
//        //找到标签的起始位置
//        [scanner scanUpToString:@"<" intoString:nil];
//        //找到标签的结束位置
//        [scanner scanUpToString:@">" intoString:&text];
//        //替换字符
//        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
//    }
    NSString * regEx = @"<([^>]*)>";
    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

@end
