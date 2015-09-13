//
//  T2TLoadImage.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIImageView+TCategory.h"

@interface T2TLoadImage : NSObject
/**
 *  根据url加载图片，cach里有缓存则直接显示缓存图片，无则获取网络图片并缓存到cach目录（一般用于表格中）
 *
 *  @param imgv        操作的Imav
 *  @param urlStr      图片的url
 *  @param finishBlock 完成后的block
 *  @param bv          根据bv的tag判断是否显示，tag没变化则显示，有变化不显示
 */
+(void)loadAndCachImgForImgv:(UIImageView *)imgv WithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)finishBlock baseView:(UIView *)bv;


/**
 *  根据url加载图片，Document里有缓存则直接显示缓存图片，无则获取网络图片并缓存到Document目录
 *
 *  @param imgv        操作的imav
 *  @param urlStr      图片的url
 *  @param finishBlock 完成后的block
 *  @param bv          根据bv的tag判断是否显示，tag没变化则显示，有变化不显示
 */
+(void)loadAndCachImgAtDocumentForImgv:(UIImageView *)imgv WithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)finishBlock baseView:(UIView *)bv;


/**
 *  根据链接获取图片并将图片加载在传进来的aimgv 缓存到cach目录，有缓存直接显示无需请求网络
 *
 *  @param aimgv  操作的imav
 *  @param urlStr 图片url
 */
+(void)loadImageForImgv:(UIImageView *)aimgv withUrlStr:(NSString *)urlStr;


/**
 *根据链接获取图片并将图片加载在传进来的aimgv 缓存到cach目录，有缓存直接显示无需请求网络
 *
 *  @param aimgv  操作的imav
 *  @param urlStr 图片的url
 *  @param block  完成后回调的block
 */
+(void)loadImageForImgv:(UIImageView *)aimgv withUrlStr:(NSString *)urlStr finishedBlock:(T2TBasicBlock)block;


/**
 *  根据链接获取图片并将图片加载在传进来的aimgv 缓存到cach目录，有缓存直接显示无需请求网络
 *
 *  @param aimgv      操作的imav
 *  @param urlStr     图片的url
 *  @param img_holder 默认的图片
 */
+(void)loadImageForImgv:(UIImageView *)aimgv withUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder;

//同上 finishBlock进行加载完成的操作
/**
 *  根据链接获取图片并将图片加载在传进来的aimgv 缓存到cach目录，有缓存直接显示无需请求网络
 *
 *  @param imgv        操作的imav
 *  @param urlStr      图片url
 *  @param img_holder  默认图片
 *  @param finishBlock 完成后的block
 */
+(void)loadImageForImgv:(UIImageView *)imgv withUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder finishedBlock:(T2TBasicBlock)finishBlock;

/**
 *  根据链接获取图片并将图片加载在传进来的aimgv 缓存到cach目录，有缓存直接显示无需请求网络 根据bv的tag判断是否显示，tag没变化则显示，有变化不显示 （主要应用在列表里）
 *
 *  @param aimgv      操作的imav
 *  @param urlStr     图片的url
 *  @param img_holder 默认图片
 *  @param bv         bv
 */
+(void)loadImageForImgv:(UIImageView *)aimgv withUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder baseView:(UIView *)bv;

/**
 *  根据url获取图片 有缓存则直接返回，获取完成要进行缓存 direc为缓存目录
 *
 *  @param urlStr 图片的url
 *  @param direc  缓存的目录
 *
 *  @return 返回ima
 */
+(UIImage *)getImgWithUrlStr:(NSString *)urlStr cachDirectory:(CDirectory)direc;
/**
 *  根据url获取图片 有缓存则直接返回，获取完成要进行缓存 缓存在cach目录
 *
 *  @param url 图片的url
 *
 *  @return 请求的图片
 */
+(UIImage *)getImgFromCachWithUrl:(NSString *)url;
@end
