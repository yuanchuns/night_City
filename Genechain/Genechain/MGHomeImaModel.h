//
//  MGHomeImaModel.h
//  Genechain
//
//  Created by mark on 15/7/29.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"


//轮播图参数
@interface MGHomeImaModel : T2TObject
//describe": "公开课及沙龙",
//"imgUrl": "http://223.4.94.140:8091/pm/down/clientImage/1.jpg",
//"url": "http://www.gene100.com"
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *url;
@end
