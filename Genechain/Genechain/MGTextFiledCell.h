//
//  MGTextFiledCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const MGTextFiledCellClassName = @"MGTextFiledCell";
@interface MGTextFiledCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
- (void)setTextFiledTextChangeHandle:(T2TObjBlock)textBlock;
@end
