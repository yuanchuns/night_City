//
//  TLog.m
//  TBasicLib
//
//  Created by kevin.huang on 14-6-10.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import "TLog.h"

#define kMaxTextLength 1000

@interface TLog (){
    //将要写入本地的记录字符串，两种情况下写入本地：1字符串长度超过kMaxTextLength、2调用writeLogInLocalFile手动写入；写入本地后清空
    NSString *_strShouldLogInFile;
}

@end

@implementation TLog

//编译器打印aString 非开发模式不打印
+(void)log:(NSString *)aString{
    
    if (kIsDevelope) {
        NSLog(@"%@",aString);
    }
}

//编译器打印title和info 非开发模式不打印
+(void)logTitle:(NSString *)title info:(NSString *)info{
    if (kIsDevelope) {
        NSLog(@"%@:%@",title,info);
    }
}

//记录错误信息
+(void)logErrorInfo:(NSString *)aString{
    aString = [NSString stringWithFormat:@"#%@\n",aString];
    if (kIsDevelope) {
        NSLog(@"%@",aString);
        NSLog(@"\n Function: %s\n Pretty function: %s\n Line: %d\n File: %s\n Object: %@",__func__, __PRETTY_FUNCTION__, __LINE__, __FILE__,aString);
//        NSAssert(NO, aString);
    }else{
        //发布版这里可以发送给服务器，可单条发送或记在本地后一起发送，需要后台配合
    }
}

#pragma mark - 

//将aString记到本地文件 编译器不打印
+(void)logInLocalFile:(NSString *)aString{
    
//    TLog *log = [TLog shareLogEngine];
//    
//    [log logInLocalFileWithString:aString];
    
}

//将title和info组成字符串记到本地文件 编译器不打印
+(void)logInLocalFileWithTitle:(NSString *)title info:(NSString *)info{
    
    NSString *strShouldLog = [NSString stringWithFormat:@"%@:%@",title,info];
    
    [self logInLocalFile:strShouldLog];
}



#pragma mark - 


+(TLog *)shareLogEngine{
    static TLog *shareLog;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareLog = [[TLog alloc]init];
    });
    return shareLog;
}

-(id)init{
    self = [super init];
    if (self) {
        _strShouldLogInFile = @"";
    }
    return self;
}

//记录aString到本地 采用当字符串长度超过kMaxTextLength后一起写入本地 避免太频繁写入
-(void)logInLocalFileWithString:(NSString *)aString{
    _strShouldLogInFile = [NSString stringWithFormat:@"%@\n%@",_strShouldLogInFile,aString];
    
    if (_strShouldLogInFile.length>=kMaxTextLength) {
        [self writeLogInLocalFile];
    }
}

//将记录写入本地 写入成功后情况将要写入的字符串
-(void)writeLogInLocalFile{
    NSString *fileName = @"kLocalLog.txt";
    NSString *filePath = kFilePathAtDocumentWithName(fileName);
    
    NSString *strLogText = @"";
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        NSString *strLogTextInFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        strLogText = [strLogText stringByAppendingString:strLogTextInFile];
    }
    
    strLogText = [strLogText stringByAppendingString:_strShouldLogInFile];
    
    
    if (![strLogText writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
        NSAssert(NO, @"write err");
    }else{
        _strShouldLogInFile = @"";//记下后清空
    }
}


@end
