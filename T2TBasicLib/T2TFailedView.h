//
//  T2TFailedView.h
//  T2TBasicLib
//
//  Created by mark on 15/1/15.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Define_basic.h"
#import "Define_block.h"
#import "T2TLabel.h"
#import "T2TResponse.h"

#define kSuccessStatusCode 1


@class T2TFailedView;
typedef enum {
    
    showTypeIsNoConnect = 1,//没有网络连接
    showTypeIsServerError = 2,//服务器异常
    showTypeIsNoData = 3,//没有数据
    showTypeIsSuccess = 4//表示成功  没有错误
}FailType;

typedef void (^EditFailedViewBlock)(T2TFailedView *failedView);

@interface T2TFailedView : UIView

@property(nonatomic,strong)UIImageView *imavInfo;
@property(nonatomic,strong)T2TLabel *lblInfo;
@property(nonatomic,strong)T2TLabel *lblTitle;
@property(nonatomic,assign)BOOL isRequestFailed;

+(void)removeFromView:(UIView *)superView;

+(void)showFailedInView:(UIView *)superView failType:(FailType)type withRefreshBlock:(T2TBacsicBlock)block editFailedView:(EditFailedViewBlock)block;

+(void)showFailedInView:(UIView *)superView response:(T2TResponse *)response arrData:(NSArray *)arrData withRefreshBlock:(T2TBacsicBlock)block editFailedView:(EditFailedViewBlock)block;

@end
