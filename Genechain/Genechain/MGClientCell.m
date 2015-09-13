//
//  MGClientCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/12.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGClientCell.h"
#import "MGSchduleHelp.h"



@implementation MGClientCell

- (void)awakeFromNib {
    // Initialization code
    self.lblClient.textColor = MGSchduleTextColor_kind_2;
    [self adjustSeparator];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setUIValueWithModel:(MGClientModel *)model {

    NSString  *strClient = [NSString stringWithFormat:@"(%@)%@",kUnNilStr(model.region),kUnNilStr(model.clientName)];
    self.lblClient.text = strClient;
    self.lblTasker.text = kUnNilStr(model.managerName);
    
}

+ (CGFloat)getCellHeightWithModel:(MGClientModel *)model {

    NSString  *strClient = [NSString stringWithFormat:@"(%@)%@",kUnNilStr(model.region),kUnNilStr(model.clientName)];
    CGFloat allHeight = 20;
    allHeight += [T2TCommonAction heightForAtsWithStr:strClient font:kCommonFont_28px width:kScreenWidth-57 lineH:7];
    return MAX(allHeight, 45);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
