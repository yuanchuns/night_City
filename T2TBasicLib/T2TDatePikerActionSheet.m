//
//  T2TDatePikerActionSheet.m
//  T2TBasicLib
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TDatePikerActionSheet.h"
#import "Define_basic.h"
@implementation T2TDateObj



@end

@interface T2TDatePikerActionSheet(){
    
}

@property (nonatomic,strong) T2TDictionaryBlock block_selected;

@end

@implementation T2TDatePikerActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init{
    self = [super init];
    //    self.title = @"\n\n\n\n\n\n\n\n\n\n\n\n\n";
    if (self) {
        UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        navBar.tintColor = [UIColor blackColor];
        UINavigationItem *navitem = [[UINavigationItem alloc]initWithTitle:nil];
        
        UIBarButtonItem *item_ok = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(bbiOKAction:)];
        UIBarButtonItem *item_cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(bbiCancelAction:)];
        
        navitem.leftBarButtonItem = item_cancel;
        navitem.rightBarButtonItem = item_ok;
        navBar.items = [NSArray arrayWithObjects:navitem, nil];
        
        [self addSubview:navBar];
        
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.maximumDate = [NSDate date];
        
        self.format = [[NSDateFormatter alloc]init];
        [self.format setDateFormat:@"yyyy-MM-dd"];
        _datePicker.minimumDate = [self.format dateFromString:@"2000-01-01"];
        _datePicker.maximumDate = [self.format dateFromString:@"2030-12-31"];
        [self addSubview:_datePicker];
        
        UIView *bg = [[UIView alloc]initWithFrame:_datePicker.frame];
        bg.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [self insertSubview:bg belowSubview:_datePicker];
    }
    return self;
}

-(void)bbiCancelAction:(UIBarButtonItem *)sener{
    [self dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)bbiOKAction:(UIBarButtonItem *)sener{
    
    NSDate *date = _datePicker.date;
    NSString *strDate = [self.format stringFromDate:_datePicker.date];
    double interVal = [date timeIntervalSince1970];
    if (self.block_selected) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:strDate,kDateStrKey, nil];
        self.block_selected(dic);
    }
    if (self.blockSelectedWithDateObj) {
        T2TDateObj *obj = [[T2TDateObj alloc]init];
        obj.dateStr = strDate;
        obj.timeInterval = interVal;
        self.blockSelectedWithDateObj(obj);
    }
    [self dismissWithClickedButtonIndex:0 animated:YES];
}


-(void)datePickerValuesChangeACtion:(UIDatePicker *)sender{
    
    //    if (self.block_selected) {
    ////        NSDateFormatter *format = [[NSDateFormatter alloc]init];
    ////        [format setDateFormat:@"yyyy-MM-dd"];
    ////        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[format stringFromDate:sender.date],kDateStrKey, nil];
    //
    //        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self.format stringFromDate:sender.date],kDateStrKey, nil];
    //        self.block_selected(dic);
    //    }
    
    
    
    //    self.theAccount.account_buydate = [format stringFromDate:sender.date];
    //
    //    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:5 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)setSelectedBlock:(T2TDictionaryBlock)block{
    self.block_selected = block;
    
}

-(void)setNOMaxDate{
    _datePicker.maximumDate = nil;
}
@end
