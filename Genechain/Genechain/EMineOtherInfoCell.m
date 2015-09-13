//
//  EMineOtherInfoCell.m
//  Examda
//
//  Created by mark on 15/1/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EMineOtherInfoCell.h"
@implementation EMineOtherInfoCell

- (void)awakeFromNib {
    
    self.lblTitle.textColor = kCommColor_333;
//    self.lblTitle.font = kCommonFont_30px;
   
    self.lblInfo.textColor = kCommColor_555;
//    self.lblInfo.font = kCommonFont_30px;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self adjustSeparator];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
