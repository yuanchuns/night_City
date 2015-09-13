//
//  T2TBtnActionSheet.m
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TBtnActionSheet.h"

@interface T2TBtnActionSheet ()
{
    NSArray *_arrTitles;
    NSString *_title;
    T2TLabel *_lblTitle;
}

@end

@implementation T2TBtnActionSheet
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithTitles:(NSArray *)arrTitles{
    
    return [self initWithTitle:nil btnTitles:arrTitles];
    
}

-(id)initWithTitle:(NSString *)title btnTitles:(NSArray *)arrTitles{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        _arrTitles = arrTitles;
        _title = title;
        [self initialize];
        [self loadContent];
        
    }
    return self;
}

-(void)initialize{
    
    self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    
    _margin_top = 20;
    _margin_bottom = 20;
    _margin_cancelBtn = 20;
    _margin_x = 22;
    _margin_betweenBtns = 7;
    _btnSize = CGSizeMake(kScreenWidth-_margin_x*2, 45);
}

-(void)loadContent{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    
    __block float y = _margin_top;
    
    
    if ([_title isKindOfClass:[NSString class]]) {
        
        _lblTitle = [T2TLabel lblWithFram:CGRectMake(0, y, kScreenWidth, 14) textColor:btnTextColor str:_title font:@(14) align:NSTextAlignmentCenter];
        [self addSubview:_lblTitle];
        
        y += 30;
    }
    
    [_arrTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        
        T2TButton *btn = [T2TButton btnWithFrame:(CGRect){_margin_x,y,_btnSize} Img:nil title:obj target:self Action:@selector(btnAction:)];
        btn.index = idx;
        [T2TView setRoundCornerFor:btn radiu:4 bdColor:kLineColor bdW:0.5];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:19]];
        [btn setTitleColor:btnTextColor forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [self addSubview:btn];
        
        y += (_btnSize.height+_margin_betweenBtns);
        
    }];
    
    y -= _margin_betweenBtns;
    y += _margin_cancelBtn;
    
    T2TButton *btnCancel = [T2TButton btnWithFrame:(CGRect){_margin_x,y,_btnSize} Img:nil title:@"取消" target:self Action:@selector(btnCancelAction:)];
    [self addSubview:btnCancel];
    [T2TView setRoundCornerFor:btnCancel radiu:4 bdColor:kLineColor bdW:0.5];
    [btnCancel.titleLabel setFont:[UIFont systemFontOfSize:19]];
    [btnCancel setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [btnCancel setBackgroundColor:btnBackGroundColor];
    
    y += _margin_bottom+_btnSize.height;
    
    self.frame = CGRectMake(0, kApplicationHeight-y, kScreenWidth, y);
    
}


-(void)btnAction:(T2TButton *)aBtn{
    if (_blockBtnTapHandle) {
        
        _blockBtnTapHandle(aBtn.index);
    }
    [T2TModelView closeModelViewWithContentView:self];
}

-(void)btnCancelAction:(T2TButton *)sender{
    [T2TModelView closeModelViewWithContentView:self];
}

-(void)show{
    self.top = kApplicationHeight;
    [T2TModelView showInView:kCurrentWindow contentVIew:self editBgViewHandle:^(T2TModelBackGroudView *viewBg) {
        viewBg.blockCloseAnimate = ^{
            self.top = kApplicationHeight;
        };
    }];
    [UIView animateWithDuration:0.25 animations:^{
        self.bottom = kApplicationHeight;
        //self.bottom = kApplicationHeight;
    }];
    
}
@end
