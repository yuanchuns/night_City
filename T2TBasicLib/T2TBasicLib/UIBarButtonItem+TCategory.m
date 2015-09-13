//
//  UIBarButtonItem+TCategory.m
//  TBasicLib
//
//  Created by mark on 14-12-12.
//  Copyright (c) 2014年 233. All rights reserved.
//

#import "UIBarButtonItem+TCategory.h"
#import "T2TBasicLib.h"
@implementation UIBarButtonItem (TCategory)



+(UIBarButtonItem *)borderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text{
    UIImage *imgOriginal = [UIImage imageNamed:kBorderBBIBgImgName];
    UIImage *imgFit = [imgOriginal stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    float btnWidth = [text sizeWithFont:FONT_BBI].width+30;
    UIButton *btn = [T2TButton btnWithFrame:CGRectMake(0, 0, btnWidth, imgOriginal.size.height) Img:imgFit title:text target:tar Action:act];// [T8TView btnWithImg:[UIImage imageNamed:kBorderBBIBgImgName] title:text target:tar Action:act];
    btn.titleLabel.font = FONT_BBI;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bbi;
}

+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text{
    
    UIButton *btn = [T2TButton btnWithFrame:CGRectMake(0, 0, [text sizeWithFont:FONT_BBI constrainedToSize:CGSizeMake(1000, 1000)].width+10, 30) Img:nil title:text target:tar Action:act];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = FONT_BBI;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bbi;
}


+(UIBarButtonItem *)backItemWithTarget:(id)tar{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
//    btn.backgroundColor = [UIColor yellowColor];
    [btn setImage:[UIImage imageNamed:kBackBBIImgName] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -btn.width+(kIsIOS7?-7:0), 0, 0)];
    [btn addTarget:tar action:@selector(navBackAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.clipsToBounds = NO;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
//    UIButton *btn_back = [T8TView btnWithImg:[UIImage imageNamed:kBackBBIImgName] title:@"" target:tar Action:@selector(navBackAction:)];
//    
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, btn_back.width, btn_back.height)];
//    btn_back.left =  kIsIOS7?-7:0;
//    [bgView addSubview:btn_back];
//    return [[TBarButtonItem alloc]initWithCustomView:bgView];
}

+(UIBarButtonItem *)ImageItemWithTarget:(id)tar act:(SEL)act imgn:(NSString *)imgn{
    UIButton *btn = [T2TButton btnWithImg:[UIImage imageNamed:imgn] title:@"" target:tar Action:act];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(UIBarButtonItem *)ImageItemWithTarget:(id)tar act:(SEL)act img:(UIImage *)img{
    UIButton *btn = [T2TButton btnWithImg:img title:@"" target:tar Action:act];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}


-(void)setTextItemEnable:(BOOL)isEnable{
    [self setTextItemEnable:isEnable diaEnableColor:[UIColor colorWithHexString:@"#5c6368"]];
}

-(void)setTextItemEnable:(BOOL)isEnable diaEnableColor:(UIColor *)color{
    UIButton *btn = (UIButton *)self.customView;
    if (![btn isKindOfClass:[UIButton class]]) {
        return;
    }
    if (isEnable) {
        color = kBarIsEnableColor;
    }
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.selected = !isEnable;
    self.enabled = isEnable;
}


-(void)setTextItemTextColor:(UIColor *)color{
    UIButton *btn = (UIButton *)self.customView;
    if (![btn isKindOfClass:[UIButton class]]) {
        return;
    }
    [btn setTitleColor:color forState:UIControlStateNormal];
    
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
