//
//  MGCalendarCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGCalendarCell.h"

@implementation MGCalendarCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
