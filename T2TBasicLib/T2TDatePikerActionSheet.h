//
//  T2TDatePikerActionSheet.h
//  T2TBasicLib
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TCustomActionSheet.h"
#import "T2TObject.h"
#import "Define_block.h"
#define kDateStrKey @"kDateStrKey"
@interface T2TDateObj :T2TObject
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,assign) double timeInterval;
@end

@interface T2TDatePikerActionSheet : T2TCustomActionSheet
//设置日期格式
@property (nonatomic,strong) NSDateFormatter *format;
//主要的UIDatePicker，可对其进行样式等设置
@property (nonatomic,readonly) UIDatePicker *datePicker;

@property (nonatomic,strong) T2TObjBlock blockSelectedWithDateObj;

//选择日期后的处理，返回包含日期字符串的key：kDateStrKey
-(void)setSelectedBlock:(T2TDictionaryBlock)block;
//设置不限定最大日期，默认为当天
-(void)setNOMaxDate;

@end
