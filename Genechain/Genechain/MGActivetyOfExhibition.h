//
//  MGActivetyOfExhibition.h
//  Genechain
//
//  Created by mark_zhang on 15/8/6.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface MGActivetyOfExhibition : T2TObject
//"beginDate": "2015-04-23",
//"comments": null,
//"companyId": 2,
//"companyName": "百年基业",
//"content": "",
//"endDate": "2015-04-25",
//"expositionAddress": "",
//"expositionId": 19,
//"expositionName": "2015深圳培训展会",
//"province": "深圳",
//"status": "1",
//"statusName": null
@property (nonatomic, assign) int companyId;
@property (nonatomic, assign) int expositionId;
@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *beginDate;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *expositionAddress;
@property (nonatomic, copy) NSString *expositionName;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *statusName;

@end
