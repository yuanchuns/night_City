//
//  EAutoScrollView.h
//  Examda
//
//  Created by mark on 15/4/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EAutoScrollView <NSObject>

@optional

-(void)tapIndex:(NSUInteger)index;

@end

@interface EAutoScrollView : UIView
@property (nonatomic,weak) id<EAutoScrollView> delegate;
-(instancetype)initWithFrame:(CGRect)frame withArrIma:(NSArray *)arrIma withFentchBlock:(TReturnObjectWithOtherObjectBlock)fentchBlock;

-(void)setScorllIndexBlock:(T2TIndexBlock)indexBlock;
- (void)reloadBannerWithData:(NSArray *)images;
- (void)stopRolling;
- (void)startRolling;
@end

