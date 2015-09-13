//
//  EPullAutoNewTableVC.h
//  T2TBasicLib
//
//  Created by mark on 15/1/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EPullNewTableVC.h"
#import "T2TResponse.h"
#import "T2TFailedView.h"
@interface EPullAutoNewTableVC : EPullNewTableVC
@property (nonatomic, assign) BOOL isLoading;//是否正在刷新
@property (nonatomic, copy) EditFailedViewBlock failedViewBlock;
@property (nonatomic, assign) BOOL isNotAuto;
//重新的去请求数据
-(void)reloadData;


/**
 *  一下方法需要子类去继承
 *
 *
 */

-(NSString *)getRequestUrlStr;

-(void)handleContentData:(id)content;

-(void)handleContentResponse:(T2TResponse *)content;
@end
