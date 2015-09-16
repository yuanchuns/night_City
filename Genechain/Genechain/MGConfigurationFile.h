//
//  MGConfigurationFile.h
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#ifndef Genechain_MGConfigurationFile_h
#define Genechain_MGConfigurationFile_h

#import "MGUserModel.h"
#import "EAPPUnit.h"
#define TEXT_NETWORK_ERROR @"网络异常，请检查网络连接"
#define kImaWithImaName(str)  [UIImage imageNamed:str]
/**
 *  最终的手势密码存储key
 */
#define MGGestureFinalSaveKey @"gestureFinalSaveKey"

/**
 *  第一个手势密码存储key
 */
#define MGGestureOneSaveKey @"gestureOneSaveKey"

static NSString *const kMGMsgSwitchKey = @"MsgSwitchKey";
static NSString *const kMGSessionIdKey = @"sessionIdKey";
static NSString *const kMGBeanNameKey = @"sbeanNameKey";
static NSString *const kMGParameterKey = @"parameterKey";
static NSString *const kMGLoginNameKey = @"loginName";
static NSString *const kMGStatusKey = @"status";
static NSString *const kMGPwdKey = @"minePwdKey";
static NSString *const kMGLoginUserNameKey = @"LoginUserNameKey";
static NSString *const kMGHeadImaNameKey = @"HeadImaNameKey";
static NSString *const kMGHeadImaName = @"photo5.jpg";


//
static NSString *const kMGLoginSuccessNotification = @"loginSuccessNoti";
static NSString *const kMGLoginOutNotification = @"loginOutNoti";
static NSString *const kMGChangeHeadImaSuccessNotificationName = @"changeHeadImaSuccess";
NS_INLINE T2TNavController * getNavWithVc(UIViewController *vc){

    return [[T2TNavController alloc] initWithRootViewController:vc];

}
NS_INLINE NSDictionary * MGGetStausDic(){

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *dicStatus = [NSMutableDictionary dictionaryWithDictionary:@{@"ver":currentVersion}];
    [dicStatus setObject:[kUserDefaults objectForKey:kMGBeanNameKey]?:@"" forKey:@"beanName"];
//    [dicStatus setObject:[kUserDefaults objectForKey:kMGParameterKey]?:@"" forKey:@"parameter"];
     [dicStatus setObject:@"2" forKey:@"parameter"];
    [dicStatus setObject:[kUserDefaults objectForKey:kMGSessionIdKey]?:@"" forKey:@"sessionId"];
    [dicStatus setObject:[kUserDefaults objectForKey:kMGLoginNameKey]?:@"" forKey:@"loginName"];
    return [dicStatus copy];
}

NS_INLINE NSDictionary * MGGetStatusDicHaveUserName(){

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:MGGetStausDic()];
    MGUserModel *modfl = [MGUserModel shareMGUserModel];
    [dic setObject:kUnNilStr(modfl.userName) forKey:@"userName"];
    return [dic copy];
    
}

NS_INLINE NSDictionary *MGGetOtherHttpHear(){

    if ([kUserDefaults objectForKey:kMGSessionIdKey]) {
        return @{@"sessionId":[kUserDefaults objectForKey:kMGSessionIdKey]};
    }
    return nil;
}

#define kMGLineColor [UIColor colorWithHexString:@"#b2b2b2"]
#define RGB(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kDefaultBackgroundColor [UIColor colorWithHexString:@"#f2f2f2"]

#pragma mark - 字体颜色

#define kCommColor_333 [UIColor colorWithHexString:@"#333"]
#define kCommColor_555 [UIColor colorWithHexString:@"#555"]
#define kCommColor_line [UIColor colorWithHexString:@"#b2b2b2"]
#define kMGBtnColorIma  [UIImage imageWithColor:[UIColor colorWithHexString:@"#46bbf0"]]
#pragma mark - 字体
#define kCommonFont_18px  [UIFont fontWithName:@"STHeitiSC-Light" size:9]
#define kCommonFont_20px  [UIFont fontWithName:@"STHeitiSC-Light" size:10]
#define kCommonFont_22px  [UIFont fontWithName:@"STHeitiSC-Light" size:11]
#define kCommonFont_24px  [UIFont fontWithName:@"STHeitiSC-Light" size:12]
#define kCommonFont_26px  [UIFont fontWithName:@"STHeitiSC-Light" size:13]
#define kCommonFont_28px  [UIFont fontWithName:@"STHeitiSC-Light" size:14]
#define kCommonFont_30px  [UIFont fontWithName:@"STHeitiSC-Light" size:15]
#define kCommonFont_32px  [UIFont fontWithName:@"STHeitiSC-Light" size:16]
#define kCommonFont_34px  [UIFont fontWithName:@"STHeitiSC-Light" size:17]
#define kCommonFont_36px  [UIFont fontWithName:@"STHeitiSC-Light" size:18]
#define kCommonFont_38px  [UIFont fontWithName:@"STHeitiSC-Light" size:19]
#define kCommonFont_40px  [UIFont fontWithName:@"STHeitiSC-Light" size:20]

static int  kMGOkStatuCode = 0;

#pragma mark - url
#pragma mark - request url

static NSString *const kMGDefaultURL = @"http://210.14.73.175:7912/API/Video/GetHotVideo?ReqMsg=%@";

static NSString *const kMGDefaultImaURL = @"http://223.4.94.140:8091/pm/down/clientPhoto/%@.jpg";
//登陆
static NSString *const kMGLoginUrl   = @"appLogin.do?method=login&word=";






NS_INLINE NSString *getImaUrlWithName(NSString *name){
    
    return [[NSString stringWithFormat:kMGDefaultImaURL,[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



#pragma mark - tool url
static NSString *const kMGToolFirstTabUrl = @"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=283311&sid=731946&OUID=&jumpUrl=http://www.ctrip.com";
static NSString *const kMGToolSecondTabUrl = @"http://pay.xiaojukeji.com/api/v2/webapp?city=\"+locationInfo.getCityName()+\"&maptype=baidu\"+\"&fromlat=\"+locationInfo.getLatitude()+\"&fromlng=\"+locationInfo.getLongitude()";
static NSString *const kMGToolThirdTabUrl = @"http://m.kuaidi100.com";

#endif
