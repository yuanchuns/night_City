//
//  UIViewController+TCategory.m
//  T2TBasicLib
//
//  Created by mark on 14/12/24.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "UIViewController+TCategory.h"
#import "Define_basic.h"
@implementation UIViewController (TCategory)
-(void)coustmerPresentModalViewController:(UIViewController *)vc animated:(BOOL)animated{

    if (!vc) {
        return;
    }
    if (kIsIOS8) {
        [self presentViewController:vc animated:animated completion:nil];

    }else{
        
        [self presentModalViewController:vc animated:animated];
    }
    
    
}

- (UIImage *)capture
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, window.opaque, 0.0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    //    UIImageWriteToSavedPhotosAlbum(img, self, nil, nil);
    
    UIGraphicsEndImageContext();
    
    return img;
}


@end
