//
//  T2TCustomActionSheet.h
//  T2TBasicLib
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T2TCustomActionSheet : UIView
-(void)showInView:(UIView *)aView;
-(void)hide;
-(void)dismissWithClickedButtonIndex:(NSUInteger)index animated:(BOOL)animate;
@end
