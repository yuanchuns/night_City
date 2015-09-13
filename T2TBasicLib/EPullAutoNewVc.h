//
//  EPullAutoNewVc.h
//  T2TBasicLib
//
//  Created by mark on 15/1/15.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EPullNewVC.h"
#import "T2TResponse.h"
#import "T2TFailedView.h"
@interface EPullAutoNewVc : EPullNewVC
@property(nonatomic,assign)BOOL isLoading;//是都正在加载中
@property(nonatomic,copy)EditFailedViewBlock failedViewBlock;

//重新的去请求数据
-(void)reloadData;
-(void)loadData;
-(NSString *)getRequestUrlStr;

-(void)handleContentData:(id)content;

-(void)handleContentResponse:(T2TResponse *)content;

-(void)finishHandleDataWithResponse:(T2TResponse *)res;

-(void)willStartPullDownFreash;
@end
