//
//  MGUserManger.m
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGUserManger.h"

@implementation MGUserManger
+(void)loginWithUserName:(NSString *)userName psdStr:(NSString *)psdStr handleBlock:(T2TObjBlock)handleBlock{

    
    NSString *str =[DES encryptUseDES:psdStr key:@"gene2015!"];
    NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"+" withString:@"2B%"];
    NSDictionary *dicInfo = @{kMGStatusKey:MGGetStausDic(),@"object":@{@"pwd":kUnNilStr(strUrl),@"loginName":kUnNilStr(userName)}};
    [T2THttpManager getWithUrl:[NSString stringWithFormat:kMGDefaultURL,kMGLoginUrl,[dicInfo JSONString]] success:^(T2TResponse *responseObject) {
        if (responseObject.code == kMGOkStatuCode) {
            MGUserModel *model = [MGUserModel shareMGUserModel];
            
            [kUserDefaults setObject:kUnNilStr(responseObject.parameter)  forKey:kMGParameterKey];
            [kUserDefaults setObject:kUnNilStr(responseObject.beanName) forKey:kMGBeanNameKey];
            
            [kUserDefaults synchronize];
            [model saveUserInfoWithDic:responseObject.userInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:kMGLoginSuccessNotification object:nil];
            
            //下载头像
            
//            [self downLoadImafinishBlock:nil];
        }
        (!handleBlock) ?:handleBlock(responseObject);


    } failure:^(id error) {
        (!handleBlock) ?:handleBlock(nil);
    } otherHttpHeader:MGGetOtherHttpHear()];
    
}

//+  (void)downLoadImafinishBlock:(T2TObjBlock)finishBlock {
//    
//    MGUserModel *model = [MGUserModel shareMGUserModel];
//    
//    //     http://223.9.94.140:8091/pm/down/clientPhoto/wuran.jpg
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//    
//    NSString *urlStr = [NSString stringWithFormat:kMGDefaultURL,@""];
//    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://223.9.94.140:8091/pm/down/clientPhoto/%@.jpg",model.loginName]];
//    
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (data) {
//           
//            NSString *filePath = kFilePathAtDocumentWithName(@"head.jpg");
//           BOOL state =  [data writeToFile:filePath atomically:YES];
//            if (state) {
////                kMGHeadImaNameKey
//                [kUserDefaults setObject:@"head.jpg" forKey:kMGHeadImaNameKey];
//                [kUserDefaults synchronize];
//            }
//            
//        } else {
//            
//            (!finishBlock) ?:finishBlock(nil);
//        }
//    }];
//    
//    
//    
//}


@end
