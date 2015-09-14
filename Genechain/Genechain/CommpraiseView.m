//
//  CommpraiseView.m
//  Genechain
//
//  Created by nextone on 15/9/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "CommpraiseView.h"
#define viewHeight 20
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
    UIImageView *imageViewFir =[[UIImageView alloc]initWithFrame:CGRectMake(BGview.width/2-20, 2,16, 16)];
    [imageViewFir setImage:[UIImage imageNamed:imgArr[0]]];
    [BGview addSubview:imageViewFir];
     UILabel *labelFir =[[UILabel alloc]initWithFrame:CGRectMake(imageViewFir.x +imageViewFir.width, 2, BGview.width-(imageViewFir.x+imageViewFir.width), 16)];
    labelFir.text = titleArr[0];
    labelFir.textColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    labelFir.font =[UIFont systemFontOfSize:10.0];
    [BGview addSubview:labelFir];
    [self addSubview:BGview];
    
    UIView *BGviewSec =[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-45)/6, 0, (kScreenWidth-45)/6, viewHeight)];
    UIImageView *imageViewSec =[[UIImageView alloc]initWithFrame:CGRectMake(BGviewSec.width/2-20, 2,16, 16)];
    [imageViewSec setImage:[UIImage imageNamed:imgArr[1]]];
    [BGviewSec addSubview:imageViewSec];
    UILabel *labelSec =[[UILabel alloc]initWithFrame:CGRectMake(imageViewSec.x +imageViewSec.width, 2, BGviewSec.width-(imageViewSec.x+imageViewSec.width), 16)];
    labelSec.text = titleArr[1];
    labelSec.textColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    labelSec.font =[UIFont systemFontOfSize:10.0];
    [BGviewSec addSubview:labelSec];
    [self addSubview:BGviewSec];

    
    UIView *BGviewThir =[[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-45)/6*2, 0,(kScreenWidth-45)/6, viewHeight)];
    UIImageView *imageViewThir =[[UIImageView alloc]initWithFrame:CGRectMake(BGview.width/2-20, 2,16, 16)];
    [imageViewThir setImage:[UIImage imageNamed:imgArr[2]]];
    [BGviewThir addSubview:imageViewThir];
    UILabel *labelThir =[[UILabel alloc]initWithFrame:CGRectMake(imageViewThir.x +imageViewThir.width, 2, BGviewThir.width-(imageViewThir.x+imageViewThir.width), 16)];
    labelThir.text = titleArr[2];
    labelThir.font =[UIFont systemFontOfSize:10.0];
    labelThir.textColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    [BGviewThir addSubview:labelThir];
    [self addSubview:BGviewThir];

    
}
@end
