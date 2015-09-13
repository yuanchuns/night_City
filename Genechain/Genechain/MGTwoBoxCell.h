//
//  MGTwoBoxCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const MGTwoBoxCellClassName = @"MGTwoBoxCell";
@interface MGTwoBoxCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewFirBackGround;
@property (weak, nonatomic) IBOutlet UIView *viewSecBackGround;
@property (weak, nonatomic) IBOutlet UILabel *lblFir;
@property (weak, nonatomic) IBOutlet UILabel *lblSec;
@property (weak, nonatomic) IBOutlet UIImageView *imavFir;
@property (weak, nonatomic) IBOutlet UIImageView *imavSec;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contImavOneWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contImavSecWidth;

- (void)hidenRightRowImav;
- (void)resetLblFir;
- (void)resetLblSec;
- (void)setLblFirPlahodler:(NSString *)plahodler;
- (void)setLblSecPlahodler:(NSString *)plahodler;
- (void)setLblFirHandle:(T2TBasicBlock)firBlock;
- (void)setLblSecHandle:(T2TBasicBlock)firBlock;
@end
