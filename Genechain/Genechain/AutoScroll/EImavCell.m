//
//  EImavCell.m
//  Examda
//
//  Created by mark on 15/4/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EImavCell.h"
#import "MGHomeImaModel.h"
@implementation EImavCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

     if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
     {
         self.autoScr = [[EAutoScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 128) withArrIma:@[] withFentchBlock:^id(MGHomeImaModel *model) {
             return model.imgUrl;
         }];
        [self addSubview:self.autoScr];
         self.lblInfo = [T2TLabel lblWithFram:CGRectMake(0, 107, kScreenWidth, 21) textColor:[UIColor whiteColor] bgColor:RGB(66, 79, 88, 0.5) str:@"" font:kCommonFont_28px];
         [self addSubview:self.lblInfo];
         
         self.clipsToBounds = YES;
         self.control = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth-70, 112, 60, 8)];
         self.control.pageIndicatorTintColor = [UIColor whiteColor];
         self.control.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#121212"];
         [self addSubview:self.control];
     }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
