//
//  CommpraiseView.m
//  Genechain
//
//  Created by nextone on 15/9/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "CommpraiseView.h"
#define viewHeight 20

#define viewSize 13
#define Titlefont 9.0
@implementation CommpraiseView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)initImageViewArr:(NSMutableArray *)imgArr withTitleArr:(NSMutableArray *)titleArr{
    
    if (imgArr.count==0||titleArr.count==0)  return;
    
    UIView *BGview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth-45)/6, viewHeight)];
    UIImageView *imageViewFir =[[UIImageView alloc]initWithFrame:CGRectMake(BGview.width/2-20, 2,viewSize, viewSize)];
    [imageViewFir setImage:[UIImage imageNamed:imgArr[0]]];
    [BGview addSubview:imageViewFir];
     UILabel *labelFir =[[UILabel alloc]initWithFrame:CGRectMake(imageViewFir.x +imageViewFir.width+2, 2, BGview.width-(imageViewFir.x+imageViewFir.width), viewSize)];
    labelFir.text =[NSString stringWithFormat:@"%@",titleArr[0]];
    labelFir.textColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    labelFir.font =[UIFont systemFontOfSize:Titlefont];
    [BGview addSubview:labelFir];
    [self addSubview:BGview];
    
    UIView *BGviewSec =[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-45)/6, 0, (kScreenWidth-45)/6, viewHeight)];
    UIImageView *imageViewSec =[[UIImageView alloc]initWithFrame:CGRectMake(BGviewSec.width/2-20, 2,viewSize, viewSize)];
    [imageViewSec setImage:[UIImage imageNamed:imgArr[1]]];
    [BGviewSec addSubview:imageViewSec];
    UILabel *labelSec =[[UILabel alloc]initWithFrame:CGRectMake(imageViewSec.x +imageViewSec.width+2, 2, BGviewSec.width-(imageViewSec.x+imageViewSec.width), viewSize)];
    labelSec.text = [NSString stringWithFormat:@"%@",titleArr[1]];
    labelSec.textColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    labelSec.font =[UIFont systemFontOfSize:Titlefont];
    [BGviewSec addSubview:labelSec];
    [self addSubview:BGviewSec];

    
    UIView *BGviewThir =[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-45)/6*2, 0,(kScreenWidth-45)/6, viewHeight)];
    UIImageView *imageViewThir =[[UIImageView alloc]initWithFrame:CGRectMake(BGview.width/2-20, 2,viewSize, viewSize)];
    [imageViewThir setImage:[UIImage imageNamed:imgArr[2]]];
    [BGviewThir addSubview:imageViewThir];
    UILabel *labelThir =[[UILabel alloc]initWithFrame:CGRectMake(imageViewThir.x +imageViewThir.width+2, 2, BGviewThir.width-(imageViewThir.x+imageViewThir.width), viewSize)];
    labelThir.text = [NSString stringWithFormat:@"%@",titleArr[2]];
    labelThir.font =[UIFont systemFontOfSize:Titlefont];
    labelThir.textColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    [BGviewThir addSubview:labelThir];
    [self addSubview:BGviewThir];

    
}
@end
