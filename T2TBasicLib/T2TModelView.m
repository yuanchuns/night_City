//
//  T2TModelView.m
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TModelView.h"

@implementation T2TModelBackGroudView



@end

@implementation T2TModelView
+(void)tapActionForBGView:(UITapGestureRecognizer *)sender{
    
    T2TModelBackGroudView *aView = (T2TModelBackGroudView *)sender.view;
    UIView *subView = [aView.subviews firstObject];
    if (subView) {
        CGPoint point = [sender locationInView:subView];
        if (CGRectContainsPoint(subView.bounds, point)) {
            return;
        }
    }
    T2TModelBackGroudView *viewBg = (T2TModelBackGroudView *)aView;
    if ([viewBg isKindOfClass:[T2TModelBackGroudView class]]) {
        if (viewBg.blockCloseHandle) {
            viewBg.blockCloseHandle();
        }
        if (viewBg.blockCloseAnimate) {
            if (viewBg.animateWithDuration<=0.0) {
                viewBg.animateWithDuration = 0.25;
            }
            [UIView animateWithDuration:viewBg.animateWithDuration animations:^{
                viewBg.blockCloseAnimate();
            } completion:^(BOOL finished) {
                [viewBg removeFromSuperview];
            }];
            return;
        }
    }
    [viewBg removeFromSuperview];
    
    //    if ([aView isKindOfClass:[TModelBackGroudView class]] && aView.blockCloseAnimate) {
    //        if (aView.animateWithDuration<=0.0) {
    //            aView.animateWithDuration = 0.25;
    //        }
    //        [UIView animateWithDuration:aView.animateWithDuration animations:^{
    //            aView.blockCloseAnimate();
    //        } completion:^(BOOL finished) {
    //            [aView removeFromSuperview];
    //        }];
    //    }else{
    //        [aView removeFromSuperview];
    //    }
    
    
}

+(void)showWithContentView:(UIView *)v_content fromRect:(CGRect)rt bgColor:(UIColor *)c_bg bgAlpha:(float)a_bg{
    [self showWithContentView:v_content fromRect:rt bgColor:c_bg bgAlpha:a_bg editBgViewHandle:nil];
}

+(void)showWithContentView:(UIView *)v_content fromRect:(CGRect)rt bgColor:(UIColor *)c_bg bgAlpha:(float)a_bg editBgViewHandle:(void (^)(T2TModelBackGroudView *))editHandle{
    T2TModelBackGroudView *v_bg = [[T2TModelBackGroudView alloc]initWithFrame:kIsIOS7?[[UIScreen mainScreen] bounds]:[[UIScreen mainScreen] applicationFrame]];
    v_bg.backgroundColor = [c_bg colorWithAlphaComponent:a_bg];
    if (editHandle) {
        editHandle(v_bg);
    }
    [kCurrentWindow addSubview:v_bg];
    
    v_content.frame = rt;
    [v_bg addSubview:v_content];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionForBGView:)];
    [v_bg addGestureRecognizer:tap];
}

+(void)btnCloseAtModelAction:(UIButton *)sender{
    [sender.superview.superview removeFromSuperview];
}


+(void)showWithContentView:(UIView *)v fromRect:(CGRect)rt{
    [self showWithContentView:v fromRect:rt bgColor:[UIColor blackColor] bgAlpha:0.5];
}

+(void)showWithContentView:(UIView *)v{
    [self showWithContentView:v fromRect:v.frame];
}

+(void)showWithContentView:(UIView *)v_content bgAlpha:(float)a_bg{
    [self showWithContentView:v_content fromRect:v_content.frame bgColor:[UIColor blackColor] bgAlpha:a_bg];
}


+(void)showInView:(UIView *)superView contentVIew:(UIView *)aView editBgViewHandle:(void (^)(T2TModelBackGroudView *))editHandle{
    [self closeModelViewFromView:superView];
    
    T2TModelBackGroudView *viewBg = [[T2TModelBackGroudView alloc]initWithFrame:CGRectMake(0, 0, superView.width, superView.height)];
    viewBg.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    viewBg.userInteractionEnabled = YES;
    [viewBg addSubview:aView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionForBGView:)];
    tap.cancelsTouchesInView = NO;
    [viewBg addGestureRecognizer:tap];
    
//    [viewBg.blurView addGestureRecognizer:tap];
    
    if (editHandle) {
        editHandle(viewBg);
    }
    
    [superView addSubview:viewBg];
}


#pragma mark - close


//关闭modelView，aView为内容视图或内容视图的子视图
+(void)closeModelViewWithContentView:(UIView *)aView{
    if (![aView isKindOfClass:[UIView class]]) {
        return;
    }
    UIView *viewModelRoot = aView.superview;
    while (![viewModelRoot isKindOfClass:[T2TModelBackGroudView class]]) {
        viewModelRoot = viewModelRoot.superview;
    }
    T2TModelBackGroudView *viewBg = (T2TModelBackGroudView *)viewModelRoot;
    if ([viewBg isKindOfClass:[T2TModelBackGroudView class]]) {
        if (viewBg.blockCloseHandle) {
            viewBg.blockCloseHandle();
        }
        if (viewBg.blockCloseAnimate) {
            if (viewBg.animateWithDuration<=0.0) {
                viewBg.animateWithDuration = 0.25;
            }
            [UIView animateWithDuration:viewBg.animateWithDuration animations:^{
                viewBg.blockCloseAnimate();
            } completion:^(BOOL finished) {
                [viewBg removeFromSuperview];
            }];
            return;
        }
    }
    
  
    [viewBg removeFromSuperview];
    
}


+(void)closeModelViewFromView:(UIView *)aView{
    if (![aView isKindOfClass:[UIView class]]) {
        return;
    }
    T2TModelBackGroudView *bgView = (T2TModelBackGroudView *)[aView subViewOfClass:[T2TModelBackGroudView class]];
    if (bgView) {
        [bgView removeFromSuperview];
    }
}

+(void)closeMoreModelViewFromView:(UIView *)aView{
    if (![aView isKindOfClass:[UIView class]]) {
        return;
    }
    NSMutableArray *arrViews = [NSMutableArray array];
    NSMutableArray *views = [aView.subviews mutableCopy];
    while ( views.count>0) {
        UIView *temp = [views firstObject];
        if ([temp isKindOfClass:[T2TModelBackGroudView class]]) {
            [arrViews addObject:temp];
            [views removeObject:temp];
        }else{
            [views addObjectsFromArray:temp.subviews];
            [views removeObject:temp];
        }
    }
    
    for (UIView *view in arrViews) {
        [view removeFromSuperview];
    }
}

+(void)close{
    [self closeModelViewFromView:kCurrentWindow];
}
@end
