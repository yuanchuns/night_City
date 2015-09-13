//
//  WorkSecondTableViewCell.h
//  Genechain
//
//  Created by nextone on 15/8/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WY.h"
#import "workMode.h"
@interface WorkSecondTableViewCell : UITableViewCell



@property(nonatomic,strong)UILabel *labelOne;
@property(nonatomic,strong)UILabel *labelTow;
@property(nonatomic,strong)UILabel *labelThree;
@property(nonatomic,strong)UILabel *labelFour;
@property(nonatomic,strong)UILabel *labelFive;
@property(nonatomic,strong)UILabel *labelSex;


@property(nonatomic)BOOL isBook;


- (void)setUivalueWithModel:(workModeSecond *)model;
- (void)BookModeSetUivalueWithModel:(bookModeFinish *)model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;


+(CGFloat )BookGetCellHeigth:(bookModeFinish *)model;

+(CGFloat )getCellHeigth:(workModeSecond *)model;

@end
