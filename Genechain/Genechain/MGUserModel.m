//
//  MGUserModel.m
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGUserModel.h"
#import "AESCrypt.h"
@implementation MGUserModel
+ (id)shareMGUserModel{

  static  dispatch_once_t once;
    static MGUserModel *model = nil;
    dispatch_once(&once, ^{
        model = [[[self class] alloc] init];
    });
    return model;
}

- (void)saveLoginUserName:(NSString *)userName pwd:(NSString *)pwd{

    [kUserDefaults setObject:kUnNilStr(userName) forKey:kMGLoginUserNameKey];
    [kUserDefaults setObject:kUnNilStr([AESCrypt encrypt:kUnNilStr(pwd) password:kMGPwdKey]) forKey:kMGPwdKey];
    [kUserDefaults synchronize];
}

- (NSString *)getPwd{

    if ([kUserDefaults objectForKey:kMGPwdKey]) {
        NSString *temp = [kUserDefaults objectForKey:kMGPwdKey];
        return [AESCrypt decrypt:temp password:kMGPwdKey];
    }
    return nil;
    
}

- (NSString *)getUserName{

    return [kUserDefaults objectForKey:kMGLoginUserNameKey];
}

- (void)saveUserInfoWithDic:(NSDictionary *)dicInfo{

    if (![dicInfo isKindOfClass:[NSDictionary class]]) {
        return;
    }
    self.loginName = dicInfo[@"loginName"];
    self.mail = dicInfo[@"mail"];
    self.mobile = dicInfo[@"mobile"];
    self.sessionId = dicInfo[@"sessionId"];
    self.userId = dicInfo[@"userId"];
    self.userName = dicInfo[@"userName"];
    [kUserDefaults setObject:dicInfo[@"loginName"] forKey:kMGLoginNameKey];
    [kUserDefaults setObject:dicInfo[@"sessionId"] forKey:kMGSessionIdKey];
    [kUserDefaults synchronize];
}

@end
