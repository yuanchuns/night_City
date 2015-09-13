//
//  EManggerMsg.h
//  Genechain
//
//  Created by mark_zhang on 15/8/19.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"
#import "MGMsgModel.h"
@interface EManggerMsg : T2TObject

+ (instancetype)shareEManggerMsg;
- (BOOL)deleteOneRecordWithId:(int)msgId;
- (int)addRecordWithArr:(NSArray *)arrMsg;
- (NSArray *)getAllMsgRecord;
- (BOOL)judgeRecordWithId:(int)msgId;
@end
