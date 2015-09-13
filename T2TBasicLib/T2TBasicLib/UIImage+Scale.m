//
//  UIImage+Scale.m
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)
-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);
    
    return smallImage;
}

-(UIImage*)scaleToFit
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    float wid = self.size.width>550.0?550.0:self.size.width;
    float width_scale = wid;//480.0;
    float height_scale = self.size.height*(wid/self.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(width_scale, height_scale));
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width_scale, height_scale)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(UIImage*)scaleToBBS
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    float width_scale = 49*2;// self.size.width*(49.0/self.size.height);//40.0;
    float height_scale = self.size.height*(49.0*2/self.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(width_scale, height_scale));
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width_scale, height_scale)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


-(UIImage*)scaleToFitSmiImage
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    float width_scale = 75;
    float height_scale = self.size.height*(75/self.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(width_scale, height_scale));
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width_scale, height_scale)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


-(UIImage*)HeadscaleToFitSmiImage
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    float width_scale = 52;
    float height_scale = self.size.height*(52/self.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(width_scale, height_scale));
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width_scale, height_scale)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio < horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    
    //    NSLog(@"radio:%f",radio);
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(UIImage *)unProportionScaleToSize:(CGSize)size{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    
    
    float verticalScale = size.height*1.0/height;
    float horizontalScale = size.width*1.0/width;
    
    
    float scale = 1;
    
    if (width>height) {
        scale = verticalScale;
    }else{
        scale = horizontalScale;
    }
    
    width = width*scale;
    height = height*scale;
    
    
    
    UIImage *smallImgOfProportionScale = [self scaleToSize:CGSizeMake(width, height)];
    
    
    int xPos = (width-size.width)/2;
    int yPos = (height-size.height)/2;
    
    
    UIImage *smallImgOfUnProportionScale = [smallImgOfProportionScale getSubImage:(CGRect){xPos,yPos,size}];
    
    return smallImgOfUnProportionScale;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:(CGRect){xPos,yPos,size}];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(UIImage*)resizedInRect:(CGRect)thumbRect {
    // Creates a bitmap-based graphics context and makes it the current context.
    UIGraphicsBeginImageContext(thumbRect.size);
    [self drawInRect:thumbRect];
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
