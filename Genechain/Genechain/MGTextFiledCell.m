//
//  MGTextFiledCell.m
//  Genechain
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGTextFiledCell.h"

@implementation MGTextFiledCell
{
    T2TObjBlock _textBlock;
}
- (void)awakeFromNib {
    // Initialization code
    
    [self.textFiled addTarget:self action:@selector(textFiledChange) forControlEvents:UIControlEventEditingChanged];
    
    
}

- (void)setTextFiledTextChangeHandle:(T2TObjBlock)textBlock {

    _textBlock = textBlock;
}

- (void)textFiledChange {

    //去掉空格后的文字
    (!_textBlock) ?:_textBlock([self.textFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
