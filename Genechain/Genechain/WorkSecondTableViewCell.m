//
//  WorkSecondTableViewCell.m
//  Genechain
//
//  Created by nextone on 15/8/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "WorkSecondTableViewCell.h"

@implementation WorkSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *consultCell = @"WorkSecondTableViewCell";
    WorkSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:consultCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:consultCell owner:nil options:nil] firstObject];
    }
    
    return cell;
}

+(CGFloat )getCellHeigth:(workModeSecond *)model{
    NSString *str4 =[NSString stringWithFormat:@"[客户]%@",model.clientName];
    NSString *str5 =[NSString stringWithFormat:@"[项目]%@",model.projectName];
    NSString *str6=[NSString stringWithFormat:@"[任务]%@",model.taskName];
    CGSize size4 =[[WorkSecondTableViewCell alloc]sizeWithString:str4 font:[UIFont systemFontOfSize:14.0]];
    CGSize size5 =[[WorkSecondTableViewCell alloc]sizeWithString:str5 font:[UIFont systemFontOfSize:14.0]];
    CGSize size6 =[[WorkSecondTableViewCell alloc]sizeWithString:str6 font:[UIFont systemFontOfSize:14.0]];

    return size4.height+size5.height+size6.height+70;
}
+(CGFloat )BookGetCellHeigth:(bookModeFinish *)model{
    NSString *str1 =[NSString stringWithFormat:@"[教具]%@",model.toolsName];;
    NSString *str4= [NSString stringWithFormat:@"[客户]%@",model.clientName];
    NSString *str5 =[NSString stringWithFormat:@"[项目]%@",model.projectName];
    NSString *str6 =[NSString stringWithFormat:@"[任务]%@",model.taskName];
    CGSize size1 =[[WorkSecondTableViewCell alloc]sizeWithString:str1 font:[UIFont systemFontOfSize:14.0]];
    CGSize size4 =[[WorkSecondTableViewCell alloc]sizeWithString:str4 font:[UIFont systemFontOfSize:14.0]];
    CGSize size5 =[[WorkSecondTableViewCell alloc]sizeWithString:str5 font:[UIFont systemFontOfSize:14.0]];
    CGSize size6 =[[WorkSecondTableViewCell alloc]sizeWithString:str6 font:[UIFont systemFontOfSize:14.0]];
    return size1.height+size4.height+size5.height+size6.height+40;
}

- (void)setUivalueWithModel:(workModeSecond *)model{
    self.labelOne = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth/3, 20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        if ([model.subjectId integerValue]==23) {
            label.text = [NSString stringWithFormat:@"[火车]%@",model.passengerName];
        }else if ([model.subjectId integerValue]==7 ){
            label.text = [NSString stringWithFormat:@"[飞机]%@",model.passengerName];
        }else if([model.subjectId integerValue]==26){
            label.text = [NSString stringWithFormat:@"[酒店]%@",model.passengerName];
        }
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        if ([model.subjectId integerValue]==23) {
            label.textColor=[UIColor  greenColor];
            
        }else if ([model.subjectId integerValue]==7 ){
            
            label.textColor=[UIColor  redColor];
            
        }else if([model.subjectId integerValue]==26){
            
            label.textColor=[UIColor  blueColor];
            
        }
        [self.contentView  addSubview:label];
        label;
    });
    
    UILabel *labelOneSub = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, 5, kScreenWidth/3, 20)];
    labelOneSub.textColor =[UIColor colorWithHexString:@"#666666"];
    labelOneSub.text = [NSString stringWithFormat:@"%@",model.flight];
    labelOneSub.backgroundColor = [UIColor clearColor];
    labelOneSub.textAlignment = NSTextAlignmentCenter;
    labelOneSub.font = [UIFont systemFontOfSize:14];
    labelOneSub.numberOfLines=0;
    [self.contentView  addSubview:labelOneSub];
    
    
    UILabel *labelTowSub = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*2-10, 5, kScreenWidth/3-5, 20)];
    labelTowSub.textColor =[UIColor colorWithHexString:@"#666666"];
    labelTowSub.text = [NSString stringWithFormat:@"%@-%@",model.fromCity,model.toCity];
    labelTowSub.backgroundColor = [UIColor clearColor];
    labelTowSub.textAlignment = NSTextAlignmentRight;
    labelTowSub.font = [UIFont systemFontOfSize:14];
    labelTowSub.numberOfLines=0;
    [self.contentView  addSubview:labelTowSub];
    
    self.labelTow = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labelOne.y+self.labelOne.height+10, kScreenWidth-10, 20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text =[NSString stringWithFormat:@"(金额)：%@",model.price];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView  addSubview:label];
        label;

        });
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, self.labelOne.y+self.labelOne.height+10, kScreenWidth/2-10, 20)];
    label.textColor =[UIColor colorWithHexString:@"#666666"];
    label.text =[NSString stringWithFormat:@"发生日期：%@",model.departDate];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView  addSubview:label];

    
    
    self.labelThree = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labelTow.y+self.labelTow.height+10, kScreenWidth/2-10, 20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"(定票人)：%@",model.employeeName];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView  addSubview:label];
        label;

        });
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, self.labelTow.y+self.labelTow.height+10, kScreenWidth/2-10, 20)];
    label2.textColor =[UIColor colorWithHexString:@"#666666"];
    label2.text = [NSString stringWithFormat:@"出票日期：%@",model.printDate];
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentRight;
    label2.font = [UIFont systemFontOfSize:14];
    [self.contentView  addSubview:label2];

       
    
    self.labelFour = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"[客户]：%@",model.clientName];
        label.size =  [self sizeWithString:label.text font:[UIFont systemFontOfSize:14]];
        label.backgroundColor = [UIColor clearColor];
        label.x = 10;
        label.y= self.labelThree.y+self.labelThree.height+10;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });
    self.labelFive = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"[项目]：%@",model.projectName];
        label.size =  [self sizeWithString:label.text font:[UIFont systemFontOfSize:14]];
        label.backgroundColor = [UIColor clearColor];
        label.x = 10;
        label.y= self.labelFour.y+self.labelFour.height+10;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });
    
    
    self.labelSex = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"[任务]：%@",model.taskName];
        label.size =  [self sizeWithString:label.text font:[UIFont systemFontOfSize:14]];
        label.backgroundColor = [UIColor clearColor];
        label.x = 10;
        label.y= self.labelFive.y+self.labelFive.height+10;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });

}

