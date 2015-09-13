//
//  BoolViewController.h
//  Genechain
//
//  Created by nextone on 15/9/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"
typedef void(^respondSelect)(NSString *selectStr);

@interface BoolViewController : T2TViewController

@property(nonatomic,copy)respondSelect selectStr;
@end
