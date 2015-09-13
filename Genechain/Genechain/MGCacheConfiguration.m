//
//  MGCacheConfiguration.m
//  Genechain
//
//  Created by mark_zhang on 15/8/5.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGCacheConfiguration.h"

@implementation MGCacheConfiguration

+ (void)getConfigurationWithUrlStr:(NSString *)urlStr objBlock:(T2TObjBlock)objBlock isFirst:(NSNumber *)state{

    NSString *fileName = [[urlStr getMd5_32Bit] stringByAppendingString:@".txt"];
    if([[NSFileManager defaultManager] fileExistsAtPath:kFilePathAtDocumentWithName(fileName)]){
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:kFilePathAtDocumentWithName(fileName)];
//        if(block)block([self analyticMethod:arr]);
        
    }else{
        [self requestWithBlock:objBlock withFileName:fileName urlStr:urlStr isfirst:state];
    }
}

+ (void)requestWithBlock:(T2TObjBlock)block withFileName:(NSString *)fileName urlStr:(NSString *)urlStr isfirst:(NSNumber *)ist{
    
    __block NSNumber *isFirst = ist;
    [T2THttpManager getWithUrl:urlStr success:^(T2TResponse *responseObject) {
        
        if ([responseObject.list isKindOfClass:[NSArray class]] && responseObject.code == kMGOkStatuCode) {
            
            BOOL res = [responseObject.list writeToFile:kFilePathAtDocumentWithName(fileName) atomically:YES];
            if (res) {
                if(block)block(responseObject.list);
                isFirst = [NSNumber numberWithBool:YES];
            }
            
        }else{
         (!block) ?:block(nil);
        }
        
    } failure:^(id error) {
        (!block) ?:block(nil);
    } otherHttpHeader:MGGetOtherHttpHear()];

}


@end
