//
//  T2TTableViewCell.m
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TTableViewCell.h"
#import "T2TBasicLib.h"
@interface T2TTableViewCell (){
    CGRect _rectImageView; //ImageView的位置大小
    CGRect _rectTitleLable;  //TextLable的位置大小
    CGRect _rectDetailLable; //DetailLable的位置大小
    
    float _widthSeparator;    //分隔线宽度
    CGRect _rectSeparatorView; //分隔线位置大小
    
    UIView *_customSeparatorView; //自定义的分隔线
    
    UIEdgeInsets _edgeContent; //设置contentVIew的边缘
}



@end

@implementation T2TTableViewCell
-(void)dealloc{
    _customSeparatorView = nil;
    self.imageView.image = nil;
    [self clear];
}

-(void)clear{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [(UIImageView *)subView setImage:nil];
        }
        [subView removeFromSuperview];
    }];
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [(UIImageView *)subView setImage:nil];
        }
        [subView removeFromSuperview];
    }];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _edgeContent = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark -


/*
 在该方法里重设默认UI的位置大小，并有自定义分隔线则添加自定义分隔线，并隐藏默认分隔线
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentView setFrame:CGRectMake(_edgeContent.left, _edgeContent.top, self.width-_edgeContent.left-_edgeContent.right, self.height-_edgeContent.top-_edgeContent.bottom)];
    
    if (!CGRectIsEmpty(_rectImageView)) {
        [self.imageView setFrame:_rectImageView];
    }
    if (!CGRectIsEmpty(_rectTitleLable)) {
        [self.textLabel setFrame:_rectTitleLable];
    }
    if (!CGRectIsEmpty(_rectDetailLable)) {
        [self.detailTextLabel setFrame:_rectDetailLable];
    }
    //    if (!CGRectIsEmpty(_rectSeparatorView)) {
    //        [self.separatorView setFrame:_rectSeparatorView];
    //    }
    if (!CGRectIsEmpty(_rectSeparatorView) || _widthSeparator>0.0) {
        if (CGRectIsEmpty(_rectSeparatorView)) {
            if ([self.separatorView isKindOfClass:[UIView class]]) {
                CGRect rect = self.separatorView.frame;
                rect.origin.x = (self.width-_widthSeparator)/2;
                rect.size.width = _widthSeparator;
                _rectSeparatorView = rect;
            }else{
                if (self.separatorView) {
                    NSString *strErr = [NSString stringWithFormat:@"separatorView is not a view! separatorView:%@ cell:%@",self.separatorView.description,self.description];
                    [TLog logErrorInfo:strErr];
                }
                
            }
        }
        
        [self.separatorView setFrame:_rectSeparatorView];
    }
    
    if (_customSeparatorView) {
        CGRect rect = self.separatorView.frame;
        rect.origin.y -= (CGRectGetHeight(_customSeparatorView.frame)-rect.size.height);
        rect.size.height = CGRectGetHeight(_customSeparatorView.frame);
        _customSeparatorView.frame = rect;
        self.separatorView.hidden = YES;
        [self addSubview:_customSeparatorView];
    }
    
}

#pragma mark - 接口方法

-(void)setImageViewFrame:(CGRect)rect{
    _rectImageView = rect;
    [self reloadInputViews];
}

-(void)setTextLableFrame:(CGRect)rect{
    _rectTitleLable = rect;
    [self reloadInputViews];
}

-(void)setDetailLableFrame:(CGRect)rect{
    _rectDetailLable = rect;
    [self reloadInputViews];
}

-(void)setSeparatorViewWidth:(float)width{
    
    _widthSeparator = width;
    
}

-(void)setCustomSeparatorView:(UIView *)aView{
    _customSeparatorView = aView;
}

-(void)setContentEdge:(UIEdgeInsets)edge{
    _edgeContent = edge;
    _widthSeparator = self.contentWidth;
    [self reloadInputViews];
}

#pragma mark - getter 方法

-(UIView *)separatorView{
    if (!_separatorView) {
        //        [self layoutIfNeeded];
        _separatorView = [self subViewOfContainDescription:@"UITableViewCellSeparatorView"];
    }
    return _separatorView;
}

-(float)contentWidth{
    return self.width-_edgeContent.left-_edgeContent.right;
}

@end
