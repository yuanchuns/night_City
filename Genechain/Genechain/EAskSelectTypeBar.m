//
//  EAskSelectTypeBar.m
//  Examda
//
//  Created by mark on 15/8/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EAskSelectTypeBar.h"

@implementation EAskSelectTypeBar
{

    EAskSelectTypeBlock _typeBlock;
}
- (void)awakeFromNib {
    // Initialization code
    [self.btnOneBox setTitleColor:[UIColor colorWithHexString:@"#555"] forState:UIControlStateNormal];
    [self.btnOneBox setTitleColor:[UIColor colorWithHexString:@"#46bbf0"] forState:UIControlStateSelected];
    
    [self.btnTwoBox setTitleColor:[UIColor colorWithHexString:@"#555"] forState:UIControlStateNormal];
    [self.btnTwoBox setTitleColor:[UIColor colorWithHexString:@"#46bbf0"] forState:UIControlStateSelected];
    
    self.viewLineBottom.backgroundColor = [UIColor colorWithHexString:@"#dbdbdb"];
    
    self.viewCenter.backgroundColor = [UIColor colorWithHexString:@"#dbdbdb"];
    
    self.viewLineOne.backgroundColor = [UIColor colorWithHexString:@"#46bbf0"];
    self.viewLineTwo.backgroundColor = [UIColor colorWithHexString:@"#46bbf0"];
    [self changeBoxWithType:selectedOneBox];
    
    [self bringSubviewToFront:self.viewLineOne];
    [self bringSubviewToFront:self.viewLineTwo];
}

-(void)changeBoxWithType:(selectedType)type{
    
    self.type = type;
    
    if (type == selectedOneBox) {
        self.btnOneBox.selected = YES;
        self.btnTwoBox.selected = NO;
        self.viewLineOne.hidden = NO;
        self.viewLineTwo.hidden = YES;
    }else{
        self.btnOneBox.selected = NO;
        self.btnTwoBox.selected = YES;
        self.viewLineOne.hidden = YES;
        self.viewLineTwo.hidden = NO;
    }
    
}

- (void)setSelectedHandle:(EAskSelectTypeBlock)block {

    _typeBlock = block;
}

- (IBAction)actionBtnTwoBox:(id)sender {
    
    [self changeBoxWithType:selectedTwoBox];
    (!_typeBlock) ?:_typeBlock(selectedTwoBox);
    
}

- (IBAction)actionBtnOneBox:(id)sender {
    [self changeBoxWithType:selectedOneBox];
    (!_typeBlock) ?:_typeBlock(selectedOneBox);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
