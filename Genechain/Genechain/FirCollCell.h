//
//  FirCollCell.h
//  Genechain
//
//  Created by nextone on 15/9/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const MGHomeItemCellReuseRedifilerAndName = @"FirCollCell";

@interface FirCollCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UIImageView *VideoImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@end
