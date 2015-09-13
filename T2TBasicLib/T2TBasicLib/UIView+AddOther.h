//
//  UIView+AddOther.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddOther)
@property(nonatomic, assign) CGFloat left;//左边
@property(nonatomic, assign) CGFloat top;//上面
@property(nonatomic, assign, readonly) CGFloat right;//右边
@property(nonatomic, assign) CGFloat bottom;//底下
@property(nonatomic, assign) CGFloat width;//宽度
@property(nonatomic, assign) CGFloat height;//高度


#pragma mark -

//输出aView的全部子视图 包括子视图的子视图
-(void)logSubViewsWithView:(UIView *)aView;
//输出self的全部子视图 包括子视图的子视图
-(void)logSubViews;
//获取第一个class=aClass的视图
-(UIView *)subViewOfClass:(Class)aClass;
//获取第一个description包含aString的视图
-(UIView *)subViewOfContainDescription:(NSString *)aString;
- (UIViewController*)viewController;
- (CGPoint)offsetFromView:(UIView*)otherView;
- (void)removeAllSubviews;
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

- (BOOL)removeSubViewWithTag:(NSUInteger)tag;

- (UIView*)descendantOrSelfWithClass:(Class)cls;
/**
 *  移除指定类的第一个view
 *
 *  @param aClass 指定类的类名
 *
 *  @return 是否已经移除成功
 */
-(BOOL)removeSubViewWithClass:(Class)aClass;
+(id)loadNibNamed:(NSString *)nibName owner:(id)owener options:(NSDictionary *)options;

@end
