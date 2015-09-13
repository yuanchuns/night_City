//
//  ListVC.h
//  Genechain
//
//  Created by nextone on 15/9/1.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "T2TViewController.h"
typedef void(^respondSelect)(NSString *selectStr);

@interface ListVC : T2TViewController
@property(nonatomic,copy)respondSelect selectStr;

@end
