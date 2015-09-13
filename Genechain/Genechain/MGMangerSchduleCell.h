//
//  MGMangerSchduleCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGMangerSchduleModel.h"

static NSString *const MGMangerSchduleCellClassName = @"MGMangerSchduleCell";
@interface MGMangerSchduleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblFirLine;
@property (weak, nonatomic) IBOutlet UIImageView *imavHead;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblSecLine;
@property (weak, nonatomic) IBOutlet UILabel *lblTirLine;
@property (weak, nonatomic) IBOutlet UILabel *lblFourLine;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;


- (void)setUIValueWithModel:(MGMangerSchduleModel *)model;
+ (CGFloat)getCellHeightWithModel:(MGMangerSchduleModel *)model;

@end
