//
//  T2THttpManager.h
//  TTHttpManager
//
//  Created by mark on 14/12/11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "T2TBasicLib.h"
#import "T2TResponse.h"
#import "AFHTTPRequestOperationManager.h"
@interface T2THttpManager : NSObject
typedef void(^RequestResponse)(T2TResponse *responseObject);
/**
 *  post请求,默认的URL地址
 *
 *  @param parameter 请求参数字典
 *  @param success    成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)postToDefaultUrlWithParameter:(NSDictionary *)parameter success:(RequestResponse)success
                              failure:(T2TObjBlock)failure;

/**
 *  post请求
 *
 *  @param urlStr         请求url字符串
 *  @param parameter 请求参数字典
 *  @param success    成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
               success:(RequestResponse)success failure:(T2TObjBlock)failure;

/**
 *  post请求,默认的URL地址,加HUD
 *
 *  @param parameter 请求参数字典
 *  @param view          显示hud的view
 *  @param success    成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)postToDefaultUrlWithParameter:(NSDictionary *)parameter hudAddedToView:(UIView *)view
                              success:(RequestResponse)success failure:(T2TObjBlock)failure;

/**
 *  post请求，加HUD
 *
 *  @param urlStr         请求url字符串
 *  @param parameter 请求参数字典
 *  @param view          显示hud的view
 *  @param success    成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
        hudAddedToView:(UIView *)view success:(RequestResponse)success
               failure:(T2TObjBlock)failure;


/**
 *  post发送文件，默认的URL地址
 *
 *  @param parameter 请求参数字典
 *  @param dic_file      文件字典，key为文件名，obj为文件绝对路径
 *  @param success    成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)postToDefaultUrlWithParameter:(NSDictionary *)parameter file:(NSDictionary *)dic_file
                              success:(RequestResponse)success failure:(T2TObjBlock)failure;

/**
 *  post发送文件
 *
 *  @param urlStr         请求url字符串
 *  @param parameter 请求参数字典
 *  @param dic_file      文件字典，key为文件名，obj为文件绝对路径
 *  @param success    成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
                  file:(NSDictionary *)dic_file success:(RequestResponse)success failure:(T2TObjBlock)failure;

/**
 *  post发送文件，默认的URL地址，加HUD
 *
 *  @param parameter 请求参数字典
 *  @param dic_file      文件字典，key为文件名，obj为文件绝对路径
 *  @param view          显示hud的view
 *  @param success   成功返回后的数据
 *  @param failure      请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)postToDefaultUrlWithParameter:(NSDictionary *)parameter file:(NSDictionary *)dic_file
                       hudAddedToView:(UIView *)view success:(RequestResponse)success
                              failure:(T2TObjBlock)failure;
/**
 *  post发送文件，加HUD
 *
 *  @param urlStr         请求url
 *  @param parameter 请求参数字典
 *  @param dic_file      文件字典，key为文件名，obj为文件绝对路径
 *  @param view          显示hud的view
 *  @param success   成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
                  file:(NSDictionary *)dic_file hudAddedToView:(UIView *)view
               success:(RequestResponse)success failure:(T2TObjBlock)failure;

/**
 *   get请求,默认的URL地址
 *
 *  @param parameter 请求参数字典
 *  @param success   成功返回后的数据
 *  @param failure      请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)getToDefaultUrlWithParameter:(NSDictionary *)parameter success:(RequestResponse)success
                             failure:(T2TObjBlock)failure;

/**
 *  get请求
 *
 *  @param urlStr         请求url
 *  @param parameter 请求参数字典
 *  @param success    成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)getWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
              success:(RequestResponse)success failure:(T2TObjBlock)failure;

/**
 *  get请求,默认的URL地址，加HUD
 *
 *  @param parameter 请求参数字典
 *  @param view           加载hud的视图
 *  @param success    成功返回后的数据
 *  @param failure   请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)getToDefaultUrlWithParameter:(NSDictionary *)parameter hudAddedToView:(UIView *)view
                             success:(RequestResponse)success failure:(T2TObjBlock)failure;

/**
 *  get请求，加HUD
 *
 *  @param urlStr         请求url
 *  @param parameter 请求参数字典
 *  @param view          加载hud的视图
 *  @param success   成功返回后的数据
 *  @param failure       请求失败返回的错误，请求错误会返回NSError类型，服务器返回的错误会返回TRequestResponse
 */
+ (void)getWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
       hudAddedToView:(UIView *)view success:(RequestResponse)success
              failure:(T2TObjBlock)failure;
/**
 *  get请求，加HUD
 *
 *  @param urlStr  请求url
 *  @param view    加载HUD的视图
 *  @param success 成功后回调的block
 *  @param failure 失败回调block
 */
+ (void)getWithUrl:(NSString *)urlStr hudAddedToView:(UIView *)view
                             success:(RequestResponse)success failure:(T2TObjBlock)failure;
/**
 *  get请求，不加HUD
 *
 *  @param urlStr  请求的HUD
 *  @param success 成功后的回调block
 *  @param failure 失败后的block
 */
+ (void)getWithUrl:(NSString *)urlStr success:(RequestResponse)success failure:(T2TObjBlock)failure;

+ (void)getWithUrl:(NSString *)urlStr success:(RequestResponse)success failure:(T2TObjBlock)failure otherHttpHeader:(NSDictionary *)dicHeader;

/**
 *  get请求，非规定格式返回数据的请求
 *
 *  @param urlStr    请求url
 *  @param parameter 请求参数字典
 *  @param success   成功返回后的数据
 *  @param failure   请求失败返回的错误
 */
+(void)getForOtherWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)postForOtherWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)startObsertConnectStatus;
+(void)obsertConnectStatusWithNoConnectHandle:(T2TBasicBlock)blockOfNoConnect connectedHandle:(T2TBasicBlock)blockOfConnected;
+(BOOL)isConnectEnableWithAlter:(BOOL)showAlter;


@end
