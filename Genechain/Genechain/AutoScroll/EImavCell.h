//
//  EImavCell.h
//  Examda
//
//  Created by mark on 15/4/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EAutoScrollView.h"

@interface EImavCell : UITableViewCell
@property (nonatomic,strong)EAutoScrollView *autoScr;
@property (nonatomic,strong) T2TLabel *lblInfo;
@property (nonatomic,strong) UIPageControl *control;
@end
