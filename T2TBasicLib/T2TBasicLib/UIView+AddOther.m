//
//  UIView+AddOther.m
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "UIView+AddOther.h"

@implementation UIView (AddOther)


+(id)loadNibNamed:(NSString *)nibName owner:(id)owener options:(NSDictionary *)options{
    NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:nibName owner:owener options:options];
    if (arrNib.count>0) {
        return [arrNib lastObject];
    }
    return nil;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.size.width = MAX(right-self.left, 0);
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.size.height = MAX(bottom-self.top, 0);
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}



- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)logSubViewsWithView:(UIView *)aView{
    NSArray *ay = aView.subviews;
    NSLog(@"%@ subviews:%@",[aView description],ay.description);
    for (UIView *subView in ay) {
        [self logSubViewsWithView:subView];
    }
    
}



-(void)logSubViews{
    NSArray *ay = self.subviews;
    NSLog(@"%@ subviews:%@",[self description],ay.description);
    for (UIView *subView in ay) {
        [self logSubViewsWithView:subView];
    }
    
}


- (BOOL)removeSubViewWithTag:(NSUInteger)tag{


    BOOL state = NO;
    for (UIView *view in self.subviews) {
        if (view.tag == tag && tag != 0) {
            [view removeFromSuperview];
            state = YES;
            break;
        }
    }
    return state;
    
    
    return state;
    
}

-(BOOL)removeSubViewWithClass:(Class)aClass{

    BOOL state = NO;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:aClass]) {
            [view removeFromSuperview];
            state = YES;
            break;
        }
    }
    return state;
}

-(UIView *)subViewOfClass:(Class)aClass{
    
    UIView *aView = nil;
    NSMutableArray *views = [self.subviews mutableCopy];
    while (!aView && views.count>0) {
        UIView *temp = [views firstObject];
        if ([temp isKindOfClass:aClass]) {
            aView = temp;
        }else{
            [views addObjectsFromArray:temp.subviews];
            [views removeObject:temp];
        }
    }
    
    return aView;
    
}

-(UIView *)subViewOfContainDescription:(NSString *)aString{
    if(![aString isKindOfClass:[NSString class]]){
        NSLog(@"%@",[NSString stringWithFormat:@"[view subViewOfContainDescription:%@] %@ not a string",aString,aString]);
        return nil;
    }
    UIView *aView = nil;
    NSMutableArray *views = [self.subviews mutableCopy];
    while (!aView && views.count>0) {
        UIView *temp = [views firstObject];
        if ([temp.description rangeOfString:aString].length>0) {
            aView = temp;
        }else{
            [views addObjectsFromArray:temp.subviews];
            [views removeObject:temp];
        }
    }
    
    return aView;
    
}
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0.0f, y = 0.0f;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}

- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

@end
