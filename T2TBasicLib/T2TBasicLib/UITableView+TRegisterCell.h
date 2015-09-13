//
//  UITableView+set.h
//  HouseKeeper
//
//  Created by to on 14-7-16.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (TRegisterCell)

//注册名字为nibName的xib
- (void)registerNibName:(NSString *)nibName forCellReuseIdentifier:(NSString *)identifier;

//Cell的样式默认为UITableViewCellStyleDefault
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                         initWithClass:(Class)cellClass;

//在UITableView寻找identifier标签的Cell，若没有则创建类名为class的Cell
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                   initWithClass:(Class)cellClass
                                                 Style:(UITableViewCellStyle)style;

//在UITableView寻找identifier标签的Cell，若没有则创建类名为classString的Cell
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                   initWithClassString:(NSString *)classString
                                                 Style:(UITableViewCellStyle)style;

//Cell的样式默认为UITableViewCellStyleDefault
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                   initWithClassString:(NSString *)classString;

@end