//clientId = "<null>";
//clientName = "\U767e\U5ea6\U6280\U672f\U5b66\U9662";
//comments = "\U9879\U76ee";
//companyId = "<null>";
//createDate = 20150627233315;
//createUser = "\U7ba1\U7406\U5458";
//deleteFlag = 0;
//employeeName = "\U738b\U91d1";
//employeeNo = wangjin2014;
//expenseId = 16860;
//expressAmount = 37;    快递费 
//flag = 2;
//id = 155;
//leaveDate = "1900-01-01";
//projectId = "<null>";
//projectName = "\U57f9\U8bad\U6846\U67b6\U534f\U8bae";
//taskId = "<null>";
//taskName = "\U6fc0\U52b1\U8bfe\U7a0b\U6388\U8bfe";
//toolsAmount = 0;        教具费
//toolsName = "\U5feb\U9012\U300a\U6fc0\U52b1\U300b\U5b8b\U6e58\U751f\U5b66\U5458\U624b\U518c";
//updateDate = 20150629093642;
//updateUser = "\U738b\U91d1";

- (void)BookModeSetUivalueWithModel:(bookModeFinish *)model{
    self.labelOne = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"[教具内容]%@",model.toolsName];
        label.size =  [self sizeWithString:label.text font:[UIFont systemFontOfSize:14]];
        label.backgroundColor = [UIColor clearColor];
        label.textColor =[UIColor redColor];
        label.x = 10;
        label.y= 5;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });
    
    self.labelTow = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labelOne.y+self.labelOne.height+10, kScreenWidth/2-10, 20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"教具费：%@",model.expressAmount];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView  addSubview:label];
        label;
        });
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, self.labelOne.y+self.labelOne.height+10, kScreenWidth/2-10, 20)];
    label.textColor =[UIColor colorWithHexString:@"#666666"];
    label.text = [NSString stringWithFormat:@"快递费：%@ ",model.expressAmount];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView  addSubview:label];

    
    self.labelThree = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labelTow.y+self.labelTow.height+10, kScreenWidth/2-10, 20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"领用人：%@",model.leaveDate];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView  addSubview:label];
        label;

        });
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, self.labelTow.y+self.labelTow.height+10, kScreenWidth/2-10, 20)];
    label2.textColor =[UIColor colorWithHexString:@"#666666"];
    label2.text = [NSString stringWithFormat:@"领用日：%@",model.leaveDate];
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentRight;
    label2.font = [UIFont systemFontOfSize:14];
    [self.contentView  addSubview:label2];

    self.labelFour = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"[客户]：%@",model.clientName];
        label.size =  [self sizeWithString:label.text font:[UIFont systemFontOfSize:14]];
        label.backgroundColor = [UIColor clearColor];
        label.x = 10;
        label.y= self.labelThree.y+self.labelThree.height+10;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });
    self.labelFive = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"[项目]：%@",model.projectName];
        label.size =  [self sizeWithString:label.text font:[UIFont systemFontOfSize:14]];
        label.backgroundColor = [UIColor clearColor];
        label.x = 10;
        label.y= self.labelFour.y+self.labelFour.height+10;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });
    
    
    self.labelSex = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"[任务]：%@",model.taskName];
        label.size =  [self sizeWithString:label.text font:[UIFont systemFontOfSize:14]];
        label.backgroundColor = [UIColor clearColor];
        label.x = 10;
        label.y= self.labelFive.y+self.labelFive.height+10;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });
    
}
-(void)drawRect:(CGRect)rect
{
    
    
    
}
// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kScreenWidth-20, 8000)
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}                                       context:nil];
    return rect.size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
