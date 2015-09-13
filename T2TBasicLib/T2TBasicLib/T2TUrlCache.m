//
//  EUrlCache.m
//  NSUrlCache
//
//  Created by mark on 15/5/7.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TUrlCache.h"
#import "NSString+TDigest.h"


#define kTimeKey @"time"
#define kMIMETypeKey @"MIMEType"
#define kTextEncodingNameKey @"textEncodingName"

@interface T2TUrlCache ()
@property(nonatomic,strong)NSMutableDictionary *dicResponse;
@end

@implementation T2TUrlCache
-(instancetype)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path{
    if (self = [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
        self.catchTime = 24*60*60*7;
        self.dicResponse = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - super
-(NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request{
    
    
    if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame || ![request valueForHTTPHeaderField:typeIsWebKey]) {
        return [super cachedResponseForRequest:request];
    }
    return [self customResponseForRequest:request];
}


#pragma mark - private
-(NSString *)getFileName:(NSString *)url{
    return   [url getMd5_32Bit];
}

-(NSString *)getOtherInfoName:(NSString *)url{
    
    return [[NSString stringWithFormat:@"%@-otherInfo",url] getMd5_32Bit];
}

- (NSString *)cacheFilePath:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"URLCache/%@",fileName];
    NSString *path = kFilePathAtCachWithName(filePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        
    } else {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

-(NSCachedURLResponse *)customResponseForRequest:(NSURLRequest *)request{
    NSString *url = request.URL.absoluteString;//请求的链接
    NSString *fileName = [self getFileName:url];//缓存的文件名
    NSString *otherInfoName = [self getOtherInfoName:url];//缓存信息的文件名
    NSString *filePath = [self cacheFilePath:fileName];//缓存的目录路径
    NSString *otherInfoPath = [self cacheFilePath:otherInfoName];//缓存信息字典路径
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:filePath]) {
        //当文件名存在的时候
        NSDate *date = [NSDate date];
        BOOL isOverdue = YES;
        NSDictionary *dicInfo = [NSDictionary dictionaryWithContentsOfFile:otherInfoPath];
        if (self.catchTime > 0 && dicInfo) {
            NSDate *createDate = dicInfo[kTimeKey];
            double  createTime = [date timeIntervalSinceDate:createDate];
            if (createTime < self.catchTime) {
                isOverdue = NO;
            }
        }
        
        if (!isOverdue) {
            //没有过期
//            NSLog(@"访问缓存数据..");
            [TLog log:@"访问缓存数据.."];
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:dicInfo[kMIMETypeKey] expectedContentLength:data.length textEncodingName:dicInfo[kTextEncodingNameKey]];
            NSCachedURLResponse *cacheResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            return cacheResponse;
        }else{
            //已经过期  删除信息
            [TLog log:@"已经过期  删除信息.."];
            [fileManger removeItemAtPath:filePath error:nil];
            [fileManger removeItemAtPath:otherInfoPath error:nil];
            
        }
    }
    
    BOOL isExsit = [[self.dicResponse objectForKey:url] boolValue];
    if (!isExsit) {
        [self.dicResponse setObject:@(YES) forKey:url];
        [TLog log:@"网络请求数据..."];
//        NSLog(@"网络请求数据...");
        __block NSCachedURLResponse *cacheResponse = nil;
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            //移除请求记录
            [self.dicResponse removeObjectForKey:url];
            if (data && response) {
                NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
                
                [dicInfo setObject:[NSDate date] forKey:kTimeKey];
                [dicInfo setObject:kUnNilStr(response.MIMEType) forKey:kMIMETypeKey];
                [dicInfo setObject:kUnNilStr(response.textEncodingName) forKey:kTextEncodingNameKey];
                [data writeToFile:filePath atomically:NO];
                [dicInfo writeToFile:otherInfoPath atomically:YES];
                cacheResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            }
            
        }];
        return cacheResponse;
    }else{
        [TLog log:@"该请求已存在..."];
    }
    
    return nil;
}

@end
