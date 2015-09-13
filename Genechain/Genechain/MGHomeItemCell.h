//
//  MGHomeItemCell.h
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const MGHomeItemCellReuseRedifilerAndName = @"MGHomeItemCell";
@interface MGHomeItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imavHead;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
