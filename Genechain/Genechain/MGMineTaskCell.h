//
//  MGMineTaskCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGMineTaskModel.h"
static NSString *const MGMineTaskCellClassName = @"MGMineTaskCell";
@interface MGMineTaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imavHead;
@property (weak, nonatomic) IBOutlet UILabel *lblFirLine;
@property (weak, nonatomic) IBOutlet UILabel *lblSecLine;
@property (weak, nonatomic) IBOutlet UILabel *lblTirLine;
@property (weak, nonatomic) IBOutlet UILabel *lblFourLine;
@property (weak, nonatomic) IBOutlet UILabel *lblFiveLine;

+ (CGFloat)getCellHeightWithModel:(MGMineTaskModel *)model;
- (void)setUIValueWithModel:(MGMineTaskModel *)model;
@end
