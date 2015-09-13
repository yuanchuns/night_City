//
//  WorkTableViewCell.m
//  Genechain
//
//  Created by nextone on 15/8/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "WorkTableViewCell.h"
@implementation WorkTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *consultCell = @"WorkTableViewCell";
    WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:consultCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:consultCell owner:nil options:nil] firstObject];
    }
    
    return cell;
}
+(CGFloat )getCellHeigth:(workMode *)model{
//    NSString *str1 =[NSString stringWithFormat:@"[火车]%@         %@            %@-%@ ",model.passengerName,model.flight,model.fromCity,model.toCity];
//    CGSize size1 =[[WorkTableViewCell alloc]sizeWithString:str1 font:[UIFont systemFontOfSize:14.0]];
    return 60;
}
+(CGFloat )BookGetCellHeigth:(bookMode *)model{
    NSString *str1 =[NSString stringWithFormat:@"[教具]%@",model.toolsName];;
    CGSize size1 =[[WorkTableViewCell alloc]sizeWithString:str1 font:[UIFont systemFontOfSize:14.0]];
    return size1.height+40;
}

- (void)setUivalueWithModel:(workMode *)model{
    
    
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
        //label.size =  [self sizeWithStringOne:label.text font:[UIFont systemFontOfSize:14]];
        label.backgroundColor = [UIColor clearColor];
        //label.x = 10;
        //label.y= 5;
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
    //labelOneSub.size =  [self sizeWithStringOne:labelOneSub.text font:[UIFont systemFontOfSize:14]];
    labelOneSub.backgroundColor = [UIColor clearColor];
    //labelOneSub.x =kScreenWidth/3-10;
    //labelOneSub.y= 5;
    labelOneSub.textAlignment = NSTextAlignmentCenter;
    labelOneSub.font = [UIFont systemFontOfSize:14];
    labelOneSub.numberOfLines=0;
    [self.contentView  addSubview:labelOneSub];
    
    
    UILabel *labelTowSub = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*2-10, 5, kScreenWidth/3-5, 20)];
    labelTowSub.textColor =[UIColor colorWithHexString:@"#666666"];
    labelTowSub.text = [NSString stringWithFormat:@"%@-%@",model.fromCity,model.toCity];
    //labelTowSub.size =  [self sizeWithStringOne:labelTowSub.text font:[UIFont systemFontOfSize:14]];
    labelTowSub.backgroundColor = [UIColor clearColor];
    //labelTowSub.x = kScreenWidth/3*2-10;
    //labelTowSub.y= 5;
    labelTowSub.textAlignment = NSTextAlignmentRight;
    labelTowSub.font = [UIFont systemFontOfSize:14];
    labelTowSub.numberOfLines=0;
    [self.contentView  addSubview:labelTowSub];

        
    
    
    self.labelTow = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labelOne.y+self.labelOne.height+10, kScreenWidth/2-10,20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text =[NSString stringWithFormat:@"(金额)：%@",model.price];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, self.labelOne.y+self.labelOne.height+10, kScreenWidth/2-10,20)];
    label.textColor =[UIColor colorWithHexString:@"#666666"];
    label.text =[NSString stringWithFormat:@"发生日期：%@",model.departDate];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines=0;
    [self.contentView  addSubview:label];
    
    
    self.labelThree = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labelTow.y+self.labelTow.height+10, kScreenWidth/2-10,20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"(定票人)：%@",model.employeeName];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
        });
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, self.labelTow.y+self.labelTow.height+10, kScreenWidth/2-10,20)];
    label2.textColor =[UIColor colorWithHexString:@"#666666"];
    label2.text = [NSString stringWithFormat:@"出票日期：%@",model.printDate];
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentRight;
    label2.font = [UIFont systemFontOfSize:14];
    label2.numberOfLines=0;
    [self.contentView  addSubview:label2];

    
}
//comments = "SPOT\U56e2\U961f\U5f15\U5bfc\U5de5\U4f5c\U574a";
//companyId = "<null>";
//employeeName = "\U5b8b\U6668\U9633";
//employeeNo = "<null>";
//expressAmount = 0;
//flag = 1;
//id = 147;
//leaveDate = "2015-03-15";
//toolsAmount = 926;
//toolsName = "SPOT\U56e2\U961f\U5f15\U5bfc\U5de5\U4f5c\U574a";
- (void)BookModeSetUivalueWithModel:(bookMode *)model{
    
    self.labelOne = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"[教具]%@",model.toolsName];
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
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labelOne.y+self.labelOne.height+10, kScreenWidth/2-10,20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text =[NSString stringWithFormat:@"教具费：%@",model.toolsAmount];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;
    });
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, self.labelOne.y+self.labelOne.height+10, kScreenWidth/2-10,20)];
    label.textColor =[UIColor colorWithHexString:@"#666666"];
    label.text =[NSString stringWithFormat:@"(快递费)：%@",model.expressAmount];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines=0;
    [self.contentView  addSubview:label];
    
    
    
    self.labelThree = ({
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labelTow.y+self.labelTow.height+10, kScreenWidth/2-10,20)];
        label.textColor =[UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"(领用人)：%@",model.leaveDate];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines=0;
        [self.contentView  addSubview:label];
        label;

        });
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, self.labelTow.y+self.labelTow.height+10, kScreenWidth/2-10,20)];
    label2.textColor =[UIColor colorWithHexString:@"#666666"];
    label2.text = [NSString stringWithFormat:@"领用日期：%@",model.leaveDate];
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentRight;
    label2.font = [UIFont systemFontOfSize:14];
    label2.numberOfLines=0;
    [self.contentView  addSubview:label2];

    
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
