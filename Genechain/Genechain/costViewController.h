//
//  costViewController.h
//  Genechain
//
//  Created by nextone on 15/9/2.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"
#import "workMode.h"
@interface costViewController : T2TViewController


@property(nonatomic)BOOL isBook;
@property(nonatomic,strong)workMode *model;
@property(nonatomic,strong)bookMode *Bookmodel;

@property(nonatomic,copy)NSString *price;
@end
