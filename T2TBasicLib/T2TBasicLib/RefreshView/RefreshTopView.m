//
//  RefreshTopView.m
//
//  Copyright (c) 2014 YDJ ( https://github.com/ydj/RefreshControl )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.



#import "RefreshTopView.h"
#import "Define_basic.h"

#import "UIColor+HexString.h"

#define kTextColor [UIColor colorWithHexString:@"#808080"]
//[UIColor colorWithHexString:@"#556a78"]
#define kTextFont [UIFont fontWithName:@"STHeitiSC-Light" size:12]
@implementation RefreshTopView


- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self initViews];
    }
    
    return self;
}

//- (void)resetLayoutSubViews
//{
//    
//    NSArray * temp=self.constraints;
//    if ([temp count]>0)
//    {
//        [self removeConstraints:temp];
//    }
//    
//    NSLayoutConstraint * aBottom=[NSLayoutConstraint constraintWithItem:self.activityIndicatorView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
//    NSLayoutConstraint * aRight=[NSLayoutConstraint constraintWithItem:self.activityIndicatorView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:-5];
//    NSLayoutConstraint * aWith=[NSLayoutConstraint constraintWithItem:self.activityIndicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:35];
//    NSLayoutConstraint * aHeight=[NSLayoutConstraint constraintWithItem:self.activityIndicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:35];
//    
//    NSArray * aList=@[aBottom,aRight,aWith,aHeight];
//    
//    [self addConstraints:aList];
//    ////////////
//    
//    NSLayoutConstraint *vBottom=[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-13];
//    NSLayoutConstraint *vRight=[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:-8];
//    NSLayoutConstraint *vWidth=[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:32];
//    NSLayoutConstraint *vHeight=[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:32];
//    
//    NSArray * vList=@[vBottom,vRight,vWidth,vHeight];
//    [self addConstraints:vList];
//    //////////////
//    NSLayoutConstraint * tLeft=[NSLayoutConstraint constraintWithItem:self.promptLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    NSLayoutConstraint * tBottom=[NSLayoutConstraint constraintWithItem:self.promptLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-13];
//    NSLayoutConstraint * tRight=[NSLayoutConstraint constraintWithItem:self.promptLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
//    NSLayoutConstraint * tHeight=[NSLayoutConstraint constraintWithItem:self.promptLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:32];
//    
//    NSArray * tList=@[tLeft,tBottom,tRight,tHeight];
//    
//    [self addConstraints:tList];
//    
//}

- (void)initViews
{
    self.backgroundColor= [UIColor clearColor];;
    self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 15)];
    self.promptLabel.textColor = kTextColor;
    self.promptLabel.font = kTextFont;
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.promptLabel];
    
    self.dateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.promptLabel.frame)+10-5, kScreenWidth, 15)];
    self.dateLable.text = @"从未更新";
    self.dateLable.textColor = RGB_255(150,150,150);
    self.dateLable.font = kTextFont;
    self.dateLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dateLable];
    
    self.lodingView = [[ECircleLoadingView alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, CGRectGetMaxY(self.promptLabel.frame), 20, 20)];
    [self addSubview:self.lodingView];
    
    [self resetViews];
    
}

- (NSString *)updateRefreshDate :(NSDate *)date{
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
    return  [NSString stringWithFormat:@"%@: %@",
                       NSLocalizedString(@"最后更新", @""),
                       dateString];
   
}


- (void)resetViews
{
    [self.lodingView stopAnimation];
       _promptLabel.text=@"下拉刷新";
//    self.dateLable.text = [self updateRefreshDate:[NSDate date]];
    
}

- (void)canEngageRefresh
{
    _promptLabel.text=@"松开刷新";
    
}

- (void)didDisengageRefresh
{
    [self resetViews];
}

- (void)startRefreshing
{
    [self.lodingView startAnimation];
    _promptLabel.text=@"正在加载...";
}

- (void)finishRefreshingWithIsNetData:(NSDate *)date
{
    [self.lodingView stopAnimation];
    _promptLabel.text=@"下拉刷新";
    if (date) {
       self.dateLable.text = [self updateRefreshDate:date];
    }
//    else{
//    self.dateLable.text = [self updateRefreshDate:[NSDate date]];
//    }
}




@end
