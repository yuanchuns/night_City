//
//  MGMangerSchduleCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMangerSchduleCell.h"
#import "MGSchduleHelp.h"
@implementation MGMangerSchduleCell

- (void)awakeFromNib {
    // Initialization code
    
    self.lblTirLine.textColor = MGSchduleTextColor_content;
    self.lblFourLine.textColor = MGSchduleTextColor_content;
    self.lblEndDate.textColor = MGSchduleTextColor_content;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self adjustSeparator];

    
}


- (void)setUIValueWithModel:(MGMangerSchduleModel *)model{

    
    self.lblEndDate.text = [@"结束日期:" stringByAppendingString:kUnNilStr(model.endDate)];
    self.lblSecLine.textColor = getTextColorWithKind(model.kind);
    self.lblFirLine.text = kUnNilStr(model.persons);
    self.lblSecLine.text = kUnNilStr([MGMangerSchduleCell getSecLineTextWithModel:model]);
     self.lblTirLine.text = kUnNilStr([MGMangerSchduleCell getTirLineTextWithModel:model]);
     self.lblFourLine.text = kUnNilStr([MGMangerSchduleCell getFourLineTextWithModel:model]);
    self.lblDate.text = kUnNilStr(model.startDate);
    [self.imavHead sd_setImageWithURL:[NSURL URLWithString:getImaUrlWithName(model.createrNo)] placeholderImage:kDefaultHeadImg];
    
}

+ (CGFloat)getCellHeightWithModel:(MGMangerSchduleModel *)model{

    CGFloat allHeight = 60;
    allHeight = allHeight + [T2TCommonAction heightFoStr:[self getSecLineTextWithModel:model] font:kCommonFont_28px width:kScreenWidth-122] + [T2TCommonAction heightFoStr:[self getTirLineTextWithModel:model] font:kCommonFont_28px width:kScreenWidth-122] + [T2TCommonAction heightFoStr:[self getFourLineTextWithModel:model] font:kCommonFont_28px width:kScreenWidth-122] + [T2TCommonAction heightFoStr:kUnNilStr(model.persons) font:kCommonFont_28px width:kScreenWidth-122] + [T2TCommonAction heightFoStr:model.persons font:kCommonFont_28px width:kScreenWidth-265];
    
    return MAX(allHeight, 100);
}

#pragma mark - privateFunc
+ (NSString *)getSecLineTextWithModel:(MGMangerSchduleModel *)model{

    NSString *text;
//    model.clientName
    switch (model.kind) {
        case 1:case 4:
        text = [NSString stringWithFormat:@"内容(%@)%@",model.cityName,model.taskName];
            break;
        case 2:case 3:
        text = [NSString stringWithFormat:@"(%@)%@",model.cityName,model.clientName];
            break;
        default:
            break;
    }
    return text;
}

+ (NSString *)getTirLineTextWithModel:(MGMangerSchduleModel *)model{
    
    NSString *text;
    switch (model.kind) {
        case 1:case 4:case 2:
            text = [NSString stringWithFormat:@"(内容)%@",model.taskName];
            break;
        case 3:
            text = [NSString stringWithFormat:@"(项目)%@",model.projectName];
            break;
        default:
            break;
    }
    return text;
}

+ (NSString *)getFourLineTextWithModel:(MGMangerSchduleModel *)model{
    
    NSString *text = nil;
    if (model.kind == 3) {
        text = [NSString stringWithFormat:@"(内容)%@",model.taskName];
    }
        return text;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
