//
//  T2TFailedView.m
//  T2TBasicLib
//
//  Created by mark on 15/1/15.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TFailedView.h"
#import "UIView+AddOther.h"
#import "T2THttpManager.h"
@interface T2TFailedView ()
@property (nonatomic, copy) T2TBacsicBlock refreshBlock;
@end

@implementation T2TFailedView

+(void)showFailedInView:(UIView *)superView response:(T2TResponse *)response arrData:(NSArray *)arrData withRefreshBlock:(T2TBacsicBlock)refreshBlock editFailedView:(EditFailedViewBlock)block{

    
    BOOL isConnect = ![T2THttpManager isConnectEnableWithAlter:NO];
    BOOL hasData = arrData.count>0;
    BOOL isServerError = NO;
    if ([response isKindOfClass:[T2TResponse class]] && isConnect) {
        isServerError = (response.s == kSuccessStatusCode)?NO:YES;
    }
    FailType type;
    if (!hasData) {
        type = isConnect?showTypeIsNoConnect:(isServerError?showTypeIsServerError:showTypeIsNoData);
    }else{
    
        type =  showTypeIsSuccess;
    }
    [self showFailedInView:superView failType:type withRefreshBlock:refreshBlock editFailedView:block];
    
    if (hasData ) {
        if (isConnect) {//没网
            [T2TView showFailHUDWithText:@"获取数据失败"];
        }else if([response.list isKindOfClass:[NSArray class]] && response.list <= 0){
            [T2TView showFailHUDWithText:@"获取数据失败"];
        }
    }
    
}
+(void)showFailedInView:(UIView *)superView failType:(FailType)type withRefreshBlock:(T2TBacsicBlock)refreshBlock editFailedView:(EditFailedViewBlock)block{

    if(type == showTypeIsSuccess)return;
    
    [T2TFailedView removeFromView:superView];
    T2TFailedView *faileView = [T2TFailedView createFailedViewWithFrame:superView.bounds withRefreshBlock:refreshBlock];
    [superView addSubview:faileView];
    //[superView bringSubviewToFront:faileView];
    faileView.isRequestFailed = YES;
    switch (type) {
        case showTypeIsNoConnect:
        {
          faileView.lblTitle.text = @"网络未连接";
          faileView.lblInfo.text = @"请检查网络连接后点击屏幕重新刷新";
        }
            break;
        case showTypeIsNoData:
        {
          faileView.lblTitle.text = @"暂无数据";
          faileView.lblInfo.text = @"稍后请点击页面重新刷新";
        }
            break;
        case showTypeIsServerError:
        {
            faileView.lblTitle.text = @"服务器连接失败";
            faileView.lblInfo.text = @"稍后请点击页面重新刷新";
        }
            break;
        default:
            break;
    }
    
    if(block)block(faileView);
    
}

-(void)actionTap{

    if(self.refreshBlock)_refreshBlock();
    
}

+(T2TFailedView *)createFailedViewWithFrame:(CGRect)frame withRefreshBlock:(T2TBacsicBlock)block{

    T2TFailedView *failedView =  [[T2TFailedView alloc] initWithFrame:frame];
    failedView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:failedView action:@selector(actionTap)];
    failedView.refreshBlock = block;
    [failedView addGestureRecognizer:tap];
    
    failedView.imavInfo = [[UIImageView alloc] init];
    UIImage *ima = [UIImage imageNamed:@"ico_abnormal"];
    failedView.imavInfo.frame = CGRectMake(0, 100, 100, 100);
    failedView.imavInfo.center = CGPointMake(failedView.width/2, 120);
    failedView.imavInfo.image = ima;
    [failedView addSubview:failedView.imavInfo];
    
    failedView.lblTitle = [T2TLabel lblWithFram:CGRectMake(0, failedView.imavInfo.bottom+10, failedView.width, 20) textColor:RGB_255(204, 204, 204) font:@12 align:NSTextAlignmentCenter];
    [failedView addSubview:failedView.lblTitle];
    
    
    failedView.lblInfo = [T2TLabel lblWithFram:CGRectMake(0, failedView.lblTitle.bottom+10, failedView.width, 20) textColor:RGB_255(204, 204, 204) font:@12 align:NSTextAlignmentCenter];
    failedView.lblInfo.textColor = RGB_255(204, 204, 204);
    [failedView addSubview:failedView.lblInfo];
    return failedView;
}


+(void)removeFromView:(UIView *)aView{
    
    T2TFailedView *failView = (T2TFailedView *)[aView subViewOfClass:[T2TFailedView class]];
    if ([failView isKindOfClass:[T2TFailedView class]]) {
        [failView removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
