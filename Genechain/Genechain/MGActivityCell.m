//
//  MGActivityCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGActivityCell.h"
#import "MGSchduleHelp.h"
@implementation MGActivityCell

- (void)awakeFromNib {
    // Initialization code
    self.lblResion.textColor = MGSchduleTextColor_content;
    self.lblCitivityName.textColor = [UIColor redColor];
    [self adjustSeparator];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.clipsToBounds = YES;
    
}

- (void)setUIValueWithEnrollmentModel:(MGActivetyOfEnrollmentModel *)model {

    self.lblCitivityName.text = [@"活动:" stringByAppendingString:model.activityName];
    self.lblComName.text = model.companyName;
    self.lblStartDate.text = [@"开始日:" stringByAppendingString:model.beginDate];
    self.lblStartDate.text = [@"结束日:" stringByAppendingString:model.endDate];
    self.lblResion.text = @"";
    
}

- (void)setUIValueWithExhibitionModel:(MGActivetyOfExhibition *)model {

    self.lblCitivityName.text = [@"展会:" stringByAppendingString:model.expositionName];
    self.lblComName.text = model.companyName;
    self.lblResion.text = model.province;
    self.lblStartDate.text = self.lblStartDate.text = [@"开始日:" stringByAppendingString:model.beginDate];
    self.lblStartDate.text = [@"结束日:" stringByAppendingString:model.endDate];

}

+ (CGFloat)getCellHeightWithExhibitionModel:(MGActivetyOfExhibition *)model {
//64 65
    CGFloat allHeight = 64;
    allHeight += [T2TCommonAction heightForAtsWithStr:[@"展会:" stringByAppendingString:model.expositionName] font:kCommonFont_30px width:kScreenWidth-65 lineH:7];
    return allHeight;
}

+ (CGFloat)getCellHeightWithEnrollmentModel:(MGActivetyOfEnrollmentModel *)model {
    
    CGFloat allHeight = 64;
    allHeight += [T2TCommonAction heightForAtsWithStr:[@"活动:" stringByAppendingString:model.activityName] font:kCommonFont_30px width:kScreenWidth-65 lineH:7];
    return allHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
