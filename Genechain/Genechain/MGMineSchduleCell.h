//
//  MGMineSchduleCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSchduleHelp.h"
#import "MGMangerSchduleModel.h"
static NSString *const MGMineSchduleCellClassName = @"MGMineSchduleCell";
@interface MGMineSchduleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imavHead;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleContent;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

- (void)setUivalueWithModel:(MGMangerSchduleModel *)model;
- (void)setBtnActionHandle:(T2TBacsicBlock)handleBlock;

+ (CGFloat)getCellHeightWithModel:(MGMangerSchduleModel *)model;
@end
