//
//  MGCalendarView.m
//  Genechain
//
//  Created by mark_zhang on 15/8/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGCalendarView.h"
#import "MGSchduleHelp.h"
@interface MGCalendarView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDate *curDate;//缺省是当前的日期
@property (nonatomic, assign) NSInteger numDaysOfMonth;
@property (nonatomic, copy) calendarBlock objBlock;
@property (nonatomic, assign) NSInteger selecedIndex;
@end

@implementation MGCalendarView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
