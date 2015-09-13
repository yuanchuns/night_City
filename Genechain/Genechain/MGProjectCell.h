//
//  MGProjectCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/12.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGProjectModel.h"
static NSString *const MGProjectCellClassName = @"MGProjectCell";
@interface MGProjectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblClient;
@property (weak, nonatomic) IBOutlet UILabel *lblProject;
@property (weak, nonatomic) IBOutlet UILabel *lblTasker;
@property (weak, nonatomic) IBOutlet UILabel *lblState;

- (void)setUIValueWithModel:(MGProjectModel *)model;

+ (CGFloat)getCellHeightWithModel:(MGProjectModel *)model;

@end
