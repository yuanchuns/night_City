//
//  MGCalendarView.h
//  Genechain
//
//  Created by mark_zhang on 15/8/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^calendarBlock)(NSString *calendarStr,BOOL isMonth);

@interface MGCalendarView : UIView
- (void)setSelectedHandle:(calendarBlock)objBlock;
@end
