//
//  SSTabBarController.h
//  SSNavTabDemo
//
//  Created by luoluo on 15/6/17.
//  Copyright © 2015年 长沙二三三网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTabBarImage : NSObject

- (id)initWithImageNames:(NSArray *)arrImageName;

//默认状态（未选中）图片
@property (nonatomic,readonly) NSString *imgDefault;
//选中状态图片
@property (nonatomic,readonly) NSString *imgSeleted;
//按下时高亮图片
@property (nonatomic,readonly) NSString *imgHighlighted;

@end

@interface SSTabBarController : UITabBarController

-(id)initWithViewControllers:(NSArray *)arrViewController imageArray:(NSArray *)arrImg titleArray:(NSArray *)arrTitle;

@end
