//
//  MGWebVc.h
//  Genechain
//
//  Created by mark on 15/7/29.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"

@interface MGWebVc : T2TViewController
@property (nonatomic, copy) NSString *url;

+ (MGWebVc *)getMGWebView;
@end
