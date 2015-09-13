//
//  TTReauestResponse.h
//  TTHttpManager
//
//  Created by mark on 14/12/11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T2TObject.h"
@interface TTReauestResponse :T2TObject
@property (nonatomic,assign) NSUInteger allRows;      //符合条件的总信息数
//@property (nonatomic,strong) id data;
@property(nonatomic,assign)NSUInteger S;//状态码
@property(nonatomic,strong)NSString *msg;//登陆信息
@property(nonatomic,strong)id list;//符合条件的信息
@end
