//
//  ECheckAPPVersion.m
//  Examda
//
//  Created by luoluo on 15/1/29.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#define APP_ID @"964104520"
#define AppUpdateURL @"http://itunes.apple.com/cn/lookup?id=%@"
#import "EAPPUnit.h"
#import "AFNetworkReachabilityManager.h"

@implementation EAPPUnit

+ (void)giveMark
{
    NSString *path = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APP_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
}

+ (void)autoCheckNetToView:(UIView *)view {
    NSString *path = [NSString stringWithFormat:kMGDefaultURL,kMGVersionUrl,[MGGetStatusDicHaveUserName() JSONString]];//检测appstore
    MGUserModel *model =     [MGUserModel shareMGUserModel];
    if (model.netTYpe == MGNetWorkNotType) {
        [T2TView showFailHUDWithText:TEXT_NETWORK_ERROR ];
    } else {
    
        if (view) {
         [MBProgressHUD showHUDAddedTo:kCurrentWindow animated:YES];
        }
        
        [T2THttpManager getWithUrl:path success:^(T2TResponse *responseObject) {
            [MBProgressHUD hideHUDForView:kCurrentWindow animated:YES];
            if (responseObject.code == kMGOkStatuCode && [responseObject.object isKindOfClass:[NSDictionary class]]) {
              NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
               NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
                int flag = [responseObject.object[@"mandatoryFlag"] intValue];
                NSString *netVersion = responseObject.object[@"version"];
                NSString *apkPath = responseObject.object[@"url"];
                
                if ([self getVersionNumber:netVersion] > [self getVersionNumber:currentVersion]) {
                    if (flag) {
                        //强制更新
                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:apkPath]];
                    } else {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"升级提示" message:@"\"百年基业\"有新版了，便于您的使用体验,请升级！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                        [alertView handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
                            if (btnIndex == 0) {
                                [alertView dismissWithClickedButtonIndex:0 animated:YES];
                            } else if (btnIndex == 1) {
                                //下载
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:apkPath]];
                            }
                        }];
                        [alertView show];
                    }
                } else {
                
                    [T2TView SHOWHUDWITHImgn:@"" test:@"当前版本为最新版"];
                }
                
            } else {
                if (view) {
                    [T2TView showFailHUDWithText:responseObject.reson];
                }
                
            }
            
        } failure:^(id error) {
            if(view){
            [T2TView showFailHUDWithText:@"更新失败"];
            }
            
        } otherHttpHeader:MGGetOtherHttpHear()];
    }

    
}
+ (void)autoCheckUpDataToView:(UIView *)view
{
    NSString *path = [NSString stringWithFormat:AppUpdateURL,APP_ID];//检测appstore
 MGUserModel *model =     [MGUserModel shareMGUserModel];
    if (model.netTYpe == MGNetWorkNotType) {
        [T2TView showFailHUDWithText:TEXT_NETWORK_ERROR ];
    } else {
        if (view) {
            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow  animated:YES];
        }
        [T2THttpManager getForOtherWithUrlStr:path parameter:nil success:^(id responseObject) {
            
            [MBProgressHUD hideHUDForView:view animated:YES];
            if (!responseObject) return ;

            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
            
            NSDictionary *rtnJsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (rtnJsonDic) {
                NSArray *results = [rtnJsonDic objectForKey:@"results"];
                NSDictionary *newDict = [results lastObject];
                NSString *version = [newDict objectForKey:@"version"];
                
                NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
                NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
                NSString *trackViewUrl = [newDict objectForKey:@"trackViewUrl"];
                NSLog(@"%@ %@",infoDict,[newDict objectForKey:@"trackViewUrl"]);
                if ([self getVersionNumber:version] > [self getVersionNumber:currentVersion]) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"升级提示" message:@"\"百年基业\"有新版了，便于您的使用体验,请升级！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                    [alertView handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
                        if (btnIndex == 0) {
                            [alertView dismissWithClickedButtonIndex:0 animated:YES];
                        } else if (btnIndex == 1) {
                            //下载
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];

                        }
                    }];
                    [alertView show];
                    
                }
                
            }
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            if (view) {
                [T2TView showFailHUDWithText:@"更新失败"];
            }
        }];

    }
    
}

