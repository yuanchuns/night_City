//
//  MGDepartmentModel.m
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGDepartmentModel.h"

@implementation MGDepartmentModel
static bool isFirst = NO;

- (id)initWithDic:(NSDictionary *)dict{

    if (self = [super initWithDic:dict]) {
        self.arrChildren = [NSMutableArray array];
    }
    return self;
}
+ (void)getDeptArrListWithObjBlock:(T2TObjBlock)block parentId:(int)parentId{
//    word={"status":{"userName":"伍然","beanName":"status","parameter":"2","ver":"1.0.0","sessionId":"C254240C1285B11110A0A10005A9CEE1","loginName":"wuran"},"object":{"deptName":"","parentId":"6"}}
    NSDictionary *dicInfo = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"":@"deptName",@"":@(parentId)}};
    NSString *urlStr = [NSString stringWithFormat:kMGDefaultURL,kMGDepartmentTypeUrl,[dicInfo JSONString]];
    NSString *fileName = [[urlStr getMd5_32Bit] stringByAppendingString:@".txt"];
    if([[NSFileManager defaultManager] fileExistsAtPath:kFilePathAtDocumentWithName(fileName)] && isFirst){
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:kFilePathAtDocumentWithName(fileName)];
                if(block)block([self analysisListWithArrList:arr parentId:parentId]);
        
    }else{

        [self requestDataWithBlock:block fileName:fileName parentId:parentId withUrlString:urlStr];
    }


}

+ (void)requestDataWithBlock:(T2TObjBlock)objBlock fileName:(NSString *)fileName parentId:(int)parentId withUrlString:(NSString *)urlStr{

    [T2THttpManager getWithUrl:urlStr success:^(T2TResponse *responseObject) {
        if (responseObject.code == kMGOkStatuCode && [responseObject.list isKindOfClass:[NSArray class]]) {
            BOOL res = [responseObject.list writeToFile:kFilePathAtDocumentWithName(fileName) atomically:YES];
            if (res) {
            if(objBlock)objBlock([self analysisListWithArrList:responseObject.list parentId:parentId]);
                isFirst = YES;
            }else{
                (!objBlock) ?:objBlock(nil);
            }

        }else{
            (!objBlock) ?:objBlock(nil);
        }
    } failure:^(id error) {
        (!objBlock) ?:objBlock(nil);
    } otherHttpHeader:MGGetOtherHttpHear()];
}

+ (NSArray *)analysisListWithArrList:(NSArray *)arrList parentId:(int)parentId{

    NSMutableArray *arrData = [NSMutableArray array];
    for (NSDictionary *dicInfo in arrList) {
        MGDepartmentModel *model = [[MGDepartmentModel alloc] initWithDic:dicInfo];
        [arrData addObject:model];
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF.parentId == %d",parentId];
    NSArray *arrNew = [arrData filteredArrayUsingPredicate:pre];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:arrNew];
    
    for (MGDepartmentModel *modelTest in arrData) {
        pre = [NSPredicate predicateWithFormat:@"SELF.parentId == %d",modelTest._id];
        NSArray *new = [arrData filteredArrayUsingPredicate:pre];
        [modelTest.arrChildren addObjectsFromArray:new];
    }
    return [arr copy];
}

@end
