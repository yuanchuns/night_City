//
//  MGTaskerCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSchduleDetailTaskerModel.h"
static NSString *const MGTaskerCellClassName = @"MGTaskerCell";
@interface MGTaskerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imavHead;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UIView *viewBottomLine;
- (void)setUIValueWithModel:(MGSchduleDetailTaskerModel *)model;
+ (CGFloat)getCellHeightWithModel:(MGSchduleDetailTaskerModel *)model;
@end
