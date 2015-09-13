//
//  MGClientModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGClientModel : T2TObject
//clientId": 4568,
//"clientName": "中国免税品（集团）有限责任公司-",
//"managerName": "李丹丹",
//"region": "北京市"

@property (nonatomic, assign) int clientId;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) NSString *managerName;
@property (nonatomic, copy) NSString *region;
@end
