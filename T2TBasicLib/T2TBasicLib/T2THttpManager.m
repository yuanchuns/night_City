//
//  T2THttpManager.m
//  TTHttpManager
//
//  Created by mark on 14/12/11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2THttpManager.h"

#import "Reachability.h"
@implementation T2THttpManager
+ (void)postToDefaultUrlWithParameter:(NSDictionary *)parameter success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    [self postWithUrlStr:kDefaultUrl parameter:parameter success:success failure:failure];
}

+ (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
               success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    [self postWithUrlStr:urlStr parameter:parameter hudAddedToView:nil success:success failure:failure];
}

+ (void)postToDefaultUrlWithParameter:(NSDictionary *)parameter hudAddedToView:(UIView *)view success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    [self postWithUrlStr:kDefaultUrl parameter:parameter hudAddedToView:view success:success failure:failure];
}

#pragma mark- 所有POST请求最终调此函数

+ (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
        hudAddedToView:(UIView *)view success:(RequestResponse)success
               failure:(T2TObjBlock)failure
{
    if(view) [MBProgressHUD showHUDAddedTo:view animated:YES];
    NSDictionary *dicParameter = [self dicParameterWithDic:parameter];
    [[AFHTTPRequestOperationManager manager] POST:urlStr parameters:dicParameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
        [self requestResponse:responseObject operation:operation success:success failure:failure];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
        if(failure) failure(error);
    }];
    
    
}

#pragma mark - POST 发送文件

+ (void)postToDefaultUrlWithParameter:(NSDictionary *)parameter file:(NSDictionary *)dic_file
                              success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    [self postWithUrlStr:kDefaultUrl parameter:parameter file:dic_file success:success failure:failure];
}

+ (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
                  file:(NSDictionary *)dic_file success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    [self postWithUrlStr:urlStr parameter:parameter file:dic_file hudAddedToView:nil success:success failure:failure];
}

+ (void)postToDefaultUrlWithParameter:(NSDictionary *)parameter file:(NSDictionary *)dic_file
                       hudAddedToView:(UIView *)view success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    [self postWithUrlStr:kDefaultUrl parameter:parameter file:dic_file hudAddedToView:view success:success failure:failure];
}

#pragma mark- 所有发送文件请求最终调此函数

+ (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
                  file:(NSDictionary *)dic_file hudAddedToView:(UIView *)view
               success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    NSDictionary *dicParameter = [self dicParameterWithDic:parameter];
    if(view) [MBProgressHUD showHUDAddedTo:view animated:YES];
    [[AFHTTPRequestOperationManager manager] POST:urlStr parameters:dicParameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [dic_file enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSError *error = nil;
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:obj isDirectory:NO] name:key error:&error];
          //  [TLog log:error.description];
        }];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
        [self requestResponse:responseObject operation:operation success:success failure:failure];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
       // if(failure) failure(error);
        //[TLog log:error.description];
    }];
}

#pragma mark GET 请求

+ (void)getToDefaultUrlWithParameter:(NSDictionary *)parameter success:(RequestResponse)success
                             failure:(T2TObjBlock)failure
{
    [self getWithUrlStr:kDefaultUrl parameter:parameter success:success failure:failure];
}

+ (void)getWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
              success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    [self getWithUrlStr:urlStr parameter:parameter hudAddedToView:nil success:success failure:failure];
}

+(void)getWithUrl:(NSString *)urlStr hudAddedToView:(UIView *)view success:(RequestResponse)success failure:(T2TObjBlock)failure{
    [self getWithUrlStr:urlStr parameter:nil hudAddedToView:view success:success failure:failure];
}

+ (void)getWithUrl:(NSString *)urlStr success:(RequestResponse)success failure:(T2TObjBlock)failure{
    [self getWithUrlStr:urlStr parameter:nil hudAddedToView:nil success:success failure:failure];
}

+ (void)getToDefaultUrlWithParameter:(NSDictionary *)parameter hudAddedToView:(UIView *)view
                             success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    [self getWithUrlStr:kDefaultUrl parameter:parameter hudAddedToView:view success:success failure:failure];
}



