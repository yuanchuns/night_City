//
//  MGMineSchduleCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMineSchduleCell.h"

@implementation MGMineSchduleCell
{
    T2TBacsicBlock _handleBlock;
}
- (void)awakeFromNib {
    // Initialization code
    self.lblDate.textColor = MGSchduleTextColor_content;
    self.lblInfo.textColor = MGSchduleTextColor_content;
    self.lblTitleContent.textColor = MGSchduleTextColor_content;
    [self adjustSeparator];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.btnAdd setBackgroundImage:kImaWithImaName(@"schedule_alarm_clock_gray") forState:UIControlStateNormal];
    [self.btnAdd setBackgroundImage:kImaWithImaName(@"schedule_alarm_clock_blue") forState:UIControlStateSelected];
//    self.lblTitleContent.backgroundColor = [UIColor redColor];
}

- (void)setBtnActionHandle:(T2TBacsicBlock)handleBlock{

    _handleBlock = handleBlock;
}

- (IBAction)btnAction:(id)sender {
    (!_handleBlock) ?:_handleBlock();
}

- (void)setUivalueWithModel:(MGMangerSchduleModel *)model{

    self.lblTitle.textColor = getTextColorWithKind(model.kind);
    self.lblTitle.text = [MGMineSchduleCell getContentFirstLineStrWithModel:model];
    self.lblTitleContent.text = [MGMineSchduleCell getContentSecondLineStrWithModel:model];
    self.lblInfo.text = kUnNilStr([MGMineSchduleCell getContentThirdLineStrWithModel:model]);
    self.lblDate.text = kUnNilStr(model.startDate);

    [self.imavHead sd_setImageWithURL:[NSURL URLWithString:getImaUrlWithName(model.taskerNo)] placeholderImage:kDefaultHeadImg];
    
}

+ (NSString *)getContentFirstLineStrWithModel:(MGMangerSchduleModel *)model{

    NSString *str = @"";
    
    switch (model.kind) {
        case 1:
            str = [NSString stringWithFormat:@"(%@)%@",kUnNilStr(model.cityName),kUnNilStr(model.taskName)];
            break;
          case 2:
            str = [NSString stringWithFormat:@"(%@)%@",kUnNilStr(model.cityName),kUnNilStr(model.clientName)];
            break;
        case 3:
            str = [NSString stringWithFormat:@"(%@)%@",kUnNilStr(model.cityName),kUnNilStr(model.clientName)];
            break;
        case 4:
            str = [NSString stringWithFormat:@"(%@)%@",kUnNilStr(model.cityName),kUnNilStr(model.activityName)];
            break;
        default:
            break;
    }
    return str;
}

+ (NSString *)getContentSecondLineStrWithModel:(MGMangerSchduleModel *)model{
    
    NSString *str = @"";
    switch (model.kind) {
        case 1:
            str = [NSString stringWithFormat:@"(内容)%@",kUnNilStr(model.taskName)];
            break;
        case 2:
            str = [NSString stringWithFormat:@"(内容)%@",kUnNilStr(model.taskName)];
            break;
        case 3:
            str = [NSString stringWithFormat:@"(项目)%@",kUnNilStr(model.projectName)];
            break;
        case 4:
            str = [NSString stringWithFormat:@"(内容)%@",kUnNilStr(model.taskName)];
            break;
        default:
            break;
    }
    return str;
}

+ (NSString *)getContentThirdLineStrWithModel:(MGMangerSchduleModel *)model{
    
    NSString *str = nil;
    if (model.kind == 3) {
        str = [NSString stringWithFormat:@"(内容)%@",kUnNilStr(model.taskName)];
    }
    return str;
}


+ (CGFloat)getCellHeightWithModel:(MGMangerSchduleModel *)model{
    //104 98
    CGFloat allHeight = 55;
    NSString *strFir = [self getContentFirstLineStrWithModel:model];
    NSString *strSec = [self getContentSecondLineStrWithModel:model];
    NSString *strTir = [self getContentThirdLineStrWithModel:model];
    CGFloat height_1 =  [T2TCommonAction heightFoStr:strFir font:kCommonFont_28px width:kScreenWidth - 103];
    CGFloat height_2 = [T2TCommonAction heightFoStr:strSec font:kCommonFont_28px width:kScreenWidth - 103];
    CGFloat height_3 = [T2TCommonAction heightFoStr:strTir font:kCommonFont_28px width:kScreenWidth - 103];
    allHeight = allHeight + height_1 + height_2 + (height_3 > 0 ? : 0);
    return MAX(allHeight, 100);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
