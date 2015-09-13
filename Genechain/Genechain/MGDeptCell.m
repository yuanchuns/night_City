//
//  MGDeptCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGDeptCell.h"

@implementation MGDeptCell

- (void)awakeFromNib {
    // Initialization code
    [self adjustSeparator];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
