//
//  MGSchdulePullVc.h
//  Genechain
//
//  Created by mark_zhang on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EPullNewVC.h"

@interface MGSchdulePullVc : EPullNewVC
-(NSString *)getRequestUrlStr;

-(void)handleContentResponse:(T2TResponse *)content;

-(void)reloadData;
@end
