//
//  MGMineTaskCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMineTaskCell.h"
#import "MGSchduleHelp.h"
@implementation MGMineTaskCell

- (void)awakeFromNib {
    // Initialization code
    self.lblName.textColor = MGSchduleTextColor_content;
    self.lblFourLine.textColor = MGSchduleTextColor_content;
    self.lblFiveLine.textColor = MGSchduleTextColor_content;
    [self adjustSeparator];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setUIValueWithModel:(MGMineTaskModel *)model{

    self.lblFirLine.textColor = (model.taskerStatus == 0)?[UIColor redColor]:MGSchduleTextColor_kind_2;
    if (model.taskerStatus == 1) {
        
        self.lblSecLine.textColor =  MGSchduleTextColor_content;
        self.lblTirLine.textColor = MGSchduleTextColor_content;
    }else{
    
        self.lblSecLine.textColor = [UIColor blackColor];
        self.lblTirLine.textColor = [UIColor blackColor];
    }
    MGUserModel *manger = [MGUserModel shareMGUserModel];
    self.lblName.text = kUnNilStr(manger.userName);
    self.lblFirLine.text = [MGMineTaskCell getFirLineStrWithModel:model];
    self.lblSecLine.text = [MGMineTaskCell getSecLineStrWithModel:model];
    self.lblTirLine.text = [MGMineTaskCell getTirLineStrWithModel:model];
    self.lblFourLine.text = [MGMineTaskCell getFourLineStrWithModel:model];
    self.lblFiveLine.text = [MGMineTaskCell getFiveLineStrWithModel:model];
    
    [self.imavHead sd_setImageWithURL:[NSURL URLWithString:getImaUrlWithName(model.taskerNo)] placeholderImage:kDefaultHeadImg];

}

+ (NSString *)getFirLineStrWithModel:(MGMineTaskModel *)model{

    return [NSString stringWithFormat:@"[客户]%@",kUnNilStr(model.clientName)];
    
}

+ (NSString *)getSecLineStrWithModel:(MGMineTaskModel *)model{
   
    return [NSString stringWithFormat:@"[项目]%@",kUnNilStr( model.projectName)];
    
}

+ (NSString *)getTirLineStrWithModel:(MGMineTaskModel *)model{
    
    return [NSString stringWithFormat:@"[任务]%@",kUnNilStr(model.taskName)];
    
}

+ (NSString *)getFourLineStrWithModel:(MGMineTaskModel *)model{
   
    return [NSString stringWithFormat:@"[类型]%@->%@%d天",kUnNilStr(model.taskTypeName),kUnNilStr(model.taskerTypeName),model.taskerDays];
}

+ (NSString *)getFiveLineStrWithModel:(MGMineTaskModel *)model{
    return [NSString stringWithFormat:@"%@ %@ 至 %@ %@", kUnNilStr(model.taskerStartDate),kUnNilStr(model.taskerStartTime),kUnNilStr(model.taskerEndDate),kUnNilStr(model.taskerEndTime)];
    
}

+ (CGFloat)getCellHeightWithModel:(MGMineTaskModel *)model{
    CGFloat allHeight = 88;
    allHeight += [T2TCommonAction heightFoStr:[self getFirLineStrWithModel:model] font:kCommonFont_28px width:kScreenWidth-72];
    allHeight += [T2TCommonAction heightFoStr:[self getSecLineStrWithModel:model] font:kCommonFont_28px width:kScreenWidth-72];
    allHeight += [T2TCommonAction heightFoStr:[self getTirLineStrWithModel:model] font:kCommonFont_28px width:kScreenWidth-72];
    allHeight += [T2TCommonAction heightFoStr:[self getFourLineStrWithModel:model] font:kCommonFont_28px width:kScreenWidth-72];
    allHeight += [T2TCommonAction heightFoStr:[self getFiveLineStrWithModel:model] font:kCommonFont_28px width:kScreenWidth-72];
    return MAX(100, allHeight);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
