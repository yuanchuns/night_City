//
//  T2TAlertView.m
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TAlertView.h"
static NSString *GCAlertViewWillPresentKey = @"GCAlertViewWillPresentAction";
static NSString *GCAlertViewDidPresentKey = @"GCAlertViewDidPresentAction";
static NSString *GCAlertViewWillDismissKey = @"GCAlertViewWillDismissAction";
static NSString *GCAlertViewDidDismissKey = @"GCAlertViewDidDismissAction";


@implementation T2TAlertView
{
    NSMutableDictionary *_arrActions;
}
- (id)initWithTitle:(NSString *)title message:(NSString *)message {
    __typeof (self) __weak weakSelf = self;
    self = [super initWithTitle:title message:message delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:nil];
    if (self) {
        _arrActions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    //    _actions = nil;
    //    [super dealloc];
}

- (void)addButtonWithTitle:(NSString *)title block:(T2TBasicBlock)block {
    if ([_arrActions objectForKey:title]) { return; }
    [self addButtonWithTitle:title];
    if (block) {
        T2TBasicBlock action = block;
        [_arrActions setObject:action forKey:title];
        //        Block_release(action);
    }
}

- (void)setWillPresentBlock:(T2TBasicBlock)block {
    if (block) {
        T2TBasicBlock action = block;
        [_arrActions setObject:action forKey:GCAlertViewWillPresentKey];
    }
    else {
        [_arrActions removeObjectForKey:GCAlertViewWillPresentKey];
    }
}

- (void)setDidPresentBlock:(T2TBasicBlock)block {
    if (block) {
        T2TBasicBlock action = block;
        [_arrActions setObject:action forKey:GCAlertViewDidPresentKey];
    }
    else {
        [_arrActions removeObjectForKey:GCAlertViewDidPresentKey];
    }
}

- (void)setWillDismissBlock:(T2TBasicBlock)block {
    if (block) {
        T2TBasicBlock action = block;
        [_arrActions setObject:action forKey:GCAlertViewWillDismissKey];
    }
    else {
        [_arrActions removeObjectForKey:GCAlertViewWillDismissKey];
    }
}

- (void)setDidDismissBlock:(T2TBasicBlock)block {
    if (block) {
        T2TBasicBlock action = block;
        [_arrActions setObject:action forKey:GCAlertViewDidDismissKey];
    }
    else {
        [_arrActions removeObjectForKey:GCAlertViewDidDismissKey];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex >= 0 && buttonIndex < alertView.numberOfButtons) {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        T2TBasicBlock action = [_arrActions objectForKey:title];
        if (action) { action(); }
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    T2TBasicBlock action = [_arrActions objectForKey:GCAlertViewWillPresentKey];
    if (action) { action(); }
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    T2TBasicBlock action = [_arrActions objectForKey:GCAlertViewDidPresentKey];
    if (action) { action(); }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    T2TBasicBlock action = [_arrActions objectForKey:GCAlertViewWillDismissKey];
    if (action) { action(); }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    T2TBasicBlock action = [_arrActions objectForKey:GCAlertViewDidDismissKey];
    if (action) { action(); }
}

@end
