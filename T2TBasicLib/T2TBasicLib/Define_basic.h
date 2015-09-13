//
//  Define_basic.h
//  TTHttpManager
//
//  Created by mark on 14/12/11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#ifndef TTHttpManager_Define_basic_h
#define TTHttpManager_Define_basic_h

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import  "Reachability.h"
#import "UIImage+TCategory.h"
#import "UIColor+HexString.h"

#endif

#define kDefaultUrl @"http://api.233.com/login" //默认的请求地址
int APPID;//这里还没有设置值
#pragma mark -

//系统版本
NS_INLINE float device_version()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}



#define k_color_navBar [UIColor whiteColor]
#define kNavBarBgImgName @"NavigatetBgc"
#define kBorderBBIBgImgName @"bbi_border"
#define kBackBBIImgName @"bbi_back"

//是否ios7以上系统
#define kIsIOS7 (device_version() >=7.0)
#define kIsIOS8 (device_version() >=8.0)
//ios7以上视图中包含状态栏预留的高度
#define kHeightInViewForStatus (kIsIOS7?20:0)
//状态条占的高度
#define kHeightForStatus (kIsIOS7?0:20)
//导航栏高度
#define kNavBarHeight (kIsIOS7?64:44)
//视图的位置起点y值
#define kViewOriginY (kIsIOS7?kNavBarHeight:0)
//navBar能点击时候的颜色
#define kBarIsEnableColor [UIColor redColor]
//线框的颜色值
#define kLineColor [UIColor colorWithHexString:@"#e3e3e3"]

#define kTabBarHeight self.tabBarController.tabBar.height



//缓存路径-cach目录
#define kFilePathAtCachWithName(fileNAme) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileNAme]

//缓存路径-document目录
#define kFilePathAtDocumentWithName(fileNAme) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileNAme]
//缓存路径-tem目录
#define kFilePathAtTemWithName(fileNAme) [NSTemporaryDirectory() stringByAppendingString:fileNAme]//


//辨别iphone5
#define kIs4Inch (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size))

#define kIs4SInch (CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size))
//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//屏幕宽
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

//app高度
#define kApplicationHeight (kIsIOS7?CGRectGetHeight([UIScreen mainScreen].bounds):CGRectGetHeight([[UIScreen mainScreen] applicationFrame]))

//颜色 两种参数
#define RGB_255(r,g,b) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1]
#define RGB_1(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1]
//rgb颜色转换（16进制->10进制）
#define KColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//当前window
#define kCurrentWindow [[UIApplication sharedApplication].windows firstObject]

//非空的字符串 避免输出null
#define kUnNilStr(str) ((str && ![str isEqual:[NSNull null]])?str:@"")
//非空的字符串 输出空格
#define kUnNilStrSpace(str) ((str && ![str isEqual:[NSNull null]] && ![str isEqualToString:@"(null)"])?str:@" ")
//整数转换成字符串
#define kStrWithInter(i) [NSString stringWithFormat:@"%d",i]
//float转换成字符串
#define kStrWithFloat(f) [NSString stringWithFormat:@"%0.1f",f]
//app名称
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//app版本
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//验证字典有没有某个key 并且判断值的类型
#define ValidateDicWithKey(dic,key) ([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null])
#define ValidateDicWithKey_Dic(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSDictionary class]])
#define ValidateDicWithKey_Arr(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSArray class]])
#define ValidateDicWithKey_Str(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSString class]])
//视图的宽、高、y
#define kSelfViewWidth CGRectGetWidth(self.view.frame)
#define kSelfViewHeight CGRectGetHeight(self.view.frame)
#define kSelfViewOriginY self.view.frame.origin.y
//列表imgv默认图片
#define kCellDefaultImg [UIImage imageNamed:@"bg_cell_defaultImg"]
//默认头像
#define kDefaultHeadImg [UIImage imageNamed:@"img_defaultHead"]
//列表imgv默认背景颜色 与图片背景颜色一致
#define kColorForCellDefaultImgBg RGB_255(230, 230, 230)
//警告提示 带标题
#define kAlter(title,msg) [[[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil] show]
//警告提示 不带标题
#define kUnTitleAlter(msg) kAlter(@"",msg)
//
#define kUserDefaults [NSUserDefaults standardUserDefaults]
//替换字符串后半段的某个字符串
#define kReplySuffixStr(str_ori,str_1,str_2) (str_ori.length>8?[str_ori stringByReplacingOccurrencesOfString:str_1 withString:str_2 options:NSCaseInsensitiveSearch range:NSMakeRange(str_ori.length/2, str_ori.length/2-1)]:str_ori)
//将链接字符串转换成文件名
#define kFileNameWithUrlStr(urlStr) [urlStr getMd5_32Bit]//[urlStr stringByReplacingOccurrencesOfString:@"/" withString:@"_"]

//对应的.bundle的名称
#define kTBasicLibResourceBundleName @"TBasicLibResource"

//判断是否是ipad
#define kIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//app评分接口
#define APP_COMMENT_URL [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",APPID]

#define kHttpUsetAgent [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; TO8TOAPP)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion]]


NS_INLINE void changeCellSepEdageInsets(UITableViewCell *cell){

    if (kIsIOS8) {
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
    }
}

NS_INLINE UIView *getLineViewWithFrame(CGRect frame){
    
    UIView *viewLine = [[UIView alloc] init];
    viewLine.frame = frame;
    viewLine.backgroundColor = [UIColor colorWithHexString:@"#e3e3e3"];
    return viewLine;
}

//本地图片
NS_INLINE UIImage *kImgAtBundle(NSString *imageName)
{
    
    return [UIImage imgAtBundleWithName:imageName];
    
    //    if (![imageName isKindOfClass:[NSString class]]) {
    //        return nil;
    //    }
    //    NSString *imgPath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@@2x",imageName] ofType:@"png"];
    //    UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
    //    if (!img && imageName.length>0) {
    //        [TLog logErrorInfo:[NSString stringWithFormat:@"no img for imageName:%@ imgPath:%@",imageName,imgPath]];
    //    }
    //    return img;
}


//网络判断 参数boo为是否弹出警告
NS_INLINE BOOL kIsConnectEnable(BOOL boo){
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if (![reach isReachable]) {
        if (boo) {
            UIAlertView *alv = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你的网络不太给力哦\n请稍后再尝试" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alv show];
        }
        
        return NO;
    }
    return YES;
    
}



//验证手机号
NS_INLINE BOOL kCheckPhoneNumber(NSString *_text)
{
    //   (13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}
    NSString *Regex =@"^0?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
    
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    return [mobileTest evaluateWithObject:_text];
}

//验证邮箱
NS_INLINE BOOL kCheckEmailNumber(NSString *_text)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:_text];
}

//url编码
NS_INLINE NSString *kEncodeURL(NSString *string)
{
    if(![string isKindOfClass:[NSString class]]){
        return nil;
    }
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return @"";
}

#endif
