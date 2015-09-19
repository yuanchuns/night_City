//
//  EPPullCollectionVC.h
//  T2TBasicLib
//
//  Created by nextone on 15/9/19.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface EPPullCollectionVC :UICollectionViewController

@property(nonatomic,strong)NSMutableArray *arrData;//数据源
@property(nonatomic,assign)NSInteger curIndex;//当前页
@property(nonatomic,assign)NSInteger allIndex;//总页数
@property(nonatomic,assign)NSInteger allCount;//总条数
@property(nonatomic,assign)BOOL isHaveHeadView;//有下拉刷新 默认是没有的(需要在loadView方法中设置)
@property(nonatomic,assign)BOOL isHaveFootView;//是否有上拉加载 默认是有的（需要在loadView方法中设置）
@property(nonatomic,assign)BOOL isNotMore;//是否已经加载完毕所有的数组
@property(nonatomic,strong)RefreshControl *control;

//开始上拉加载更多
-(void)startScrPullUpLoadMore;
//开始下拉刷新
-(void)startScrPullDownRefresh;


/**
 *  外部手动启动下拉加载的方法，例如 第一次进来 tableview自动下拉刷新
 */
- (void)startPullDownRefreshing;

/**
 *  停止下拉刷新的方法
 */
- (void)endPullDownRefreshing;


/**
 *  停止上拉加载更多的方法
 */
- (void)endPullUpLoading;


@end
