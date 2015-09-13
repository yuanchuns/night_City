//
//  MGCalendarCell.h
//  Genechain
//
//  Created by mark_zhang on 15/8/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *MGCalendarCellClassName = @"MGCalendarCell";
@interface MGCalendarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblText;

@end
