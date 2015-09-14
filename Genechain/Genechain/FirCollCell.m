//
//  FirCollCell.m
//  Genechain
//
//  Created by nextone on 15/9/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "FirCollCell.h"
#import "CommpraiseView.h"
@implementation FirCollCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorWithRed:0.16f green:0.18f blue:0.20f alpha:1.00f];
    
}
-(void)drawRect:(CGRect)rect{
    NSMutableArray *imageArr =[NSMutableArray arrayWithObjects:@"gift_num",@"play_num",@"recome_num", nil];
    NSMutableArray *TitleArr =[NSMutableArray arrayWithObjects:@"123",@"123",@"123", nil];
    CommpraiseView *comm =[[CommpraiseView alloc]initWithFrame:CGRectMake(self.VideoImage.x, self.VideoImage.height+self.VideoImage.y+5, kScreenWidth-10, 20)];
    comm.backgroundColor = [UIColor clearColor];
    [comm initImageViewArr:imageArr  withTitleArr:TitleArr];
    [self addSubview:comm];

    
}
@end
