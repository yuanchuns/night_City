//
//  MGCommpanyModel.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGCommpanyModel : T2TObject
//"denfineName": "百年基业",
//"denfineValue": "2"
@property (nonatomic, copy) NSString *denfineName;
@property (nonatomic, assign) int denfineValue;
@end
