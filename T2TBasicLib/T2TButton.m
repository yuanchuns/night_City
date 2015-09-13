//
//  T2T2TButton.m
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation T2TButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setNormalBgColor:(UIColor *)normal selectBgColor:(UIColor *)select{
    self.backgroundColor = normal;
    color_normal = normal;
    color_select = select;
}

-(void)setNormalBorderColor:(UIColor *)normal selectBorderColor:(UIColor *)select{
    border_color_normal = normal;
    border_color_select = select;
    self.layer.borderColor = [border_color_normal CGColor];
    self.layer.borderWidth = 1;
}

-(void)setNormalBgColor:(UIColor *)normal hightlightBgColor:(UIColor *)highlighted{
    self.backgroundColor = normal;
    bgcolor_normal = normal;
    bgcolor_highlighted = highlighted;
}

-(void)setNormalBgColor:(UIColor *)normal selectBgColor:(UIColor *)select hightlightBgColor:(UIColor *)highlighted{
    self.backgroundColor = normal;
    bgcolor_normal = normal;
    bgcolor_highlighted = highlighted;
    color_select = select;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (color_normal && !selected) {
        [self setBackgroundColor:color_normal];
        //        self.layer.borderColor = [border_color_normal CGColor];
        //        self.layer.borderWidth = 1;
    }
    if (color_select && selected) {
        [self setBackgroundColor:color_select];
        //        self.layer.borderColor = [border_color_select CGColor];
        //        self.layer.borderWidth = 1;
    }
    
    if (border_color_normal && !selected) {
        self.layer.borderColor = [border_color_normal CGColor];
        self.layer.borderWidth = 1;
    }
    if (border_color_select && selected) {
        self.layer.borderColor = [border_color_select CGColor];
        self.layer.borderWidth = 1;
    }
    
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    if (bgcolor_normal && !highlighted) {
        [self setBackgroundColor:bgcolor_normal];
    }
    if (bgcolor_highlighted && highlighted) {
        [self setBackgroundColor:bgcolor_highlighted];
    }
}

-(void)setBtnBorder:(int)orientation Thickness:(float)lineThickness color:(UIColor *)lineColor
{
    //orientation依次为上，右，下，左
    CGRect rect;
    switch (orientation) {
        case 0:
            rect.size.width = self.frame.size.width;
            rect.size.height = lineThickness;
            rect.origin.x = 0;
            rect.origin.y = 0;
            break;
        
        case 1:
            rect.size.width = lineThickness;
            rect.size.height = self.frame.size.height;
            rect.origin.x = self.frame.size.width;
            rect.origin.y = 0;
            break;
        case 2:
            rect.size.width = self.frame.size.width;
            rect.size.height = lineThickness;
            rect.origin.x = 0;
            rect.origin.y = self.frame.size.height;
            break;
        case 3:
            rect.size.width = lineThickness;
            rect.size.height = self.frame.size.height;
            rect.origin.x = 0;
            rect.origin.y = 0;
            break;
        default:
            break;
    }
    UIView *line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = lineColor;
    [self addSubview:line];
}

#pragma mark -


+(T2TButton *)btnWithFrame:(CGRect)rect Img:(UIImage *)img{
    T2TButton *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setBackgroundImage:img  forState:UIControlStateNormal];
    return btn;
}

+(T2TButton *)btnWithFrame:(CGRect)rect Img:(UIImage *)img title:(NSString *)title line:(NSInteger)ln{
    T2TButton *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    if(img) [btn setBackgroundImage:img forState:UIControlStateNormal];
    if(img) [btn setBackgroundImage:img forState:UIControlStateHighlighted];

    btn.titleLabel.numberOfLines = ln;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:(19-title.length)];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}


+(T2TButton *)btnWithFrame:(CGRect)rect Img:(UIImage *)img title:(NSString *)title{
    return [self btnWithFrame:rect Img:img title:title line:1];
}

