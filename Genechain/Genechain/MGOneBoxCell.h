//
//  MGOneBoxCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const MGOneBoxCellClassName = @"MGOneBoxCell";
@interface MGOneBoxCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contImavWidth;

@property (weak, nonatomic) IBOutlet UIImageView *imavRight;
@property (nonatomic, copy) NSString *placeholder;
- (void)setLongGesHandle:(T2TBacsicBlock)longBlock;
- (void)resetCell;
- (void)hidenRightRowImav;
@end
