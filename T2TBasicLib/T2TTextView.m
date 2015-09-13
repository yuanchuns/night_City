//
//  T2TTextView.m
//  T2TBasicLib
//
//  Created by mark on 15/6/8.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TTextView.h"
#import "UIView+AddOther.h"
#import "T2TCommonAction.h"
@interface T2TTextView ()

@property (nonatomic, strong) UILabel *lblPlaceHolder;

@end

@implementation T2TTextView

- (void)awakeFromNib{

    [self initOtherInfo];
    
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self initOtherInfo];
    }
    
    return self;
}

- (void)initOtherInfo{
    self.lblPlaceHolder = [[UILabel alloc] init];
    self.lblPlaceHolder.backgroundColor = [UIColor clearColor];
    self.lblPlaceHolder.numberOfLines = 0;
    self.lblPlaceHolder.font = [UIFont systemFontOfSize:15];
    self.lblPlaceHolder.textColor = [UIColor colorWithHexString:@"#dbdbdb"];
    [self addSubview:self.lblPlaceHolder];
    
    self.placeHodlerTextFont = [UIFont systemFontOfSize:15];
    self.placeHodlerTextColor = [UIColor colorWithHexString:@"#dbdbdb"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    CGFloat height = [T2TCommonAction heightFoStr:self.placeHolder font:self.placeHodlerTextFont width:self.width-2*5];
    self.lblPlaceHolder.frame = CGRectMake(5, 8, self.width-2*5, height);
}

- (void)textDidChange {

    self.lblPlaceHolder.hidden = self.hasText;
}

- (void)setPlaceHolder:(NSString *)placeHolder {

    _placeHolder = placeHolder;
    self.lblPlaceHolder.text = placeHolder;
}

- (void)setPlaceHodlerTextColor:(UIColor *)placeHodlerTextColor {

    _placeHodlerTextColor = placeHodlerTextColor;
    self.lblPlaceHolder.textColor = placeHodlerTextColor;
}


- (void)setPlaceHodlerTextFont:(UIFont *)placeHodlerTextFont{

    _placeHodlerTextFont = placeHodlerTextFont;
    self.lblPlaceHolder.font = placeHodlerTextFont;
}

//- (void)dealloc {
//
//    self.lblPlaceHolder = nil;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
