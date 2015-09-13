//
//  UIImageView+TCategory.m
//  TBasicLib
//
//  Created by kevin.huang on 14-6-26.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import "UIImageView+TCategory.h"
#import <objc/runtime.h>
#import "NSString+TDigest.h"
//@interface UIImageView ()
//
//@property (nonatomic,strong) NSString *strUrl;
//
//@end

@implementation UIImageView (TCategory)
//@dynamic strBigImaUrl ;
static CGRect oldframe;
static void * strBig = (void *)@"strBig";
static void * imaBigPlaceKey = (void *)@"imaBigPlace";
bool touchState;
//static  UIImageView *imageView;
//UIWindow *window;
#pragma mark -

-(NSString *)strUrl{
    if ([self respondsToSelector:@selector(accessibilityIdentifier)]) {
        return self.accessibilityIdentifier;
    }else{
        return nil;
    }
}

-(void)setStrUrl:(NSString *)strUrl{
    if ([self respondsToSelector:@selector(accessibilityIdentifier)]) {
        self.accessibilityIdentifier = strUrl;
    }
}

-(NSString *)strBigImaUrl{
 return objc_getAssociatedObject(self, strBig);
}

-(void)setStrBigImaUrl:(NSString *)strBigImaUrl{
 objc_setAssociatedObject(self, strBig, strBigImaUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setImaBigPlace:(UIImage *)imaBigPlace{
objc_setAssociatedObject(self, imaBigPlaceKey, imaBigPlace, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImage *)imaBigPlace{
return objc_getAssociatedObject(self, imaBigPlaceKey);
}

-(void)loadBigImageWithBigUrlStr:(NSString *)strBigImaUrl placeHolderImage:(UIImage *)placeIma{
    self.strBigImaUrl = strBigImaUrl;
    self.imaBigPlace = placeIma;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookBigEvent:)];
    [self addGestureRecognizer:tap];
    
    

}

-(void)lookBigEvent:(UITapGestureRecognizer *)sender{

    if (touchState) {
        return;
    }
    touchState = YES;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    oldframe=[self convertRect:self.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];

    UIImageView *imageView =[[UIImageView alloc]initWithFrame:oldframe];
    imageView.tag = 1;
    //imageView.image = [UIImage imageNamed:@"guide_ChineseStyle"];
    imageView.image = self.imaBigPlace;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [imageView loadImageWithUrlStr:self.strBigImaUrl placeHolderImage:self.imaBigPlace finishedBlock:^{
        [UIView animateWithDuration:0.3 animations:^{
            imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-self.image.size.height*[UIScreen mainScreen].bounds.size.width/self.image.size.width)/2, [UIScreen mainScreen].bounds.size.width, self.image.size.height*[UIScreen mainScreen].bounds.size.width/self.image.size.width);
            
            backgroundView.alpha=1;
        } completion:^(BOOL finished) {
        }];
        
    }];
    
 
    
}

-(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
       // [backgroundView removeFromSuperview];
        [backgroundView removeFromSuperview];
        touchState = NO;
       
    }];
}

#pragma mark - 加载

-(void)loadAndCachImgwithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)finishBlock cachDirectory:(CDirectory)direc placeHolderImage:(UIImage *)img_holder{
    self.clipsToBounds = YES;
    @autoreleasepool {
        self.accessibilityHint = urlStr;
        self.strUrl = urlStr;
        UIViewContentMode mode = 0;
        if (img_holder) {
            self.contentMode = mode;
        }
        self.image = img_holder;
        
        //如果传进来的urlStr是完整的路径名则直接显示
        if ([[NSFileManager defaultManager] fileExistsAtPath:urlStr]) {
            self.contentMode = mode;
            self.image = [UIImage imageWithContentsOfFile:urlStr];
            return;
        }
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
        
        NSString *oriStrUrl = urlStr;
        if (![[NSFileManager defaultManager]fileExistsAtPath:filepath]) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlStr]];
                if(data){
                    @autoreleasepool {
                        [data writeToFile:filepath atomically:YES];
                    }
                    UIImage *img = [[UIImage alloc]initWithData:data];
                    if(!self.strUrl || [oriStrUrl isEqualToString:self.strUrl])dispatch_async(dispatch_get_main_queue(), ^{
                        self.contentMode = mode;
                        self.image = img;
                    });
                    
                    img = nil;
                }else{
                    if(!self.strUrl || [oriStrUrl isEqualToString:self.strUrl])dispatch_async(dispatch_get_main_queue(), ^{
                        self.contentMode = mode;
                        self.image = img_holder;
                    });
                }
                data = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(finishBlock) finishBlock();
                });
            });
            
            
        }else{
            
            
            
            NSData *data = [[NSData alloc]initWithContentsOfFile:filepath];
            if(!self.strUrl || [oriStrUrl isEqualToString:self.strUrl]){
                self.contentMode = mode;
                self.image = [UIImage imageWithData:data];
            }
            
            data=nil;
            if(!self.image){
//                self.contentMode = UIViewContentModeCenter;
                self.contentMode = mode;
                self.image = img_holder;
            }
            
            if(finishBlock)dispatch_async(dispatch_get_main_queue(), finishBlock);
            
            
            
        }
    }
    
}

-(void)loadImageWithUrlStr:(NSString *)urlStr{
    [self loadAndCachImgwithUrlStr:urlStr finishblock:nil cachDirectory:CDirectory_cach placeHolderImage:nil];
}
-(void)loadImageWithUrlStr:(NSString *)urlStr finishedBlock:(T2TBasicBlock)ablock{
    [self loadAndCachImgwithUrlStr:urlStr finishblock:ablock cachDirectory:CDirectory_cach placeHolderImage:nil];
}

-(void)loadImageWithUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder{
    [self loadAndCachImgwithUrlStr:urlStr finishblock:nil cachDirectory:CDirectory_cach placeHolderImage:img_holder];
}
-(void)loadImageWithUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder finishedBlock:(T2TBasicBlock)ablock{
    [self loadAndCachImgwithUrlStr:urlStr finishblock:ablock cachDirectory:CDirectory_cach placeHolderImage:img_holder];
}

-(void)loadAndCachImgAtDocumentWithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)ablock{
    [self loadAndCachImgwithUrlStr:urlStr finishblock:ablock cachDirectory:CDirectory_doc placeHolderImage:nil];
}

-(void)loadAndCachImgAtDocumentWithUrlStr:(NSString *)urlStr finishblock:(T2TBasicBlock)ablock placeHolderImage:(UIImage *)img_holder{
    [self loadAndCachImgwithUrlStr:urlStr finishblock:ablock cachDirectory:CDirectory_doc placeHolderImage:img_holder];
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
