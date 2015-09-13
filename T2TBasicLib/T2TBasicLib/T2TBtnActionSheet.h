//
//  T2TBtnActionSheet.h
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "T2TBasicLib.h"

#define btnTextColor [UIColor colorWithHexString:@"#000000"]
#define btnBackGroundColor [UIColor colorWithHexString:@"#999999"]
@interface T2TBtnActionSheet : UIView
@property (nonatomic,assign) float margin_top;//上边距
@property (nonatomic,assign) float margin_x;//左边距
@property (nonatomic,assign) float margin_betweenBtns;//间距
@property (nonatomic,assign) float margin_bottom;//下边距
@property (nonatomic,assign) float margin_cancelBtn;//
@property (nonatomic,assign) CGSize btnSize;//按钮的size
@property (nonatomic,strong) T2TIndexBlock blockBtnTapHandle;

-(id)initWithTitles:(NSArray *)arrTitles;

-(id)initWithTitle:(NSString *)title btnTitles:(NSArray *)arrTitles;

-(void)show;
@end
