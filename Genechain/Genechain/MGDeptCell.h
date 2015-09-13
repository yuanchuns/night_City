//
//  MGDeptCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const MGDeptCellClassName = @"MGDeptCell";
@interface MGDeptCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contLblTextHead;
@property (weak, nonatomic) IBOutlet UILabel *lblText;

@end
