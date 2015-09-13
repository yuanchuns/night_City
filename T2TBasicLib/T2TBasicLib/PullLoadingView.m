//
//  PullLoadingView.m
//  T2TBasicLib
//
//  Created by mark on 15/1/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "PullLoadingView.h"
#import "UIColor+HexString.h"
#import "Define_basic.h"
#define kPROffsetY 60.f
#define kPRMargin 5.f
#define kPRLabelHeight 20.f
#define kPRLabelWidth 100.f
#define kPRArrowWidth 38.f
#define kPRArrowHeight 38.f

#define kTextStateColor  RGB_255(87, 104, 120)
#define kTextInfoColor [UIColor colorWithHexString:@"#b1b1b1"]
#define kPRBGColor [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:0.0]


@interface PullLoadingView ()
- (void)updateRefreshDate :(NSDate *)date;
- (void)layouts;
@end

@implementation PullLoadingView
@synthesize atTop = _atTop;
@synthesize state = _state;
@synthesize loading = _loading;

//Default is at top
- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top {
    self = [super initWithFrame:frame];
    if (self) {
        self.atTop = top;
       
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = kPRBGColor;
        self.backgroundColor = [UIColor clearColor];
        
        UIFont *ft = [UIFont systemFontOfSize:14.f];
        _stateLabel = [[UILabel alloc] init ];
        _stateLabel.font = ft;
        _stateLabel.textColor = kTextStateColor;
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.backgroundColor = kPRBGColor;
        _stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _stateLabel.text = NSLocalizedString(@"下拉刷新", @"");
        [self addSubview:_stateLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = kTextInfoColor;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.backgroundColor = kPRBGColor;
        _dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _dateLabel.text = NSLocalizedString(@"最后更新", @"");
        [self addSubview:_dateLabel];
        
        _lodingView = [[ECircleLoadingView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [self addSubview:_lodingView];
        [self layouts];
        
    }
    return self;
}

- (void)layouts {
    
    CGSize size = self.frame.size;
    CGRect stateFrame,dateFrame,loadingFrame;
    
    float x = 0,y,margin;
    margin = (kPROffsetY - 2*kPRLabelHeight)/2;
    if (self.isAtTop) {
        y = size.height - margin - kPRLabelHeight;
        dateFrame = CGRectMake(0,y,size.width,kPRLabelHeight);
        
        y = y - kPRLabelHeight;
        stateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        
        x = kPRMargin;
        y = size.height - margin - kPRArrowHeight;
        loadingFrame = CGRectMake(kScreenWidth/2-100, y, 20, 20);
        
    } else {    //at bottom
        y = margin;
        stateFrame = CGRectMake(0, y, size.width, kPRLabelHeight );
        
        y = y + kPRLabelHeight;
        dateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        
        x = kPRMargin;
        y = margin;
        loadingFrame = CGRectMake(kScreenWidth/2-100, y, 20, 20);
        _stateLabel.text = NSLocalizedString(@"上拉加载", @"");
    }
    
    _stateLabel.frame = stateFrame;
    _dateLabel.frame = dateFrame;
    _lodingView.frame = loadingFrame;

}

- (void)setState:(PRState)state {
    [self setState:state animated:YES];
}


- (void)setState:(PRState)state animated:(BOOL)animated{
    if (_state != state) {
        _state = state;
        if (_state == kPRStateLoading) {    //Loading
            _loading = YES;
            [_lodingView startAnimation];
            if (self.isAtTop) {
                _stateLabel.text = NSLocalizedString(@"正在载入...", @"");
            } else {
                _stateLabel.text = NSLocalizedString(@"正在加载", @"");
            }
            
        } else if (_state == kPRStatePulling && !_loading) {    //
             _lodingView.hidden = NO;
            [_lodingView stopAnimation];
            if (self.isAtTop) {
                _stateLabel.text = NSLocalizedString(@"释放立即刷新", @"");
            } else {
                _stateLabel.text = NSLocalizedString(@"释放加载更多", @"");
            }
            
        } else if (_state == kPRStateNormal && !_loading){    //Reset
            _lodingView.hidden = NO;
            [_lodingView performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.2];
            if (self.isAtTop) {
                _stateLabel.text = @"下拉刷新";
            } else {
                _stateLabel.text = @"上拉加载更多";
            }
        } else if (_state == kPRStateHitTheEnd) {
           
            _lodingView.hidden = YES;
            if (!self.isAtTop) {    //footer
                _stateLabel.text = @"没有更多了哟";
            }
        }
    }
}


- (void)updateRefreshDate :(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [df stringFromDate:date];
    NSString *title = NSLocalizedString(@"今天", nil);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:date toDate:[NSDate date] options:0];
    int year = [components year];
    int month = [components month];
    int day = [components day];
    if (year == 0 && month == 0 && day < 3) {
        if (day == 0) {
            title = NSLocalizedString(@"今天",nil);
        } else if (day == 1) {
            title = NSLocalizedString(@"昨天",nil);
        } else if (day == 2) {
            title = NSLocalizedString(@"前天",nil);
        }
        df.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",title];
        dateString = [df stringFromDate:date];
    }
    _dateLabel.text = [NSString stringWithFormat:@"%@: %@",
                       NSLocalizedString(@"最后更新", @""),
                       dateString];
    [df release];
}

@end

