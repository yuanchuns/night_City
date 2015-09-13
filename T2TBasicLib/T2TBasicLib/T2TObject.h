//
//  T2TObject.h
//  T2TBasicLib
//
//  Created by mark on 14/12/11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface T2TObject : NSObject
///保留对象自己 在对象无引用情况下使用 使用后需要在应该释放的地方调用releaseSelf
-(id)retainSelf;
//取消对自己的引用 在调用retainSelf后合适的地方使用
-(void)releaseSelf;
//将数据映射到属性
-(id)initWithDic:(NSDictionary *)dict;
//将属性名和对应的值组成字典返回
-(NSDictionary *)dicData;
@end
