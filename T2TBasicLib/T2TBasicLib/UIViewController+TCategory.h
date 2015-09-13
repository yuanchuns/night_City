//
//  UIViewController+TCategory.h
//  T2TBasicLib
//
//  Created by mark on 14/12/24.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TCategory)
-(void)coustmerPresentModalViewController:(UIViewController *)vc animated:(BOOL)animated;
/**
 *  截取屏幕图像
 *
 *  @return 截取的界面头像
 */
- (UIImage *)capture;
@end
