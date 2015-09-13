//
//  WorkTableViewCell.h
//  Genechain
//
//  Created by nextone on 15/8/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WY.h"
#import "workMode.h"
@interface WorkTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *labelOne;
@property(nonatomic,strong)UILabel *labelTow;
@property(nonatomic,strong)UILabel *labelThree;

@property(nonatomic)BOOL isBook;
- (void)setUivalueWithModel:(workMode *)model;
- (void)BookModeSetUivalueWithModel:(bookMode *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat )BookGetCellHeigth:(bookMode *)model;

+(CGFloat )getCellHeigth:(workMode *)model;
@end