+(T2TButton *)btnWithFrame:(CGRect)rect Img:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act{
    T2TButton *btn = [self btnWithFrame:rect Img:img title:title];
    [btn addTarget:target action:act forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+(T2TButton *)greenBtnWithFrame:(CGRect)rect title:(NSString *)title target:(id)target Action:(SEL)act{
    T2TButton *btn = [self btnWithFrame:rect Img:nil title:title target:target Action:act];
    //    [btn setNormalBgColor:K_COLOR_T8TGREEN hightlightBgColor:K_COLOR_T8TGREEN_SELECTED];
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor clearColor].CGColor;
    return btn;
}

+(T2TButton *)btnWithImg:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act{
    return [self btnWithFrame:CGRectMake(0, 0, img.size.width, img.size.height) Img:img title:title target:target Action:act];
}

+(T2TButton *)btnWithImg:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act center:(CGPoint)ct{
    T2TButton *btn = [self btnWithFrame:CGRectMake(0, 0, img.size.width, img.size.height) Img:img title:title target:target Action:act];
    btn.center = ct;
    return btn;
}

+(T2TButton *)btnWithImg:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act titleColor:(UIColor *)color{
    T2TButton *btn = [self btnWithFrame:CGRectMake(0, 0, img.size.width, img.size.height) Img:img title:title target:target Action:act];
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}

+(T2TButton *)btnWithImg:(UIImage *)img title:(NSString *)title target:(id)target Action:(SEL)act center:(CGPoint)ct titleColor:(UIColor *)color{
    T2TButton *btn = [self btnWithFrame:CGRectMake(0, 0, img.size.width, img.size.height) Img:img title:title target:target Action:act];
    btn.center = ct;
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}

+(T2TButton *)btnWithFrame:(CGRect)rect Title:(NSString *)title titleFont:(UIFont *)ft aboveImg:(UIImage *)img imgCenter:(CGPoint)ct_img target:(id)target Action:(SEL)act{
    T2TButton *btn = [self btnWithFrame:rect Img:nil title:title target:target Action:act];
    btn.titleLabel.font = ft;
    //    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    //    btn.layer.borderWidth = 1;
    UIImageView *imgv = [[UIImageView alloc]initWithImage:img];
    [btn addSubview:imgv];
    imgv.center = ct_img;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, img.size.width, 0, 0)];//2+10
    return btn;
}

+(T2TButton *)btnWithTitle:(NSString *)title titleFont:(UIFont *)ft aboveImg:(UIImage *)img target:(id)target Action:(SEL)act{
    
    T2TButton *btn = [self btnWithFrame:CGRectMake(0, 0, img.size.width+[title sizeWithFont:ft].width+20, img.size.height) Title:title titleFont:ft aboveImg:img imgCenter:CGPointMake(img.size.width/2, img.size.height/2) target:target Action:act];
    return btn;
    
    //    T2TButton *btn = [self btnWithFrame:CGRectMake(0, 0, img.size.width+[title sizeWithFont:ft].width+20, img.size.height) Img:nil title:title target:target Action:act];
    //    btn.titleLabel.font = ft;
    ////    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    ////    btn.layer.borderWidth = 1;
    //    UIImageView *imgv = [[UIImageView alloc]initWithImage:img];
    //    [btn addSubview:imgv];
    //    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, img.size.width, 0, 0)];//2+10
    //    return btn;
}

+(T2TButton *)btnWithTitle:(NSString *)title aboveImg:(UIImage *)img target:(id)target Action:(SEL)act{
    
    return [self btnWithTitle:title titleFont:[UIFont boldSystemFontOfSize:18] aboveImg:img target:target Action:act];
}

+(T2TButton *)backBtnForTaget:(id)tar action:(SEL)act{
    UIImage *img_back = [UIImage imageNamed:@"back"];
    T2TButton *btn = [self btnWithTitle:@"返回" aboveImg:img_back target:tar Action:act];
    //    UIButton *btn = [self btnWithFrame:CGRectMake(0, 0, img_back.size.width+60, img_back.size.height) Img:nil title:@"返回" target:tar Action:act];
    //    UIImageView *imgv = [[UIImageView alloc]initWithImage:img_back];
    //    [btn addSubview:imgv];
    //    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, img_back.size.width/2+10, 0, 0)];
    return btn;
}

+(T2TButton *)backBtnEvent:(id)tar CGrectMarkFrame:(CGRect)fra
{
    //    T2TButton *back_btn = [T8TView btnWithFrame:fra Img:nil title:@"返回" target:self Action:@selector(popViewControllerAnimated:)];
    UIViewController *vc = (UIViewController *)tar;
    T2TButton *back_btn = [self btnWithFrame:fra Img:nil title:@"返回" target:vc.navigationController Action:@selector(popViewControllerAnimated:)];
    back_btn.layer.masksToBounds = YES;
    back_btn.layer.cornerRadius = 2.0;
    back_btn.backgroundColor = [UIColor colorWithRed:147.0/255.0 green:185.0/255.0 blue:14.0/255.0 alpha:1];
    return back_btn;
}

+(T2TButton *)backBtnNavHiddenEvent:(id)tar Action:(SEL)act
{
    T2TButton *back_btn = [self btnWithFrame:CGRectMake(13, 30, 22, 40) Img:nil title:@"" target:tar Action:act];
    [back_btn setImage:[UIImage imageNamed:@"ico_backArrow_white"] forState:UIControlStateNormal];
    [back_btn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 6, 14)];
    return back_btn;
}


@end
