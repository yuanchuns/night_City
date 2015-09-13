//
//  MGLodingView.h
//  Genechain
//
//  Created by mark on 15/7/29.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  详情页的加载视图
 */
@class MGLodingView;
typedef void (^lodingViewBlock)(MGLodingView *lodingView);

typedef enum {
    lodingViewStateIsLoding = 1,//正在加载
    lodingViewStateIsFailed = 2//加载失败的显示
} lodingViewState;

@interface MGLodingView : UIView
@property(nonatomic,strong)UIImageView *imavLogo;//显示logo的imav
@property(nonatomic,strong)T2TLabel *lblInfo;//加载的信息
@property(nonatomic,strong)ECircleLoadingView *lodingView;//加载动画


/**
 *  调用显示视图
 *
 *  @param superView    承载加载视图的父视图
 *  @param Editblock    编辑加载视图的回调
 *  @param refreshblock 点击刷新后的回调
 */
+ (void)showLodingViewOn:(UIView *)superView withEditBlock:(lodingViewBlock)Editblock withRefreshBlock:(T2TBacsicBlock)refreshblock ;

/**
 *  改变加载的状态
 *
 *  @param state 加载状态
 *  @param view  承载加载视图的父视图
 */
+ (void)changeLodingViewWithType:(lodingViewState)state withSuperView:(UIView *)view;

/**
 *  移除加载的视图
 *
 *  @param view 移除视图的父视图
 */
+ (void)removeFromSuperView:(UIView *)view;
@end
