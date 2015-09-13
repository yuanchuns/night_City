//
//  TLog.h
//  TBasicLib
//
//  Created by kevin.huang on 14-6-10.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T2TBasicLib.h"
#import "T2TObject.h"
//#ifndef kIsDevelope
//#warning un kIsDevelope
#if DEBUG
#define kIsDevelope YES
#else
#define kIsDevelope NO
#endif
//#endif





@interface TLog : T2TObject

//编译器打印aString 非开发模式不打印
+(void)log:(NSString *)aString;
//编译器打印title和info 非开发模式不打印
+(void)logTitle:(NSString *)title info:(NSString *)info;
//记录错误信息
+(void)logErrorInfo:(NSString *)aString;
//将aString记到本地文件 编译器不打印
+(void)logInLocalFile:(NSString *)aString;
//将title和info组成字符串记到本地文件 编译器不打印
+(void)logInLocalFileWithTitle:(NSString *)title info:(NSString *)info;

//下面两方法用于手动将将要写入本地记录信息写入本地文件 应用将退出调用
+(TLog *)shareLogEngine;
-(void)writeLogInLocalFile;

@end
