//
//  UIImage+TCategory.h
//  TBasicLib
//
//  Created by mark on 14-12-12.
//  Copyright (c) 2014年 233. All rights reserved.
//  几种常用的获取图片方法

#import <UIKit/UIKit.h>

typedef enum {
    CDirectory_cach = 0,
    CDirectory_doc = 1,
}CDirectory;

@interface UIImage (TCategory)

//根据imageName获取mainBundle的图片
+(UIImage *)imgAtBundleWithName:(NSString *)imageName;
//根据imageName获取名为strBundleName的Bundle里的图片
+(UIImage *)imgAtBundleName:(NSString *)strBundleName fileName:(NSString *)imageName;
//根据imageName获取名为kTBasicLibResourceBundleName的Bundle里的图片
+(UIImage *)imgAtBasicLibBundleWithName:(NSString *)imageName; 

//根据url获取图片 有缓存则直接返回，获取完成要进行缓存 缓存在cach目录
+(UIImage *)imgFromCachWithUrl:(NSString *)url;

+(UIImage *)imgFromCachWithUrl:(NSString *)url isSych:(BOOL)isSynch;
//根据url获取图片 有缓存则直接返回，获取完成要进行缓存 direc为缓存目录
+(UIImage *)imgWithUrlStr:(NSString *)urlStr cachDirectory:(CDirectory)direc;

+(UIImage *)imgWithUrlStr:(NSString *)urlStr cachDirectory:(CDirectory)direc isSych:(BOOL)isSynch;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
