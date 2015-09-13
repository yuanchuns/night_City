//
//  YCButton.m
//  DoctorPlatForm
//
//  Created by nextone on 15/6/19.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "YCButton.h"

@implementation YCButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:14.0];
        self.imageView.contentMode=UIViewContentModeScaleToFill;
        
    }
    
    return self;
    
}

//更具button的rect设定并返回文本label的rect

- (CGRect)titleRectForContentRect:(CGRect)contentRect

{
    CGFloat titleW = contentRect.size.width;
    
    CGFloat titleH = 30;
    
    CGFloat titleX = 0;
    
    CGFloat titleY = 31;
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}



//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    
    //view.width/2-15, 10, 30, 30
    
    CGFloat imageW = 22;
    
    CGFloat imageH = 22;
    
    CGFloat imageX = contentRect.size.width/2-11;
    
    CGFloat imageY = 18;
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
    
}




@end
