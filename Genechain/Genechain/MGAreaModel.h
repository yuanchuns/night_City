//
//  MGAreaModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGAreaModel : T2TObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *headCode;
@property (nonatomic, strong) NSMutableArray *arrCitys;
+ (NSArray *)getAreaInfo;
@end
