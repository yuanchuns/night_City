//
//  MGEmployeeCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGEmployeeCell.h"
#import "MGSchduleHelp.h"
@implementation MGEmployeeCell

- (void)awakeFromNib {
    // Initialization code
    
    self.lblMail.textColor = MGSchduleTextColor_content;
    self.lblTel.textColor = MGSchduleTextColor_content;
    [self adjustSeparator];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setUIValueWithModel:(MGEmployeeModel *)model {

    self.lblTel.text = model.mobile;
    self.lblName.text = model.employeeName;
    self.lblMail.text = model.mail;
    [self.imavHead sd_setImageWithURL:[NSURL URLWithString:getImaUrlWithName(model.employeeNo)] placeholderImage:kDefaultHeadImg];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
