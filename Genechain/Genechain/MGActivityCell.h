//
//  MGActivityCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGActivetyOfEnrollmentModel.h"
#import "MGActivetyOfExhibition.h"

static NSString *const MGActivityCellClassName = @"MGActivityCell";

@interface MGActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCitivityName;
@property (weak, nonatomic) IBOutlet UILabel *lblComName;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblResion;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;

+ (CGFloat)getCellHeightWithExhibitionModel:(MGActivetyOfExhibition *)model;
+ (CGFloat)getCellHeightWithEnrollmentModel:(MGActivetyOfEnrollmentModel *)model;

- (void)setUIValueWithEnrollmentModel:(MGActivetyOfEnrollmentModel *)model;
- (void)setUIValueWithExhibitionModel:(MGActivetyOfExhibition *)model;


@end
