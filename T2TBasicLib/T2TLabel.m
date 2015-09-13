//
//  T2TLabel.m
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TLabel.h"

#import "T2TCommonAction.h"

@implementation T2TLabel
+(T2TLabel *)lblWithFram:(CGRect)rect font:(id)font{
    return [self lblWithFram:rect font:font str:nil];
}


+(T2TLabel *)lblWithFram:(CGRect)rect str:(NSString *)text{
    return [self lblWithFram:rect font:nil str:text];
}


+(T2TLabel *)lblWithFram:(CGRect)rect font:(id)font str:(NSString *)text{
    return [self lblWithFram:rect textColor:nil str:text lineNum:1 font:font];
}

+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor str:(NSString *)text lineNum:(NSInteger)num font:(UIFont *)font{
    T2TLabel *lbl = [[T2TLabel alloc]initWithFrame:rect];
    if([text isKindOfClass:[NSString class]])lbl.text = text;
    if(aColor)lbl.textColor = aColor;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.numberOfLines = num;
    
    if ([font isKindOfClass:[UIFont class]]) {
        lbl.font = font;
    }else if ([font isKindOfClass:[NSNumber class]]){
        NSNumber *number = (NSNumber *)font;
        lbl.font = [UIFont systemFontOfSize:[number floatValue]];
    }
    return lbl;
}


+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor str:(NSString *)text lineNum:(NSInteger)num{
    
    return [self lblWithFram:rect textColor:aColor str:text lineNum:num font:[UIFont systemFontOfSize:18]];
}

+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor str:(NSString *)text font:(UIFont *)font{
    
    return [self lblWithFram:rect textColor:aColor str:text lineNum:1 font:font];
}

+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor bgColor:(UIColor *)bgColor str:(NSString *)text font:(UIFont *)font{
    T2TLabel *lbl = [self lblWithFram:rect textColor:aColor str:text font:font];
    if([bgColor isKindOfClass:[UIColor class]])lbl.backgroundColor = bgColor;
    return lbl;
}

+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor font:(UIFont *)font{
    return [self lblWithFram:rect textColor:aColor str:@"" lineNum:1 font:font];
}

+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor font:(UIFont *)font align:(NSTextAlignment)align{
    T2TLabel *lbl = [self lblWithFram:rect textColor:aColor str:@"" lineNum:1 font:font];
    lbl.textAlignment = align;
    return lbl;
}
+(T2TLabel *)lblWithFram:(CGRect)rect textColor:(UIColor *)aColor str:(NSString *)text font:(UIFont *)font align:(NSTextAlignment)align{
    T2TLabel *lbl = [self lblWithFram:rect textColor:aColor str:@"" lineNum:1 font:font];
    lbl.textAlignment = align;
    lbl.text = text;
    return lbl;
}

#pragma mark -

-(void)setAtsWithStr:(NSString *)str lineGap:(float)lineGap{
    self.attributedText = [T2TCommonAction atsForStr:str lineHeight:(self.height<self.font.pointSize*2+lineGap)?0:lineGap];
}

-(void)setEdgeInsets:(UIEdgeInsets)edge{
    _textEdge = edge;
    [self setNeedsDisplay];
}

#pragma mark -

-(void)setAttributedText:(NSAttributedString *)attributedText{
    if ([self respondsToSelector:@selector(setAttributedText:)]) {
        
        [super setAttributedText:attributedText];
    }else{
        
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _textEdge = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

-(void)drawTextInRect:(CGRect)rect{
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textEdge)];
}
@end
