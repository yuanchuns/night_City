//
//  MGLodingView.m
//  Genechain
//
//  Created by mark on 15/7/29.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGLodingView.h"


@interface MGLodingView ()
@property(nonatomic,strong)T2TBacsicBlock blockFresh;
@end

@implementation MGLodingView

+(void)changeLodingViewWithType:(lodingViewState)state withSuperView:(UIView *)view{
    MGLodingView *failView = (MGLodingView *)[view subViewOfClass:[MGLodingView class]];
    if ([failView isKindOfClass:[MGLodingView class]]) {
        if(state == lodingViewStateIsFailed){
            [failView.lodingView stopAnimation];
            failView.lblInfo.hidden = NO;
        }else{
            [failView.lodingView startAnimation];
            failView.lblInfo.hidden = YES;
            
        }
    }
}

+(void)showLodingViewOn:(UIView *)superView withEditBlock:(lodingViewBlock)Editblock withRefreshBlock:(T2TBacsicBlock)refreshblock{
    
    MGLodingView *failView = (MGLodingView *)[superView subViewOfClass:[MGLodingView class]];
    if (failView) {
        return;
    }
    MGLodingView *lodingView = [MGLodingView createLodingViewWithSuperView:superView withFreshBlock:refreshblock];
    if(Editblock)Editblock(lodingView);
}

+(void)removeFromSuperView:(UIView *)view{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[MGLodingView class]]) {
            [subView removeFromSuperview];
        }
    }
}

+(MGLodingView *)createLodingViewWithSuperView:(UIView *)superView withFreshBlock:(T2TBacsicBlock)block{
    
    MGLodingView *lodingView = [[MGLodingView alloc] initWithFrame:superView.bounds];
    lodingView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    
    lodingView.imavLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 195, 65)];
    
    CGPoint pt = lodingView.center;
    pt.y = (lodingView.height - image.size.height )/2.0 - 50;
    lodingView.imavLogo.center = pt;
    lodingView.imavLogo.image = image;
    [lodingView addSubview:lodingView.imavLogo];
    
    
    lodingView.lodingView = [[ECircleLoadingView alloc] initWithFrame:CGRectMake(lodingView.imavLogo.left + lodingView.width/2 - 70, lodingView.imavLogo.top+22, 20, 20)];
    
    [lodingView.lodingView startAnimation];
    [lodingView addSubview:lodingView.lodingView];
    
    
    lodingView.lblInfo = [T2TLabel lblWithFram:CGRectMake(0, lodingView.imavLogo.bottom+10, lodingView.width, 20) textColor:[UIColor colorWithHexString:@"#808080"] bgColor:[UIColor colorWithHexString:@"#f2f2f2"] str:@"点击屏幕重新加载" font:@(14)];
    lodingView.lblInfo.textAlignment = NSTextAlignmentCenter;
    lodingView.lblInfo.hidden = YES;
    [lodingView addSubview:lodingView.lblInfo];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:lodingView action:@selector(actionTap)];
    lodingView.blockFresh = block;
    [lodingView addGestureRecognizer:tap];
    
    [superView addSubview:lodingView];
    return lodingView;
}

-(void)actionTap{
    
    if (self.blockFresh) {
        self.blockFresh();
    }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
