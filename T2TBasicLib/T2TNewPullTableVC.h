//
//  T2TNewPullTableVC.h
//  T2TBasicLib
//
//  Created by mark on 15/1/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TTReauestResponse.h"
#import "PullingRefreshTableView.h"
#import "T2TResponse.h"
@interface T2TNewPullTableVC : UITableViewController
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,assign)BOOL isLoading;
@property(nonatomic,assign)int curPageIndex;
@property(nonatomic,assign)int allPages;
@property(nonatomic,strong)PullingRefreshTableView *pullTable;

-(void)reloadFirPage;

-(NSString *)getRequestUrlStr;

-(void)handleContentData:(id)content;

-(void)handleContentResponse:(T2TResponse *)content;

@end
