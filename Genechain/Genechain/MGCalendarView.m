//
//  MGCalendarView.m
//  Genechain
//
//  Created by mark_zhang on 15/8/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGCalendarView.h"
#import "MGSchduleHelp.h"
#import "MGCalendarCell.h"
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
        self.tableView = [[UITableView alloc] initWithFrame:frame];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.tableView];
        
        self.tableView.rowHeight = 45;
        [self.tableView registerNibName:MGCalendarCellClassName forCellReuseIdentifier:MGCalendarCellClassName];
        
        self.curDate = [NSDate date];
        self.numDaysOfMonth = [self.curDate numberOfDaysInCurrentMonth];
        
    }
    return self;
}

- (void)setSelectedHandle:(calendarBlock)objBlock {

    self.objBlock = objBlock;
}

- (void)reloadDataWithDate:(NSDate *)date {

    self.curDate = date;
    self.numDaysOfMonth = [self.curDate numberOfDaysInCurrentMonth];
    self.selecedIndex = 0;
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.tableView reloadData];
    
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.numDaysOfMonth+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MGCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:MGCalendarCellClassName];
    [cell adjustSeparator];
    cell.lblText.font = kCommonFont_24px;
    cell.lblText.textColor = [UIColor blackColor];
    if (indexPath.row == 0) {
        cell.lblText.text = @"    上月";
    } else if (indexPath.row == self.numDaysOfMonth+1){
        cell.lblText.text = @"    下个月";
    } else {
    
        NSDateComponents *comms = [self.curDate CreateDateComponentsWithYMD];
        comms.day = indexPath.row;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *date = [calendar dateFromComponents:comms];
        NSDateComponents *newComms = [date CreateDateComponentsWithYMD];
        cell.lblText.text = [NSString stringWithFormat:@"    %ld日",newComms.day];
        //cell.lblText.text = [NSString stringWithFormat:@"%ld月%ld日",newComms.month,newComms.day];
        if (newComms.weekday == 1) {
            cell.lblText.textColor = MGSchduleTextColor_kind_4;
        } else if (newComms.weekday == 7) {
            cell.lblText.textColor = MGSchduleTextColor_kind_2;
        }
        
    }
    
    if (indexPath.row == self.selecedIndex) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDateComponents *comm = [self.curDate CreateDateComponentsWithYMD];
    if(indexPath.row == 0) {
        //点击上一个月
        comm.year = 0;
        comm.month = -1;
        comm.day = 0;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *newDate = [calendar dateByAddingComponents:comm toDate:self.curDate options:0];
        NSDateComponents *newComm = [newDate CreateDateComponentsWithYMD];
        NSString *dateUrl = [NSString stringWithFormat:@"%ld%02ld",newComm.year,newComm.month];
        (!self.objBlock) ?:self.objBlock(dateUrl,YES);
        [self reloadDataWithDate:newDate];

    } else if (indexPath.row == self.numDaysOfMonth + 1) {
        //点击下一个月
        comm.year = 0;
        comm.month = 1;
        comm.day = 0;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *newDate = [calendar dateByAddingComponents:comm toDate:self.curDate options:0];
        
        NSDateComponents *newComm = [newDate CreateDateComponentsWithYMD];
        NSString *dateUrl = [NSString stringWithFormat:@"%ld%02ld",newComm.year,newComm.month];
        (!self.objBlock) ?:self.objBlock(dateUrl,YES);
        [self reloadDataWithDate:newDate];
        
    } else {
     NSString *dateUrl = [NSString stringWithFormat:@"%ld%02ld%02ld",comm.year,comm.month,indexPath.row];
        self.selecedIndex = indexPath.row;
       (!self.objBlock) ?:self.objBlock(dateUrl,NO);
        [tableView reloadData];
        
    }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
