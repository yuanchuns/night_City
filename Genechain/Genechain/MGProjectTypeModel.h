//
//  MGProjectTypeModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGProjectTypeModel : T2TObject
@property (nonatomic, assign) int kindId;
@property (nonatomic, copy) NSString *kindName;


@property(nonatomic,copy)NSString *denfineName;
@property(nonatomic,assign)int denfineValue;
@end
