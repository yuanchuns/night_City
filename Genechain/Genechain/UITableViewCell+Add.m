//
//  UITableViewCell+Add.m
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "UITableViewCell+Add.h"

@implementation UITableViewCell (Add)
- (void)adjustSeparator{

    if (kIsIOS8) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.preservesSuperviewLayoutMargins = NO;
    }
    self.separatorInset = UIEdgeInsetsZero;
}

@end
