//
//  workSpaceViewController.h
//  Genechain
//
//  Created by nextone on 15/8/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "T2TViewController.h"
#import "T2TFailedView.h"
@interface workSpaceViewController : T2TViewController
@property(nonatomic)BOOL isBookMessage;


@property(nonatomic,copy)EditFailedViewBlock failedViewBlock;

@end
