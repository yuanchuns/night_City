//
//  MGUserModel.h
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGUserModel : T2TObject
//"loginName": "wuran",
//"mail": "",
//"mobile": "",
//"sessionId": "07BBE780628132983806A861BD6C2355",
//"userId": "118",
//"userName": "伍然
typedef NS_ENUM(NSInteger, MGNetWorkType) {
    
    MGNetWorkWIFIType = 0,
    MGNetWork3GType = 1,
    MGNetWorkNotType = 2,
};
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) MGNetWorkType netTYpe;

- (void)saveLoginUserName:(NSString *)userName pwd:(NSString *)pwd;

-(NSString *)getUserName;
-(NSString *)getPwd;
+(id)shareMGUserModel;
- (void)saveUserInfoWithDic:(NSDictionary *)dicInfo;
@end
