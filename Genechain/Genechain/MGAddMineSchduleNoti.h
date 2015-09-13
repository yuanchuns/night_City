//
//  MGAddMineSchduleNoti.h
//  Genechain
//
//  Created by mark_zhang on 15/8/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"
#import "MGMangerSchduleModel.h"
static NSString *const alertBodyKey = @"alertBody";
@interface MGAddMineSchduleNoti : T2TObject
+ (void)addLocationNotiWithId:(int)schduleId userInfo:(MGMangerSchduleModel *)model date:(NSDate *)date finishBlock:(T2TBOOLBlock)finishBlock;
@end
