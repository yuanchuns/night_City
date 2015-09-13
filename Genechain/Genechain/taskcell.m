//
//  taskcell.m
//  Genechain
//
//  Created by nextone on 15/9/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "taskcell.h"

@implementation taskcell

- (void)awakeFromNib {
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *consultCell = @"taskcell";
    taskcell *cell = [tableView dequeueReusableCellWithIdentifier:consultCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:consultCell owner:nil options:nil] firstObject];
    }
    
    return cell;
}
//amount = 20000;
//commissionFlag = 0;
//companyId = 7;
//companyName = "\U767e\U5e74\U4f18\U624d";
//deptId = 5;
//deptName = "\U4f0d\U7136\U56e2\U961f";
//endDate = "2015-06-16";
//finishFlag = 1;
//id = 3363;
//invoiceKind = 1;
//projectId = 1604;
//reportType = "\U4e2a\U4eba";
//scheduleId = 3453;
//sellCost = "<null>";
//sellPrice = "<null>";
//startDate = "2015-06-16";
//taskDays = 1;
//taskName = "\U9879\U76ee\U8c03\U7814";
//taskPersons = 0;
//taskType = "\U54a8\U8be2\U670d\U52a1";
//teacherPositon = "\U5357\U660c";
//testTool = 1;
-(void)drawRect:(CGRect)rect{
    self.taskLabel.text = [NSString stringWithFormat:@"（任务）%@",self.model.taskName];
    self.cityLabel.text = self.model.teacherPositon;
    self.taskVarityLabel.text = [NSString stringWithFormat:@"（任务类型）%@",self.model.taskType];
    self.taskCashLabel.text = [NSString stringWithFormat:@"实施金额 %@",self.model.amount];
    self.datelabel.text = [NSString stringWithFormat:@"（日期）%@~%@",self.model.startDate,self.model.endDate];
    self.timelabel.text =[NSString stringWithFormat:@"%@天",self.model.taskDays];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
