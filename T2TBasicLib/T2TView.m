//
//  T2TView.m
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TView.h"
#import <QuartzCore/QuartzCore.h>
@implementation T2TView
#pragma mark - textfield

+(UITextField *)tfWithFrame:(CGRect)rect borderstyle:(UITextBorderStyle)bs placeholder:(NSString *)str delegate:(id)tar{
    UITextField *tf = [[UITextField alloc]initWithFrame:rect];
    tf.borderStyle = bs;
    tf.placeholder = str;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.delegate = tar;
    
    return tf;
}

+(UITextField *)tfWithFrame:(CGRect)rect border:(UITextBorderStyle)bs {
    UITextField *tf = [[UITextField alloc]initWithFrame:rect];
    tf.borderStyle = bs;
    
    return tf;
}
+(UITextField *)tfWithFrame:(CGRect)rect borderColor:(UIColor *)bdColor placeholder:(NSString *)str delegate:(id)tar{
    UITextField *tf = [[UITextField alloc]initWithFrame:rect];
    tf.borderStyle = UITextBorderStyleNone;
    tf.placeholder = str;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.delegate = tar;
    tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, rect.size.height)];
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    tf.layer.borderColor = bdColor.CGColor;
    tf.layer.borderWidth = 0.5;
    
    return tf;
}

+(UITextField *)tfWithFrame:(CGRect)rect bgImg:(UIImage *)img placeholder:(NSString *)str delegate:(id)tar{
    UITextField *tf = [[UITextField alloc]initWithFrame:rect];
    tf.borderStyle = UITextBorderStyleNone;
    tf.placeholder = str;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.delegate = tar;
    tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, rect.size.height)];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.returnKeyType = UIReturnKeyDone;
    tf.background = img;
    
    return tf;
}

+(UITextField *)tfWithFrame:(CGRect)rect borderColor:(UIColor *)bdColor{
    UITextField *tf = [[UITextField alloc]initWithFrame:rect];
    tf.borderStyle = UITextBorderStyleNone;
    
    tf.layer.borderColor = bdColor.CGColor;
    tf.layer.borderWidth = 1;
    
    return tf;
}




+(UITextField *)tfWithFrame:(CGRect)rect{
    
    return [self tfWithFrame:rect border:UITextBorderStyleLine];
}



#pragma mark - HUD

//显示HUD 可自定图片、文字
+(void)SHOWHUDWITHHUD:(MBProgressHUD *)HUD imgn:(NSString *)imgname test:(NSString *)text{   
    UIImage *img = [UIImage imgAtBasicLibBundleWithName:imgname];
    HUD.customView = [[UIImageView alloc]initWithImage:img];
    HUD.mode = MBProgressHUDModeCustomView;
    if ([text isKindOfClass:[NSString class]]) {
        HUD.labelText = text;
    }
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.0];
   
}

+(void)SHOWHUDWITHImgn:(NSString *)imgname test:(NSString *)text{
    UIWindow *window = kCurrentWindow;//[[UIApplication sharedApplication].windows firstObject];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:window];
    HUD.center = CGPointMake(160, kScreenHeight/2);
    [window addSubview:HUD];
    [T2TView SHOWHUDWITHHUD:HUD imgn:imgname test:text];
}

//显示HUD 可自定文字
+(void)showOKHUDWithHUD:(MBProgressHUD *)HUD test:(NSString *)text{
    [self SHOWHUDWITHHUD:HUD imgn:kSuccessHUDImgName test:text];
}

+(void)showFailHUDWithHUD:(MBProgressHUD *)HUD text:(NSString *)text{
    [self SHOWHUDWITHHUD:HUD imgn:kFailHUDImgName test:text];
}

+(void)showFailHUDWithText:(NSString *)text{
    UIWindow *window = kCurrentWindow;//[[UIApplication sharedApplication].windows firstObject];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:window];
    HUD.center = CGPointMake(160, kScreenHeight/2);
    [window addSubview:HUD];
    
    [self showFailHUDWithHUD:HUD text:text];
}


