//
//  NSDate+TCategory.h
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TCategory)
/**
 *  判断date当月总天数
 *
 *  @return 天数
 */
-(NSUInteger)numberOfDaysInCurrentMonth;


//确定这个月的第一天是星期几。这样就能知道给定月份的第一周有几天：（星期天表示第一天）
/**
 *  date当月第一天的date
 *
 *  @return 第一天的date
 */
- (NSDate *)firstDayOfCurrentMonth;

/**
 *  判断date是当月第一周还剩下几天
 *
 *  @return 剩下的天数
 */
- (NSUInteger)weeklyOrdinality;

/**
 *  判断date是这个月的第几周
 *
 *  @return 第几周数
 */
- (NSUInteger)dayIntweekDay;

/**
 *  获取date当月的总周数
 *
 *  @return <#return value description#>
 */
- (NSUInteger)numberOfWeeksInCurrentMonth;


/**
 *  判断是否是同一天
 *
 *  @param date 比较的date
 *
 *  @return yes表示是同一天 no表示不是同一天（指的是年月日相同）
 */
-(BOOL)isSameDay:(NSDate *)date;

/**
 *  判断是否年月相同
 *
 *  @param date 比较的date
 *
 *  @return yes表示是同一天 no表示不是同一天（指的是年月日相同）
 */
-(BOOL)isSameMonth:(NSDate *)date;
/**
 *  将date转化为NSDateComponents
 *
 *  @return 返回NSDateComponents
 */
-(NSDateComponents *)CreateDateComponentsWithYMD;

@end
