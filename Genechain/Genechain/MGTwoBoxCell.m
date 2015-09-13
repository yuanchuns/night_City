//
//  MGTwoBoxCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGTwoBoxCell.h"
#import "MGSchduleHelp.h"
@implementation MGTwoBoxCell
{

    T2TBasicBlock _firBlock;
    T2TBasicBlock _secBlock;
}
- (void)awakeFromNib {
    // Initialization code
    [T2TView setRoundCornerFor:self.viewFirBackGround radiu:2 bdColor:kMGLineColor bdW:0.5];
    [T2TView setRoundCornerFor:self.viewSecBackGround radiu:2 bdColor:kMGLineColor bdW:0.5];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.lblFir.userInteractionEnabled = NO;
    self.lblSec.userInteractionEnabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapFir)];
    [self.viewFirBackGround addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapSec)];
    [self.viewSecBackGround addGestureRecognizer:tap1];
    
}

- (void)actionTapSec{
    
    (!_secBlock) ?:_secBlock();
}

- (void)actionTapFir{
    
   (!_firBlock) ?:_firBlock();
}

- (void)setLblFirHandle:(T2TBasicBlock)firBlock{
    _firBlock = firBlock;
}

- (void)setLblSecHandle:(T2TBasicBlock)firBlock{

    _secBlock = firBlock;
}

- (void)resetLblFir{
    self.lblFir.textColor = [UIColor blackColor];
    self.lblFir.text = @"";
}
- (void)resetLblSec{
    self.lblSec.textColor = [UIColor blackColor];
    self.lblSec.text = @"";
}
- (void)setLblFirPlahodler:(NSString *)plahodler{
    self.lblFir.text = plahodler;
    self.lblFir.textColor = MGSchduleTextColor_content;
}
- (void)setLblSecPlahodler:(NSString *)plahodler{
    self.lblSec.text = plahodler;
    self.lblSec.textColor = MGSchduleTextColor_content;
}

- (void)hidenRightRowImav{

    self.imavSec.hidden = YES;
    self.imavFir.hidden = YES;
    self.contImavOneWidth.constant = 0;
    self.contImavSecWidth.constant = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
