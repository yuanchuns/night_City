//
//  AppDelegate.m
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "AppDelegate.h"
#import "MGHomeVC.h"
#import "GestureViewController.h"
#import "EManggerMsg.h"
#import "MGAddMineSchduleNoti.h"
@implementation AppDelegate
{

    Reachability *con;
    NSTimer *_timer;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
       // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkState:) name:kReachabilityChangedNotification object:nil];
    con =  [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [con startNotifier];
    [self setWIndowRootVc];
    
    if (![kUserDefaults objectForKey:kMGMsgSwitchKey]) {
        [kUserDefaults setObject:[NSNumber numberWithBool:YES] forKey:kMGMsgSwitchKey];
    }
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionLoginSuccess) name:kMGLoginSuccessNotification object:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setWIndowRootVc{
    MGHomeVC *hvc = [[MGHomeVC alloc] init];
    T2TNavController *hNav = getNavWithVc(hvc);
    self.window.rootViewController = hNav;
//    if ([kUserDefaults objectForKey:MGGestureFinalSaveKey]) {
//        //表示手势密码存在
//        GestureViewController *gvc = [[GestureViewController alloc] init];
//        gvc.type = GestureViewControllerTypeLogin;
//        [gvc setHandleSuccessBlock:^{
//            MGHomeVC *hvc = [[MGHomeVC alloc] init];
//            T2TNavController *hNav = getNavWithVc(hvc);
//            self.window.rootViewController = hNav;
//            [MGUserManger loginWithUserName:[[MGUserModel shareMGUserModel] getUserName] psdStr:[[MGUserModel shareMGUserModel] getPwd] handleBlock:nil];
//        }];
//        self.window.rootViewController = gvc;
//            
//    }else{
//    
//        MGLoginVC *lvc = [MGLoginVC getLoginVC];
//        self.window.rootViewController = lvc;
//        
//        [lvc setLoginSuccessBlock:^{
//            MGHomeVC *hvc = [[MGHomeVC alloc] init];
//            T2TNavController *hNav = getNavWithVc(hvc);
//            self.window.rootViewController = hNav;
//        }];
//    }
    
}

- (void)checkNetworkState:(NSNotification *)note
{
    Reachability* curReach= [note object];
    NetworkStatus status= [curReach currentReachabilityStatus];
    
   MGUserModel *model =  [MGUserModel shareMGUserModel];
    //判断
    if (status == ReachableViaWiFi) {
        model.netTYpe = MGNetWorkWIFIType;
    } else if (status == ReachableViaWWAN) {
        model.netTYpe = MGNetWork3GType;
       
    } else {
        kAlter(@"网络提示", @"当前无网络，请检测您的网络连接!");
        model.netTYpe = MGNetWorkNotType;
    }
}
- (void)ActionLoginSuccess {
    
    NSNumber *numBool = [kUserDefaults objectForKey:kMGMsgSwitchKey];
    if (![numBool boolValue]) {
        //表示已经关掉了消息接受
        return;
    }
    
   [self performSelector:@selector(updateMsg) withObject:nil afterDelay:5];//每次登陆成功就去刷新一次消息
    
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)updateMsg {

    [self stopTimer];
    [self startTime];
    
    UIViewController *curVC = [self getCurrentVC];
    curVC.statusBarNotificationLabel.textColor = [UIColor redColor];
    curVC.statusBarNotificationLabel.backgroundColor = curVC.view.tintColor;
    
    [MGMsgModel getNewMsgWithFinishBlock:^(id error) {
        if ([error isKindOfClass:[NSArray class]]) {
        EManggerMsg *manger = [EManggerMsg shareEManggerMsg];
         int num  = [manger addRecordWithArr:error];
            if(num > 0){
            [curVC showStatusBarNotification:[NSString stringWithFormat:@"有%d条消息更新",num] forDuration:2];
            }
            
        }
    }];
    
}

- (void)startTime {

    if (_timer) {
        return;
    }
  
     MGUserModel *model =  [MGUserModel shareMGUserModel];
    
    NSDate *today = [NSDate date];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComm = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit  fromDate:today];
    NSLog(@"%ld %ld",dateComm.hour,dateComm.minute);
    float curTime = 0;
    if (model.netTYpe == MGNetWorkWIFIType) {
        
        if (dateComm.hour >= 7  && dateComm.hour < 21){
            
            curTime = 3 * 60;
        } else {
        
            curTime = 120 * 60;
        }
        
    } else {
        if (dateComm.hour >= 7  && dateComm.hour < 21){
            curTime = 6 * 60;
        } else {
            
            curTime = 120 * 60;
        }
        
    }
    
      _timer = [NSTimer scheduledTimerWithTimeInterval:curTime target:self selector:@selector(updateMsg) userInfo:nil repeats:YES];
    
}

- (void)stopTimer {

//    currentTime = 0;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)actionTime {

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
     NSDictionary *dicInfo = notification.userInfo;
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"闹钟" message:dicInfo[alertBodyKey] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [kUserDefaults removeObjectForKey:dicInfo[@"scheduleId"]];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
