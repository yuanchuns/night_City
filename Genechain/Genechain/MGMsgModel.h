//
//  MGMsgModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/19.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"


//createDate": "20150715",
//"createUser": "admin",
//"id": 7,
//"kind": "1",
//"message": "消息5",
//"publishDate": "20150815",
//"readFlag": "0",
//"title": "标题5",
//"userId": "wangjin2014"
@interface MGMsgModel : T2TObject
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *createUser;
@property (nonatomic, assign) int _id;
@property (nonatomic, assign) int kind;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, strong) NSString *readFlag;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *userId;
+ (void)getNewMsgWithFinishBlock:(T2TObjBlock)objBlock;
@end
