//
//  MGEmployeeCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGEmployeeModel.h"

static NSString *const MGEmployeeCellClassName = @"MGEmployeeCell";

@interface MGEmployeeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imavHead;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;
@property (weak, nonatomic) IBOutlet UILabel *lblMail;
- (void)setUIValueWithModel:(MGEmployeeModel *)model;
@end
