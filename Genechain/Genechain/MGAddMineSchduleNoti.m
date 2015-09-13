//
//  MGAddMineSchduleNoti.m
//  Genechain
//
//  Created by mark_zhang on 15/8/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGAddMineSchduleNoti.h"

@implementation MGAddMineSchduleNoti
+ (void)addLocationNotiWithId:(int)schduleId userInfo:(MGMangerSchduleModel *)model date:(NSDate *)date finishBlock:(T2TBOOLBlock)finishBlock {
   
    if ([kUserDefaults objectForKey:kStrWithInter(schduleId)]) {
        (!finishBlock) ?: finishBlock(NO);
        return;
    }
    
    [kUserDefaults setObject:kStrWithInter(schduleId) forKey:kStrWithInter(schduleId)];
    [kUserDefaults synchronize];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if(kIsIOS8) {
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
            
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
            
        }
    }
    
    if (notification) {
        notification.fireDate = date;
        notification.repeatInterval = 0;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;
        notification.alertBody = [self getAlertBodyWithModel:model];
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:[model dicData]];
        [dicInfo setObject:[self getAlertBodyWithModel:model] forKey:alertBodyKey];
        notification.userInfo = [dicInfo copy];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        (!finishBlock) ?:finishBlock(YES);
        return;
    }
    
    (!finishBlock) ?:finishBlock(NO);
}

+ (NSString *)getAlertBodyWithModel:(MGMangerSchduleModel *)model {

    NSMutableString *strAlert = [NSMutableString stringWithFormat:@"%@ %@",model.startDate,model.startTime];
    switch (model.kind) {
        case 1:{
        [strAlert appendString:kUnNilStr(model.taskName)];
           
        }
            
            break;
        case 2:{
            [strAlert appendString:model.clientName];
            [strAlert appendString:model.taskName];
        }
            break;
        case 3:{
            [strAlert appendString:model.clientName];
            [strAlert appendString:model.projectName];
            [strAlert appendString:model.taskName];
        }
            break;
        case 4:{
            [strAlert appendString:model.activityName];
            [strAlert appendString:model.taskName];
        }
            break;
        default:{
        [strAlert appendString:kUnNilStr(model.taskName)];
        }
            break;
    }
     [strAlert appendString:@"时间到了"];
    return [strAlert copy];
}

@end
