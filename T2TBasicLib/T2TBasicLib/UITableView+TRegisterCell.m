//
//  UITableView+set.m
//  HouseKeeper
//
//  Created by to on 14-7-16.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import "UITableView+TRegisterCell.h"

@implementation UITableView (TRegisterCell)

- (void)registerNibName:(NSString *)nibName forCellReuseIdentifier:(NSString *)identifier
{
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identifier];
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                         initWithClass:(Class)cellClass
                                                 Style:(UITableViewCellStyle)style
{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:style reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                         initWithClass:(Class)cellClass
{
   UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier initWithClass:cellClass Style:UITableViewCellStyleDefault];
    
    return  cell;
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                   initWithClassString:(NSString *)classString
                                                 Style:(UITableViewCellStyle)style
{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSClassFromString(classString) alloc] initWithStyle:style reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSAssert(cell!=nil, @"className不存在");
    return cell;
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier  initWithClassString:(NSString *)classString
{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier initWithClassString:classString Style:UITableViewCellStyleDefault];
    return cell;
}

@end
