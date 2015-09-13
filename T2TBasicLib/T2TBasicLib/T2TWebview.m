//
//  T2TWebview.m
//  T2TBasicLib
//
//  Created by mark on 14/12/22.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TWebview.h"
#import "T2TUrlCache.h"

@interface T2TWebview ()
@property(nonatomic,strong)T2TUrlCache *urlCache;
@end
@implementation T2TWebview


//-(instancetype)init{
//
//    if (self = [super init] ) {
//    self.urlCache = [[T2TUrlCache alloc] initWithMemoryCapacity:1*1024*1024 diskCapacity:200*1024*1024 diskPath:nil];
//        [T2TUrlCache setSharedURLCache:self.urlCache];
//    }
//    return self;
//}

//-(instancetype)initWithFrame:(CGRect)frame{
//
//    if (self = [super initWithFrame:frame]) {
//    self.urlCache = [[T2TUrlCache alloc] initWithMemoryCapacity:1*1024*1024 diskCapacity:200*1024*1024 diskPath:nil];
//        [T2TUrlCache setSharedURLCache:self.urlCache];
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
