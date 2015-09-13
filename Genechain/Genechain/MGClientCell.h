//
//  MGClientCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/12.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGClientModel.h"

static NSString *MGClientCellClassName = @"MGClientCell";

@interface MGClientCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTasker;
@property (weak, nonatomic) IBOutlet UILabel *lblClient;
- (void)setUIValueWithModel:(MGClientModel *)model;
+ (CGFloat)getCellHeightWithModel:(MGClientModel *)model;
@end
