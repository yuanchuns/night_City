//
//  MGHomeItemCell.m
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGHomeItemCell.h"

@implementation MGHomeItemCell

- (void)awakeFromNib {
    // Initialization code
    self.lblTitle.font = kCommonFont_28px;
    self.lblTitle.textColor = [UIColor colorWithHexString:@"#333"];
    
}

@end
