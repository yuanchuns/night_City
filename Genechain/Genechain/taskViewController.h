//
//  taskViewController.h
//  Genechain
//
//  Created by nextone on 15/9/2.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TViewController.h"
#import "MGSchudleDetailModel.h"
#import "T2TFailedView.h"
#import "workMode.h"

typedef void(^taskCode)(taskMode *model);
@interface taskViewController : T2TViewController


@property(nonatomic,copy)taskCode taskcode;

@property (nonatomic, copy) EditFailedViewBlock failedViewBlock;

@property (nonatomic, strong) MGSchudleDetailModel *detailModel;
@end
