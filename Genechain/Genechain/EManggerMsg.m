//
//  EManggerMsg.m
//  Genechain
//
//  Created by mark_zhang on 15/8/19.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EManggerMsg.h"
#import "FMDatabase.h"
@implementation EManggerMsg
{
    
    FMDatabase *_dataBase;
}

+ (instancetype)shareEManggerMsg {

    static EManggerMsg *manger = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        manger = [[[self class] alloc] init];
    });
    
    return manger;
}

- (instancetype)init {

    if (self = [super init]) {
        
        NSString *path = kFilePathAtDocumentWithName([kAppName stringByAppendingString:@".sqlite"]);
        _dataBase = [FMDatabase databaseWithPath:path];
        
//        "createDate": "20150715",
//        "createUser": "admin",
//        "id": 7,
//        "kind": "1",
//        "message": "消息5",
//        "publishDate": "20150815",
//        "readFlag": "0",
//        "title": "标题5",
//        "userId": "wangjin2014"
        NSString *sqMsg = @"create table if not exists msginfo (createDate char(20),createUser text,id integer,kind integer,message text,publishDate char(20),readFlag char(20),title text,userId char(30))";
    
        if ([_dataBase open]) {
            if ([_dataBase executeUpdate:sqMsg]) {
                [TLog log:@"create comtable success!"];
            }else
                [TLog log:@"create comtable failed!"];
            [_dataBase close];
        }

    }
    return self;
}

- (BOOL)deleteOneRecordWithId:(int)msgId {

    if ([_dataBase open]) {
        
        NSString *sql = @"delete from msginfo where id = ?";
        BOOL res =  [_dataBase executeUpdate:sql,@(msgId)];
        [_dataBase close];
        return res;
    }
    return NO;
}

- (int)addRecordWithArr:(NSArray *)arrMsg {
    
    int numOfUpdate = 0;
    if ([_dataBase open]) {
        
        NSString *sql = @"insert into msginfo (createDate,createUser,id,kind,message,publishDate,readFlag,title,userId) values (?,?,?,?,?,?,?,?,?)";
        for (MGMsgModel *model in arrMsg) {
           
            if ([self getNumRecordCountWithId:model._id] == 0) {
             BOOL state = [_dataBase executeUpdate:sql,model.createDate,model.createUser,@(model._id),@(model.kind),model.message,model.publishDate,model.readFlag,model.title,model.userId];
                if (state) {
                    numOfUpdate ++;
                }
            }
        }
    }
    return numOfUpdate;

}

- (int)getNumRecordCountWithId:(int)msgId {

    NSString *sqlFind = @"select COUNT(*) from msginfo where id = ?";
    FMResultSet *set =  [_dataBase executeQuery:sqlFind,[NSNumber numberWithInt:msgId]];
    int num = 0;
    while ([set next]) {
        num = [set intForColumnIndex:0];
    }
    
    return num;
}

- (NSArray *)getAllMsgRecord {
    
    NSMutableArray *arrData = [NSMutableArray array];
    if ([_dataBase open]) {
        NSString *sql = @"select * from msginfo";
        FMResultSet *set =  [_dataBase executeQuery:sql];
        while ([set next]) {
            MGMsgModel *model = [[MGMsgModel alloc] init];
            model.createDate = [set stringForColumn:@"createDate"];
            model.createUser = [set stringForColumn:@"createUser"];
            model._id = [set intForColumn:@"id"];
            model.kind = [set intForColumn:@"kind"];
            model.message = [set stringForColumn:@"message"];
            model.publishDate = [set stringForColumn:@"publishDate"];
            model.readFlag = [set stringForColumn:@"readFlag"];
            model.title = [set stringForColumn:@"title"];
            model.userId = [set stringForColumn:@"userId"];
            [arrData addObject:model];
        }
    }
    
    return [arrData copy];

}

- (BOOL)judgeRecordWithId:(int)msgId {

    if ([_dataBase open]) {
         NSString *sql = @"select * from msginfo where id = ?";
        FMResultSet *set =  [_dataBase executeQuery:sql,@(msgId)];
        [_dataBase close];
        return (set.columnCount > 0);
    }
    return NO;
}


@end
