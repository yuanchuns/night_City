//
//  T2TCustomActionSheet.m
//  T2TBasicLib
//
//  Created by mark_zhang on 15/8/9.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TCustomActionSheet.h"
#import "T2TModelView.h"
@implementation T2TCustomActionSheet

-(id)init{
    self = [super initWithFrame:CGRectMake(0, kScreenHeight-260, kScreenWidth, 260)];
    if (self) {
        
    }
    return self;
}


-(void)showInView:(UIView *)aView{
    
    [T2TModelView showInView:kCurrentWindow contentVIew:self editBgViewHandle:^(T2TModelBackGroudView *viewBg) {
        
    }];
    
}


-(void)hide{
    [T2TModelView closeModelViewWithContentView:self];
}

-(void)dismissWithClickedButtonIndex:(NSUInteger)index animated:(BOOL)animate{
    [self hide];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
