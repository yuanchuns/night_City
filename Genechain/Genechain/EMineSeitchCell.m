//
//  EMineSeitchCell.m
//  Examda
//
//  Created by mark on 15/1/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EMineSeitchCell.h"
@implementation EMineSeitchCell
{
    
    T2TBOOLBlock _valueBlock;
}
- (void)awakeFromNib {
    
        [UIColor colorWithHexString:@"#555"];
    
    self.lblTitle.textColor = kCommColor_333;
    self.lblTitle.font = kCommonFont_30px;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.switchInfo addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self adjustSeparator];
    
}

-(void)valueChange:(UISwitch *)swi{
    
    if(_valueBlock)_valueBlock(swi.on);
    
}


-(void)setSwitchHandle:(T2TBOOLBlock)block{
    
    _valueBlock = block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