+ (int)getVersionNumber:(NSString *)version
{
    NSArray * arr = [version componentsSeparatedByString:@"."];
    if (arr.count == 3) {
        NSString * a = [arr objectAtIndex:0];
        NSString * b = [arr objectAtIndex:1];
        NSString * c = [arr objectAtIndex:2];
        return a.intValue * 100 + b.intValue * 10 + c.intValue;
    } else if (arr.count == 2 ) {
        NSString * a = [arr objectAtIndex:0];
        NSString * b = [arr objectAtIndex:1];
        return a.intValue * 10 + b.intValue ;
    }
    else
        return 0;
}

+ (void)loginOut
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
    
//    [[EUserInfoManager shareInstance] cancelAuthor];
//    [[EUserInfoManager shareInstance] clearAllUserInfo];
//    [[NSNotificationCenter defaultCenter] postNotificationName:k_NOTI_LOGIN_OUT object:k_NOTI_LOGIN_OUT userInfo:nil];

}

+ (void)goToLogin:(UIViewController *)parentController success:(T2TBacsicBlock)success
{
    
    MGLoginVC *loginVc = [MGLoginVC getLoginVC];
    T2TNavController *loginNav = getNavWithVc(loginVc);
    [loginVc setLoginSuccessBlock:success];
    
    [parentController presentViewController:loginNav animated:YES completion:nil];
    
}






+ (void)iSRepeatLogin:(completeCRequestBlock)block
{
    [T2THttpManager getForOtherWithUrlStr:@"http://api.233.com/study/repeat" parameter:nil success:^(id responseObject) {
        if (!responseObject) return ;
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
        NSDictionary *rtnJsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if ([rtnJsonDic[@"code"] integerValue] == kMGOkStatuCode) {
            
            if (block) {
                block(NO);
            }
            
        } else {
            //异地登陆 掉线
            if (block) {
                block(YES);
            }

        }
        
    } failure:^(NSError *error) {
        
    }];

}

+ (NSString *)freeSpace
{
    NSDictionary *fileSysAttributes = [self fileSysAttributes];
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    return [NSString stringWithFormat:@"空闲%0.1fG",[freeSpace longLongValue]/1024.0/1024.0/1024.0];
    
}

+ (NSString *)usedSpace
{
    NSDictionary *fileSysAttributes = [self fileSysAttributes];
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    NSNumber *totalSpace = fileSysAttributes[NSFileSystemSize];
    long long usedSpace = [totalSpace longLongValue] - [freeSpace longLongValue];
    return [NSString stringWithFormat:@"已用%0.1fG",usedSpace/1024.0/1024.0/1024.0];
}

+ (NSDictionary *)fileSysAttributes
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    NSFileManager* fileManager = [[NSFileManager alloc ]init];
    
    return [fileManager attributesOfFileSystemForPath:path error:nil];
}




+ (void)openTel
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4000800233"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}

+ (void)checkLoginInController:(UIViewController *)vc
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录提示" message:@"请先登录！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
    [alert show];
    [alert handlerClickedButton:^(UIAlertView *alertView, NSInteger btnIndex) {
        if (btnIndex == 1) {
            MGLoginVC *login = [MGLoginVC getLoginVC];
            T2TNavController *nav = [[T2TNavController alloc] initWithRootViewController:login];
            [vc presentViewController:nav animated:YES completion:nil];
        }
    }];
}






+ (NSString *)convertPrice:(NSNumber *)price
{
    NSNumberFormatter *_priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_priceFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh"]];
    return [_priceFormatter stringFromNumber:price];
}

@end