+(void)getForOtherWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure{

    
    [[AFHTTPRequestOperationManager manager] GET:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
}

+(void)postForOtherWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[AFHTTPRequestOperationManager manager] POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation.responseData);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure) failure(error);
    }];
}


#pragma mark- 所有Get请求最终调此函数

+ (void)getWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
       hudAddedToView:(UIView *)view success:(RequestResponse)success
              failure:(T2TObjBlock)failure
{
    if(view) [MBProgressHUD showHUDAddedTo:view animated:YES];

    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    NSLog(@"%@",man.requestSerializer.HTTPRequestHeaders);
    [[AFHTTPRequestOperationManager manager] GET:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
        [self requestResponse:responseObject operation:operation success:success failure:failure];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
        if(failure) failure(error);
    }];
}

+ (void)getWithUrl:(NSString *)urlStr success:(RequestResponse)success failure:(T2TObjBlock)failure otherHttpHeader:(NSDictionary *)dicHeader{
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    if ([dicHeader isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in dicHeader) {
            [man.requestSerializer setValue:dicHeader[key] forHTTPHeaderField:key];
        }
    }
    
    NSLog(@"newHeader = %@",man.requestSerializer.HTTPRequestHeaders);
    [man GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResponse:responseObject operation:operation success:success failure:failure];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure) failure(error);
    }];
}

#pragma mark - private

/**
 *  网络请求成功响应后的处理，服务器返回的错误会回调failure
 *
 *  @param responseObject 网络请求返回的响应
 *  @param success        请求成功的代码块
 *  @param failure           请求失败的代码块
 */
+ (void)requestResponse:(id)responseObject operation:(AFHTTPRequestOperation *)operation success:(RequestResponse)success failure:(T2TObjBlock)failure
{
    
    T2TResponse *response =[[T2TResponse alloc] initWithDic:responseObject];
    if (operation.response.statusCode >=200 && operation.response.statusCode <=299 ) {
        if(success) success(response);
    }else {
        if(failure) failure(response);
    }
    
}

/**
 *  网络请求参数处理，所有网络请求添加了t8t_device_id，uid
 *
 *  @param parameter 请求参数
 *
 *  @return 处理后的请求参数
 */
+ (NSDictionary *)dicParameterWithDic:(NSDictionary *)parameter
{
    if (!parameter) {
        return nil;
    } else {
        NSMutableDictionary *dicParameter = [[NSMutableDictionary alloc] initWithDictionary:parameter];
        return dicParameter;

    }
}

#pragma mark -

+(void)startObsertConnectStatus{
    [T2THttpManager obsertConnectStatusWithNoConnectHandle:^{
        UIAlertView *alv = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你的网络不太给力哦\n请稍后再尝试" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alv show];
    } connectedHandle:^{
    }];
}

+(void)obsertConnectStatusWithNoConnectHandle:(T2TBasicBlock)blockOfNoConnect connectedHandle:(T2TBasicBlock)blockOfConnected{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                if (blockOfNoConnect) {
                    blockOfNoConnect();
                }
                break;
            default:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"netWorking" object:self];
                if (blockOfConnected) {
                    blockOfConnected();
                }
                break;
        }
    }];
    [manager startMonitoring];
}

+(BOOL)isConnectEnableWithAlter:(BOOL)showAlter{
    

    
    Reachability *recWifi = [Reachability reachabilityForLocalWiFi];
    Reachability *recConn = [Reachability reachabilityForInternetConnection];
    
    if ([recConn currentReachabilityStatus] == NotReachable && [recWifi currentReachabilityStatus]== NotReachable) {
               if (showAlter) {
                    UIAlertView *alv = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的网络不太给力哦\n请稍后再尝试" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
                    [alv show];
                }
               return NO;
    }
    return YES;
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    if (manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable || manager.networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
//        if (showAlter) {
//            UIAlertView *alv = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的网络不太给力哦\n请稍后再尝试" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//            [alv show];
//        }
//        return NO;
//    }
//    return YES;
}

@end
