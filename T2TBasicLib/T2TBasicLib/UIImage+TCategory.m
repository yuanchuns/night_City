//
//  UIImage+TCategory.m
//  TBasicLib
//
//  Created by mark.zhang on 14-12-12.
//  Copyright (c) 2014年 233. All rights reserved.
//

#import "UIImage+TCategory.h"
#import "Define_basic.h"
#import "T2TCommonAction.h"
#import <Accelerate/Accelerate.h>
@implementation UIImage (TCategory)


+(NSString *)fullImgNameWithName:(NSString *)imageName{
    if (![imageName isKindOfClass:[NSString class]] || imageName.length<1) {
        return @"";
    }
    if ([imageName rangeOfString:@"."].length>0) {
        return imageName;
    }
    if (kIsPad) {
        if ([[UIScreen mainScreen]respondsToSelector:@selector(scale)] && [[UIScreen mainScreen]scale] == 2) {
            return [NSString stringWithFormat:@"%@@2x.png",imageName];
        }else{
            return [NSString stringWithFormat:@"%@.png",imageName];
        }
    }else{
        return [NSString stringWithFormat:@"%@@2x.png",imageName];
    }
    
}

+(UIImage *)imgAtBundleWithName:(NSString *)imageName{
    if (![imageName isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSString *imgPath = [[NSBundle mainBundle]pathForResource:[self fullImgNameWithName:imageName] ofType:@""];
    UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
//    if (!img && imageName.length>0) {
//        [TLog logErrorInfo:[NSString stringWithFormat:@"no img for imageName:%@ imgPath:%@",imageName,imgPath]];
//    }
    return img;
}

+(UIImage *)imgAtBundleName:(NSString *)strBundleName fileName:(NSString *)imageName{
    if (![imageName isKindOfClass:[NSString class]] || imageName.length<1) {
        return nil;
    }
    NSString *imgPath = [T2TCommonAction pathForResourceWithBundleName:strBundleName fileName:[self fullImgNameWithName:imageName]];// [bundle pathForResource:[NSString stringWithFormat:@"%@@2x",imageName] ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
    if (!img && imageName.length>0) {
        [TLog logErrorInfo:[NSString stringWithFormat:@"no img for imageName:%@ imgPath:%@",imageName,imgPath]];
    }
    return img;
}

+(UIImage *)imgAtBasicLibBundleWithName:(NSString *)imageName{
    return [self imgAtBundleName:kTBasicLibResourceBundleName fileName:imageName];
}

+(UIImage *)imgWithUrlStr:(NSString *)urlStr cachDirectory:(CDirectory)direc{
    return [self imgWithUrlStr:urlStr cachDirectory:direc isSych:NO];
}

+(UIImage *)imgWithUrlStr:(NSString *)urlStr cachDirectory:(CDirectory)direc isSych:(BOOL)isSynch{
    NSString *filename = kFileNameWithUrlStr(urlStr);
    NSString *filepath = nil;
    switch (direc) {
        case CDirectory_doc:
            filepath = kFilePathAtDocumentWithName(filename);
            break;
        default:
            filepath = kFilePathAtCachWithName(filename);
            break;
    }
    UIImage *img = nil;
    if (![[NSFileManager defaultManager]fileExistsAtPath:filepath]) {
        if (isSynch) {
            NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlStr]];
            if(data){
                [data writeToFile:filepath atomically:YES];
                img = [[UIImage alloc]initWithData:data];
            }
            data = nil;
        }else{
            return nil;
        }
        
        
    }else{
        NSData *data = [[NSData alloc]initWithContentsOfFile:filepath];
        img = [[UIImage alloc]initWithData:data];
        data=nil;
        
    }
    return img;
}



+(UIImage *)imgFromCachWithUrl:(NSString *)url isSych:(BOOL)isSynch{
    return [self imgWithUrlStr:url cachDirectory:CDirectory_cach isSych:isSynch];
}

+(UIImage *)imgFromCachWithUrl:(NSString *)url{
    
    return [self imgWithUrlStr:url cachDirectory:CDirectory_cach isSych:NO];
    
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
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
//

@end
