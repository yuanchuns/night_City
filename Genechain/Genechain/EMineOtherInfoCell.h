//
//  EMineOtherInfoCell.h
//  Examda
//
//  Created by mark on 15/1/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kEMineOtherInfoCellKey = @"EMineOtherInfoCell";
@interface EMineOtherInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imavArrowRight;
@end
