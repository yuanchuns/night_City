//
//  T2TLocation.m
//  T2TBasicLib
//
//  Created by mark on 14/12/22.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TLocation.h"
#import "Define_basic.h"

@interface T2TLocation ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *manager;

@property(nonatomic,strong)T2TBOOLBlock successBlock;
@end

@implementation T2TLocation

static T2TLocation *locationHander;
+(void)getLocationCityWithFinishBlock:(T2TBasicBlock)block{

    
    [self getLocationCityWithSuccessBlock:^(BOOL res) {
        if (block) {
            block();
        }
    }];
    
}

+(void)getLocationCityWithSuccessBlock:(T2TBOOLBlock)block{

   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationHander = [[T2TLocation alloc]init];
    });
    [locationHander starLocationWithBlock:block];
}

-(void)starLocationWithBlock:(T2TBOOLBlock)block{

    _successBlock  = block;
    _manager = [[CLLocationManager alloc] init];
    [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
    _manager.delegate = self;
    [_manager startUpdatingLocation];

}


-(void)stopLocation{

    if (_manager) {
        [_manager stopUpdatingLocation];
    }
}

+(void)clearLocationInfo{
    
    [kUserDefaults removeObjectForKey:kLocationStateKey];
    [kUserDefaults removeObjectForKey:kLocationDicInfoKey];
    [kUserDefaults removeObjectForKey:kLocationCityKey];
}

#pragma mark - delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    CLLocation * newLocation = locations[0];
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    [geocoder setAccessibilityLanguage:@"CN"];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *mark = [placemarks firstObject];
            //CLLocationCoordinate2D coor = mark.location.coordinate;
            NSDictionary *dicAddInfo = mark.addressDictionary;
            if (dicAddInfo && [dicAddInfo isKindOfClass:[NSDictionary class]]) {
                [kUserDefaults setObject:dicAddInfo forKey:kLocationDicInfoKey];
                if (ValidateDicWithKey_Str(dicAddInfo, @"City")) {
                    [kUserDefaults setObject:dicAddInfo[@"City"] forKey:kLocationCityKey];
                }
                if(ValidateDicWithKey_Str(dicAddInfo, @"State")){
                 [kUserDefaults setObject:dicAddInfo[@"State"] forKey:kLocationStateKey];
                }
                if (self.successBlock)  {self.successBlock(YES);return ;}
            }
            
        }else{
        
         if (self.successBlock)  self.successBlock(NO);
            
        }
        
    }];

   
    [self stopLocation];
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    
    if (self.successBlock)  self.successBlock(NO);
    [self stopLocation];
}


@end
