//
//  MGMsgModel.m
//  Genechain
//
//  Created by mark_zhang on 15/8/19.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMsgModel.h"

@implementation MGMsgModel
+ (void)getNewMsgWithFinishBlock:(T2TObjBlock)objBlock {

//    /pm/appManage!message.action?word={"status":{"userName":"伍然","beanName":"status","parameter":"2","ver":"1.0.0","sessionId":"C254240C1285B11110A0A10005A9CEE1","loginName":"wuran"}}
    
    NSDictionary *dic = @{@"status":MGGetStatusDicHaveUserName()};
    NSString *urlStr = [NSString stringWithFormat:kMGDefaultURL,kMGMessageUrl,[dic JSONString]];
    
    [T2THttpManager getWithUrl:urlStr success:^(T2TResponse *responseObject) {
       
        if (responseObject.code == kMGOkStatuCode && [responseObject.list isKindOfClass:[NSArray class]]) {
            NSMutableArray *arrData = [NSMutableArray array];
            for (NSDictionary *dicInfo in responseObject.list) {
                MGMsgModel *model = [[MGMsgModel alloc] initWithDic:dicInfo];
                [arrData addObject:model];
            }
            NSLog(@"===++====%@",responseObject.list);
            
            (!objBlock) ?:objBlock([arrData copy]);
        } else {
         (!objBlock) ?: objBlock(nil);
        }
        
    } failure:^(id error) {
        (!objBlock) ?: objBlock(nil);
    } otherHttpHeader:MGGetOtherHttpHear()];
}
@end
