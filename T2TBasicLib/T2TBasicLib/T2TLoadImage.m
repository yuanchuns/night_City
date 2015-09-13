//
//  T2TLoadImage.m
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TLoadImage.h"
#import "NSString+TDigest.h"
@implementation T2TLoadImage
+(void)loadAndCachImgForImgv:(UIImageView *)imgv WithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)finishBlock baseView:(UIView *)bv cachDirectory:(CDirectory)direc placeHolderImage:(UIImage *)img_holder{
    
    imgv.image = img_holder;
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
    NSInteger tag_ori = bv.tag;
    if (![[NSFileManager defaultManager]fileExistsAtPath:filepath]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlStr]];
            if(data){
                [data writeToFile:filepath atomically:YES];
                UIImage *img = [[UIImage alloc]initWithData:data];
                if(imgv && tag_ori==bv.tag)dispatch_async(dispatch_get_main_queue(), ^{
                    imgv.image = img;
                });
                
                img = nil;
            }else{
                if(imgv && tag_ori==bv.tag)dispatch_async(dispatch_get_main_queue(), ^{
                    imgv.image = img_holder;
                });
            }
            data = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                if(finishBlock) finishBlock();
            });
        });
        
    }else{
        NSData *data = [[NSData alloc]initWithContentsOfFile:filepath];
        if(imgv && tag_ori==bv.tag)imgv.image = [UIImage imageWithData:data];
        data=nil;
        if(!imgv.image) imgv.image = img_holder;
        if(finishBlock)dispatch_async(dispatch_get_main_queue(), finishBlock);
        
    }
}


+(void)loadAndCachImgAtDocumentForImgv:(UIImageView *)imgv WithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)finishBlock baseView:(UIView *)bv{
    
    
    [imgv loadAndCachImgAtDocumentWithUrlStr:urlStr finishblock:finishBlock];
    
    //    [self loadAndCachImgForImgv:imgv WithUrlStr:urlStr finishblock:finishBlock baseView:bv cachDirectory:CDirectory_doc placeHolderImage:nil];
}




+(void)loadAndCachImgForImgv:(UIImageView *)imgv WithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)finishBlock baseView:(UIView *)bv{
    
    [imgv loadImageWithUrlStr:urlStr placeHolderImage:nil finishedBlock:finishBlock];
    
    //    [self loadAndCachImgForImgv:imgv WithUrlStr:urlStr finishblock:finishBlock baseView:bv cachDirectory:CDirectory_cach placeHolderImage:nil];
}


+(void)loadImageForImgv:(UIImageView *)aimgv withUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder{
    
    [aimgv sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:img_holder];
//    [aimgv loadImageWithUrlStr:urlStr placeHolderImage:img_holder finishedBlock:nil];
    
    //    if(!urlStr){
    //        aimgv.image = img_holder;
    //        return;
    //    }
    //    [self loadAndCachImgForImgv:aimgv WithUrlStr:urlStr finishblock:nil baseView:aimgv cachDirectory:CDirectory_cach placeHolderImage:img_holder];
}



+(void)loadImageForImgv:(UIImageView *)aimgv withUrlStr:(NSString *)urlStr finishedBlock:(T2TBasicBlock)block{
    
    [aimgv loadImageWithUrlStr:urlStr placeHolderImage:nil finishedBlock:block];
    //    [self loadAndCachImgForImgv:aimgv WithUrlStr:urlStr finishblock:block baseView:aimgv cachDirectory:CDirectory_cach placeHolderImage:nil];
}

//根据链接获取图片并将图片加载在传进来的aimgv
+(void)loadImageForImgv:(UIImageView *)aimgv withUrlStr:(NSString *)urlStr{
    
    
    [aimgv loadImageWithUrlStr:urlStr];
    
    //    [self loadImageForImgv:aimgv withUrlStr:urlStr finishedBlock:^{
    //
    //    }];
    
}


+(void)loadImageForImgv:(UIImageView *)aimgv withUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder baseView:(UIView *)bv{
    
    
    [aimgv loadImageWithUrlStr:urlStr placeHolderImage:img_holder finishedBlock:nil];
    
    //    [self loadAndCachImgForImgv:aimgv WithUrlStr:urlStr finishblock:nil baseView:bv cachDirectory:CDirectory_cach placeHolderImage:img_holder];
}

+(void)loadImageForImgv:(UIImageView *)imgv withUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder finishedBlock:(T2TBasicBlock)finishBlock{
    [imgv loadImageWithUrlStr:urlStr placeHolderImage:img_holder finishedBlock:finishBlock];
    //    [self loadAndCachImgForImgv:imgv WithUrlStr:urlStr finishblock:finishBlock baseView:imgv cachDirectory:CDirectory_cach placeHolderImage:img_holder];
    
}

+(UIImage *)getImgWithUrlStr:(NSString *)urlStr cachDirectory:(CDirectory)direc{
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
        NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlStr]];
        if(data){
            [data writeToFile:filepath atomically:YES];
            img = [[UIImage alloc]initWithData:data];
        }
        data = nil;
        
    }else{
        NSData *data = [[NSData alloc]initWithContentsOfFile:filepath];
        img = [[UIImage alloc]initWithData:data];
        data=nil;
        
    }
    return img;
}

+(UIImage *)getImgFromCachWithUrl:(NSString *)url{
    
    return [self getImgWithUrlStr:url cachDirectory:CDirectory_cach];
    
    NSString *filename = kFileNameWithUrlStr(url);
    NSString *filepath = kFilePathAtCachWithName(filename);
    
    NSData *data = [[NSData alloc]initWithContentsOfFile:filepath];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
@end
