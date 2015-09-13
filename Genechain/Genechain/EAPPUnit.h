//
//  ECheckAPPVersion.h
//  Examda
//
//  Created by luoluo on 15/1/29.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^completeCRequestBlock)(BOOL statues);

@interface EAPPUnit : NSObject
+ (void)autoCheckUpDataToView:(UIView *)view;
+ (void)autoCheckNetToView:(UIView *)view;
+ (void)giveMark;//去评分
+ (void)loginOut;//退出登录  清除cookie
+ (void)goToLogin:(UIViewController *)parentController success:(T2TBacsicBlock)success;//去登陆
+ (void)iSRepeatLogin:(completeCRequestBlock)block;//判断是否异地登录
+ (NSString *)freeSpace;//空余的内存空间
+ (NSString *)usedSpace;//已使用的内存空间
+ (void)openTel;//去拨号
+ (void)checkLoginInController:(UIViewController *)vc;//检测该页面是否已经登录
+ (NSString *)convertPrice:(NSNumber *)price;
@end
