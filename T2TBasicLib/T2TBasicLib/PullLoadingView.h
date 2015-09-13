//
//  PullLoadingView.h
//  T2TBasicLib
//
//  Created by mark on 15/1/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECircleLoadingView.h"

typedef enum {
    kPRStateNormal = 0,
    kPRStatePulling = 1,
    kPRStateLoading = 2,
    kPRStateHitTheEnd = 3
} PRState;

@interface PullLoadingView : UIView {
    UILabel *_stateLabel;
    UILabel *_dateLabel;
    ECircleLoadingView *_lodingView;
    BOOL _loading;
}
@property (nonatomic,getter = isLoading) BOOL loading;
@property (nonatomic,getter = isAtTop) BOOL atTop;
@property (nonatomic) PRState state;

- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top;

- (void)updateRefreshDate:(NSDate *)date;

@end

