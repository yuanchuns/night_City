//
//  T2TAppVersion.m
//  T2TBasicLib
//
//  Created by mark on 14/12/15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TAppVersion.h"

@implementation T2TAppVersion
-(id)init{
    self = [super init];
    if (self) {
        NSString *APP_URL = @"http://itunes.apple.com/lookup";
        NSDictionary *parameter = @{@"id": [NSString stringWithFormat:@"%d",APPID]};
        [T2THttpManager postForOtherWithUrlStr:APP_URL parameter:parameter success:^(id respone) {
            if ([respone isKindOfClass:[NSDictionary class]] && [[respone objectForKey:@"resultCount"] intValue]>0 && [[respone objectForKey:@"results"] isKindOfClass:[NSArray class]] && [[[respone objectForKey:@"results"] objectAtIndex:0] objectForKey:@"version"])
            {
                if (block_appVersion)block_appVersion([[[respone objectForKey:@"results"] objectAtIndex:0] objectForKey:@"version"]);
            }
            else
            {
                if (block_appVersion)block_appVersion(kAppVersion);
            }
        } failure:^(NSError *error) {
            if (block_appVersion) {
                block_appVersion(kAppVersion);
            }
        }];
    }
    return self;
}

-(void)getAppVersionBlock:(T2TTextBlock)block
{
    block_appVersion = block;
}
@end
