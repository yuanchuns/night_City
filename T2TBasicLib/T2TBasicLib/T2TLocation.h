//
//  T2TLocation.h
//  T2TBasicLib
//
//  Created by mark on 14/12/22.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#include "Define_block.h"


#define kLocationCityKey @"locationCityKey"//定位城市的的key
#define kLocationDicInfoKey @"locationDicInfoKey"//定位信息的key
#define kLocationCity [kUserDefaults objectForKey:kLocationCityKey]//定位城市
#define kLocationDicInfo [kUserDefaults objectForKey:kLocationDicInfo]//定位信息
#define kLocationStateKey @"locationStateKey"
#define kLocationState [kUserDefaults objectForKey:kLocationStateKey]//定位的省份

@interface T2TLocation : NSObject

+(void)getLocationCityWithFinishBlock:(T2TBasicBlock)block;
+(void)getLocationCityWithSuccessBlock:(T2TBOOLBlock)block;
+(void)clearLocationInfo;


@end
