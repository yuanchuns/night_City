//
//  T2TTableViewCell.h
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T2TTableViewCell : UITableViewCell
@property (nonatomic,assign,readonly) float contentWidth;

@property (nonatomic,strong) UIView *separatorView; //默认的分隔线


//重新设定ImageView的位置大小
-(void)setImageViewFrame:(CGRect)rect;
//重新设定textLable的位置大小
-(void)setTextLableFrame:(CGRect)rect;
//重新设定DetailLable的位置大小
-(void)setDetailLableFrame:(CGRect)rect;
//设置分隔线的宽度
-(void)setSeparatorViewWidth:(float)width;
//自定义分隔线 大小由传入的视图决定，位置为系统分隔线的位置
-(void)setCustomSeparatorView:(UIView *)aView;
//设置contentView的边缘
-(void)setContentEdge:(UIEdgeInsets)edge;

-(void)clear;
@end
