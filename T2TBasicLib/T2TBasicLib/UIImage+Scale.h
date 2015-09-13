//
//  UIImage+Scale.h
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
// 图片处理

#import <UIKit/UIKit.h>

@interface UIImage (Scale)
//得到切图？
-(UIImage *)getSubImage:(CGRect)rect;
//等比例缩放
-(UIImage *)scaleToSize:(CGSize)size;
//非等比例缩放
-(UIImage *)unProportionScaleToSize:(CGSize)size;


-(UIImage *)scaleToFit;
//-(UIImage *)scaleToBBS;

-(UIImage *)scaleToFitSmiImage;
//生成头像默认大小为65像素的宽
-(UIImage *)HeadscaleToFitSmiImage;

//-(UIImage *)resizedInRect:(CGRect)thumbRect;
@end
