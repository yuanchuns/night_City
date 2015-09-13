//
//  RefreshBottomView.m
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



#import "RefreshBottomView.h"
#import "Define_basic.h"
#import "UIColor+HexString.h"

#define kTextColor [UIColor colorWithHexString:@"#808080"]
#define kTextFont [UIFont fontWithName:@"STHeitiSC-Light" size:12]
@implementation RefreshBottomView


- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self initViews];
    }
    return self;
}

- (void)initViews
{

    self.backgroundColor=[UIColor clearColor];
    self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 15)];
    self.promptLabel.font = kTextFont;
    self.promptLabel.textColor = kTextColor;
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.promptLabel];
    
    
    self.lodingView = [[ECircleLoadingView alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, 18, 20, 20)];
    [self addSubview:self.lodingView];
    
}

- (void)resetViews
{
    _promptLabel.text=@"上拉加载更多";
    [self.lodingView stopAnimation];
}


///松开可刷新
- (void)canEngageRefresh
{
    _promptLabel.text=@"松开立即加载";
    
}
///松开返回
- (void)didDisengageRefresh
{
    [self resetViews];
}
///开始刷新
- (void)startRefreshing
{
    self.lodingView.hidden = NO;
   _promptLabel.text = @"正在加载...";
    [self.lodingView startAnimation];
    
}
///结束
- (void)finishRefreshingWithIsNetData:(NSDate *)date
{
    [self resetViews];
}

-(void)isNoDataToRequest{
    _promptLabel.hidden=NO;
    self.lodingView.hidden = YES;
    _promptLabel.text=@"没有更多了哟";
}

@end
