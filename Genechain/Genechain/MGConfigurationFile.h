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

static int  kMGOkStatuCode = 1;

#pragma mark - url
#pragma mark - request url

static NSString *const kMGDefaultURL = @"http://erp.gene100.com/%@%@";

//static NSString *const kMGDefaultURL = @"http://223.4.94.140:8091/pm/%@%@";

static NSString *const kMGDefaultImaURL = @"http://223.4.94.140:8091/pm/down/clientPhoto/%@.jpg";
//登陆
static NSString *const kMGLoginUrl   = @"appLogin.do?method=login&word=";

//修改密码
static NSString *const kMGChangePwdUrl = @"appPerson.do?method=updateLoginPwdByOld&word=";
// 版本检测
static NSString *const kMGVersionUrl = @"appManage!version.action?word=";
//首页
static NSString *const kMGHomeImaUrl = @"appManage!banner.action?word=";
//消息中心
static NSString *const kMGMessageUrl = @"appManage!message.action?word=";
//测评
static NSString *const kMGTestUrl = @"appManage!test.action?word=";
//我的日程
static NSString *const kMGMineScheduleUrl = @"appSchedule!s102MyScheduleList.action?word=";
//日程管理
static NSString *const kMGMangerScheduleUrl =@"appSchedule!s101ScheduleList.action?word=";
//我的任务
static NSString *const kMGMineTaskUrl = @"appTask!p201MyTaskList.action?word=";
//任务确认
static NSString *const kMGMineTaskConfirmUrl = @"appTask!p202TaskConfirm.action?word=";
//项目类型
static NSString *const KMGProjectTypeUrl = @"appSchedule!s100ScheduleKind.action?word=";
//公司选择
static NSString *const kMGCommpanyUrl = @"appDept!d100CompayList.action?word=";
//日程查看
static NSString *const kMGScheduleDetailUrl = @"appSchedule!s105ScheduleEdit.action?word=";
static NSString *const kMGAddNewSchduleUrl = @"appSchedule!s103SaveSchedule.action?word=";
//部门类型
static NSString *const kMGDepartmentTypeUrl = @"appDept!d101DeptSelect.action?word=";
//项目选择
static NSString *const kMGProjectSelectUrl = @"appProject!p101ProjectSelect.action?word=";
//客户类型ppClient!c101ClientSelect.action?
static NSString *const kMGClientSelectedUrl = @"appClient!c101ClientSelect.action?word=";
static NSString *const kMGActivitySelectedUrl_Action = @"appSalon!s201ActivitySelect.action?word=";//活动招生
static NSString *const kMGActivitySelectedUrl_Exposition = @"appSalon!s202ExpositionSelect.action?word=";//活动展会
static NSString *const kMGEmployeeSelectedUrl = @"appEmployee!e101EmployeeSelect.action?word=";//员工选择
static NSString *const kMGEmployeeSelectedUrl_Teacher = @"appEmployee!e102TeacherSelect.action?word=";//员工选择外部

//差旅未分摊
static NSString *const kMGAirplanScheduleUrl = @"appFlight!w101DealFlightList.action?word=";
//差旅已分摊
static NSString *const kMGNotAirplanScheduleUrl = @"appFlight!w102FinishFlightList.action?word=";
//教具未分摊
static NSString *const kMGDelaWithBookListScheduleUrl = @"appBook!w201DealBookList.action?word=";
//教具已分摊
static NSString *const kMGDelaWithBookListFinishScheduleUrl = @"appBook!w202FinishBookList.action?word=";
//差旅建立
static NSString *const kMGTravelSetListInitScheduleUrl = @"appFlight!w103Flight.action?word=";
//教具建立
static NSString *const kMGBookSetListInitScheduleUrl = @"appBook!w203Book.action?word=";
//差旅建立任务选择
static NSString *const kMGTravel_Select_Task_ScheduleUrl = @"appTask!p301ProjetTaskSelect.action?word=";
//差旅建立选择类别
static NSString *const kMGTravel_Select_Kind_ScheduleUrl = @"appManage!w100ExpenseType.action?word=";


NS_INLINE NSString *getImaUrlWithName(NSString *name){
    
    return [[NSString stringWithFormat:kMGDefaultImaURL,[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



#pragma mark - tool url
static NSString *const kMGToolFirstTabUrl = @"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=283311&sid=731946&OUID=&jumpUrl=http://www.ctrip.com";
static NSString *const kMGToolSecondTabUrl = @"http://pay.xiaojukeji.com/api/v2/webapp?city=\"+locationInfo.getCityName()+\"&maptype=baidu\"+\"&fromlat=\"+locationInfo.getLatitude()+\"&fromlng=\"+locationInfo.getLongitude()";
static NSString *const kMGToolThirdTabUrl = @"http://m.kuaidi100.com";

#endif
