//
//  MGTaskerCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGTaskerCell.h"
#import "MGSchduleHelp.h"
@implementation MGTaskerCell

- (void)awakeFromNib {
    // Initialization code

    self.lblName.textColor = MGSchduleTextColor_content;
    self.lblName.font = kCommonFont_24px;

    self.lblStartDate.textColor = MGSchduleTextColor_content;
    self.lblStartDate.font = kCommonFont_28px;
    
    self.lblInfo.textColor = MGSchduleTextColor_content;
    self.lblInfo.font = kCommonFont_24px;
    
    self.lblEndDate.textColor = MGSchduleTextColor_content;
    self.lblEndDate.font = kCommonFont_28px;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setUIValueWithModel:(MGSchduleDetailTaskerModel *)model{

    self.lblName.text = kUnNilStr(model.taskerName);
    self.lblStartDate.text = kUnNilStr(model.taskerStartDate);
    self.lblEndDate.text = kUnNilStr(model.taskerEndDate);
    self.lblInfo.text = kUnNilStr(model.taskerComment);
  
    [self.imavHead sd_setImageWithURL:[NSURL URLWithString:getImaUrlWithName(kUnNilStr(model.taskerNo))] placeholderImage:kDefaultHeadImg];
}

+ (CGFloat)getCellHeightWithModel:(MGSchduleDetailTaskerModel *)model{

    CGFloat allHeight = 72;
    allHeight += [T2TCommonAction heightFoStr:kUnNilStr(model.taskerComment) font:kCommonFont_28px width:kScreenWidth-72];
    return allHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
