//
//  MGOneBoxCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGOneBoxCell.h"
#import "MGSchduleHelp.h"
@implementation MGOneBoxCell
{

    T2TBacsicBlock _longBlock;
}
- (void)awakeFromNib {
    // Initialization code
    [T2TView setRoundCornerFor:self.viewBackground radiu:2 bdColor:kMGLineColor bdW:0.5];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionLongGes)];
    self.lblContent.userInteractionEnabled = YES;
    longGes.minimumPressDuration = 1.0f;
    [self.lblContent addGestureRecognizer:longGes];

}

- (void)actionLongGes {

    (!_longBlock) ?:_longBlock();
}

- (void)setLongGesHandle:(T2TBacsicBlock)longBlock {

    _longBlock = longBlock;
}

- (void)setPlaceholder:(NSString *)placeholder{

    self.lblContent.text = placeholder;
    self.lblContent.textColor = MGSchduleTextColor_content;
}

- (void)resetCell{
    self.lblContent.textColor = [UIColor blackColor];
    self.lblContent.text = @"";
}

- (void)hidenRightRowImav{

    self.imavRight.hidden = YES;
    self.contImavWidth.constant =0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
