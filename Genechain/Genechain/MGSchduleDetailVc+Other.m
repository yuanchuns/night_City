//
//  MGSchduleDetailVc+Other.m
//  Genechain
//
//  Created by mark_zhang on 15/8/8.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSchduleDetailVc+Other.h"

@implementation MGSchduleDetailVc (Other)
- (NSString *)getFirstLineFirBoxStr{
    
    return [NSString stringWithFormat:@"类别：%@",self.detailModel.kindName];
}

- (NSString *)getFirstLineSecBoxStr{
    
    return [NSString stringWithFormat:@"城市：%@",self.detailModel.cityName];
}

- (NSString *)getSecondLineFirBoxStr{
    
    return [NSString stringWithFormat:@"公司：%@",self.detailModel.companyName];
}

- (NSString *)getSecondLineSecBoxStr{
   
    return [NSString stringWithFormat:@"部门：%@",self.detailModel.deptName];
}

- (NSString *)getThiredLineStr{
    
    if (self.detailModel.kind  != 3) {
    return @"";
    }
    return [NSString stringWithFormat:@"项目：%@",self.detailModel.projectName];
}

- (NSString *)getFourLineStr{
   
    NSString *str = @"";
    if (self.detailModel.kind == 2 || self.detailModel.kind == 3 ) {
        str= [NSString stringWithFormat:@"客户：%@", self.detailModel.clientName];
    }
    return str;
}

- (NSString *)getFiveLineStr{
    
    NSString *str = @"";
    if (self.detailModel.kind != 4) {
       str= [NSString stringWithFormat:@"任务说明：%@", self.detailModel.taskName];
    }else{
      str= [NSString stringWithFormat:@"任务说明：%@", self.detailModel.activityName];
    }
    return str;
}

- (NSString *)getSixLineFirBoxStr{

    if (!self.detailModel) {
        return @"";
    }
   return  [@"开始日:" stringByAppendingString:[[kUnNilStr(self.detailModel.startDate) componentsSeparatedByString:@" "] firstObject]];
}

- (NSString *)getSixLineSecBoxStr{
   
    return  [@"结束日:" stringByAppendingString:[[kUnNilStr(self.detailModel.endDate) componentsSeparatedByString:@" "] firstObject]];
}

- (CGFloat) getSecLineHeight{
    CGFloat firHeight = [T2TCommonAction heightFoStr:[self getFirstLineFirBoxStr] font:kCommonFont_28px width:(kScreenWidth-50)/2]+24;
    CGFloat secHeight = [T2TCommonAction heightFoStr:[self getFirstLineSecBoxStr] font:kCommonFont_28px width:(kScreenWidth-50)/2]+24;
    CGFloat height = MAX(firHeight, secHeight);
    
    return MAX(MgSchduleDetailCellHeight,height);

}

- (CGFloat) getThiredLineHeight{
    
    if (self.detailModel.kind != 3) {
        return 0;
    }
    CGFloat height = [T2TCommonAction heightFoStr:[self getThiredLineStr] font:kCommonFont_28px width:kScreenWidth-30]+24;
    return MAX(MgSchduleDetailCellHeight, height);

}

- (CGFloat) getFourLineHeight{
    if (self.detailModel.kind == 1 || self.detailModel.kind == 4) {
        return 0;
    }
    CGFloat height = [T2TCommonAction heightFoStr:[self getFourLineStr] font:kCommonFont_28px width:kScreenWidth-30]+24;
    return MAX(MgSchduleDetailCellHeight, height);
}

- (CGFloat) getFiveLineHeight{
    CGFloat height = [T2TCommonAction heightFoStr:[self getFiveLineStr] font:kCommonFont_28px width:kScreenWidth-30]+24;
    return MAX(MgSchduleDetailCellHeight, height);
}



@end