//显示提示成功的HUD 可自定文字
+(void)showOKHUDWithText:(NSString *)text{
    UIWindow *window = kCurrentWindow;//[[UIApplication sharedApplication].windows firstObject];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:window];
    HUD.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    [window addSubview:HUD];
    
    [self showOKHUDWithHUD:HUD test:text];
}


#pragma mark - RoundCornar

+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r bdColor:(UIColor *)c_bd bdW:(float)w_bd{
    _v.layer.masksToBounds = YES;
    _v.layer.cornerRadius = r;
    _v.layer.borderWidth = w_bd;
    _v.layer.borderColor = c_bd.CGColor;
}

+(void)setRonundCornerFor:(UIView *)view byRoundingCorners:(UIRectCorner)reectCorner withSize:(CGSize)size{

    UIBezierPath *bzPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:reectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = bzPath.CGPath;
    view.layer.mask = maskLayer;
}

+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r bdColor:(UIColor *)c_bd{
    [self setRoundCornerFor:_v radiu:r bdColor:c_bd bdW:1];
}

+(void)setRoundCornerFor:(UIView *)_v radiu:(float)r{
    
    [self setRoundCornerFor:_v radiu:r bdColor:[UIColor clearColor] bdW:1];
    
}



#pragma mark - bbi




+(UIBarButtonItem *)borderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text{
    UIButton *btn = [T2TButton btnWithImg:[UIImage imageNamed:@"bbi_border"] title:text target:tar Action:act];
    btn.titleLabel.font = FONT_BBI;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bbi;
}

+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text textColor:(UIColor *)tColor textHColor:(UIColor *)hColor
{
    UIButton *btn = [T2TButton btnWithFrame:CGRectMake(0, 0, [T2TCommonAction widthWithFont:FONT_BBI str:text], 30) Img:nil title:text target:tar Action:act];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:tColor forState:UIControlStateNormal];
    [btn setTitleColor:hColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = FONT_BBI;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bbi;

}


+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text{
    
    //    if (kIsIOS7) {
    //        return [[UIBarButtonItem alloc]initWithTitle:text style:UIBarButtonItemStylePlain target:tar action:act];
    //    }
    UIButton *btn = [T2TButton btnWithFrame:CGRectMake(0, 0, [T2TCommonAction widthWithFont:FONT_BBI str:text], 30) Img:nil title:text target:tar Action:act];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:RGB_255(255, 255, 255) forState:UIControlStateNormal];
    [btn setTitleColor:RGB_255(220, 220, 220) forState:UIControlStateHighlighted];
    btn.titleLabel.font = FONT_BBI;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bbi;
}


+(UIBarButtonItem *)backItemWithTarget:(id)tar{
    UIButton *btn_back = [T2TButton btnWithImg:[UIImage imageNamed:@"btn_back_white"] title:@"" target:tar Action:@selector(navBackAction:)];
    return [[UIBarButtonItem alloc]initWithCustomView:btn_back];
}

+(UIBarButtonItem *)ImageItemWithTarget:(id)tar act:(SEL)act imgn:(NSString *)imgn{
    UIButton *btn = [T2TButton btnWithImg:[UIImage imageNamed:imgn] title:@"" target:tar Action:act];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(UIBarButtonItem *)ImageItemWithTarget:(id)tar act:(SEL)act title:(NSString *)title ima:(UIImage *)ima{
    UIButton *btn = [T2TButton btnWithImg:ima title:title target:tar Action:act];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

#pragma mark - cell

+(void)setBgColorForCell:(UITableViewCell *)cell bgColor:(UIColor *)color{
//    UIView *bg = [[UIView alloc]init];
//    bg.backgroundColor = color;
//    [cell setBackgroundView:bg];

    cell.backgroundColor = color;
    cell.textLabel.backgroundColor = cell.detailTextLabel.backgroundColor = color;
}
@end
