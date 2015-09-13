//
//  EMineSeitchCell.h
//  Examda
//
//  Created by mark on 15/1/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const kEMineSeitchCellKey = @"EMineSeitchCell";
@interface EMineSeitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UISwitch *switchInfo;
-(void)setSwitchHandle:(T2TBOOLBlock)block;

@end
