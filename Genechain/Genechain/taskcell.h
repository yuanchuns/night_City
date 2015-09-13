//
//  taskcell.h
//  Genechain
//
//  Created by nextone on 15/9/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "workMode.h"
@interface taskcell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskVarityLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskCashLabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;

@property (weak, nonatomic) IBOutlet UILabel *taskLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)taskMode *model;
@end
