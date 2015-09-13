//
//  MGLoginVC.h
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"

@interface MGLoginVC : T2TViewController
@property (nonatomic, assign) BOOL isHaveBackBtn;
+ (MGLoginVC *)getLoginVC;
- (void)setLoginSuccessBlock:(T2TBacsicBlock)successBlock;
@end
