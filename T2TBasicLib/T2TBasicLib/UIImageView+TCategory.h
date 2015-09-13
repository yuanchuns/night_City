//
//  UIImageView+TCategory.h
//  TBasicLib
//
//  Created by kevin.huang on 14-6-26.
//  Copyright (c) 2014年 binxun. All rights reserved.
//  封装常用加载图片方式

#import <UIKit/UIKit.h>
#import "Define_block.h"
#import "Define_basic.h"
@interface UIImageView (TCategory)

@property (nonatomic,strong) NSString *strUrl;
@property (nonatomic,strong) NSString *strBigImaUrl;
@property (nonatomic,strong) UIImage *imaBigPlace;
/*
 以下加载网络图片方法统一说明：
 根据链接获取图片 缓存到本地，默认为cach目录，有缓存直接显示无需请求网络
 参数：
 urlStr  图片地址
 ablock 加载完成后调用的模块
 img_holder 图片未加载完成显示的默认图片
 */
//点击加载大图
-(void)loadBigImageWithBigUrlStr:(NSString *)strBigImaUrl placeHolderImage:(UIImage *)placeIma;
-(void)loadImageWithUrlStr:(NSString *)urlStr;
-(void)loadImageWithUrlStr:(NSString *)urlStr finishedBlock:(T2TBasicBlock)ablock;
-(void)loadImageWithUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder;
-(void)loadImageWithUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder finishedBlock:(T2TBasicBlock)ablock;
//以下缓存到Document目录
-(void)loadAndCachImgAtDocumentWithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)ablock;
-(void)loadAndCachImgAtDocumentWithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)ablock placeHolderImage:(UIImage *)img_holder;

@end
