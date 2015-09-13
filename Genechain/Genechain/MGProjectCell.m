//
//  MGProjectCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/12.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGProjectCell.h"
#import "MGSchduleHelp.h"
@implementation MGProjectCell

- (void)awakeFromNib {
    // Initialization code
    self.lblTasker.textColor = MGSchduleTextColor_content;
    self.lblState.textColor = MGSchduleTextColor_content;
    self.lblClient.textColor = MGSchduleTextColor_kind_2;
    [self adjustSeparator];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUIValueWithModel:(MGProjectModel *)model {

    self.lblClient.text =  [@"(客户)" stringByAppendingString:kUnNilStr(model.clientName)];
    self.lblProject.text =  [@"(项目)" stringByAppendingString:kUnNilStr(model.projectName)];
    self.lblState.text = kUnNilStr(model.statusName);
    self.lblTasker.text = kUnNilStr(model.managerName);
    
}

+ (CGFloat)getCellHeightWithModel:(MGProjectModel *)model {

    CGFloat allHeight = 35;
    allHeight += [T2TCommonAction heightFoStr:[@"(客户)" stringByAppendingString:kUnNilStr(model.clientName)] font:kCommonFont_28px width:kScreenWidth-57];
    allHeight += [T2TCommonAction heightFoStr:[@"(项目)" stringByAppendingString:kUnNilStr(model.projectName)] font:kCommonFont_28px width:kScreenWidth-57];
    return allHeight;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
