//
//  MGUserManger.h
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"
#import "MGUserModel.h"
@interface MGUserManger : T2TObject
+(void)loginWithUserName:(NSString *)userName psdStr:(NSString *)psdStr handleBlock:(T2TObjBlock)handleBlock;
@end
