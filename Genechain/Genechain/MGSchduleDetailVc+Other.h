//
//  MGSchduleDetailVc+Other.h
//  Genechain
//
//  Created by mark_zhang on 15/8/8.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSchduleDetailVc.h"
static CGFloat const MgSchduleDetailCellHeight = 48;
@interface MGSchduleDetailVc (Other)
- (NSString *)getFirstLineFirBoxStr;
- (NSString *)getFirstLineSecBoxStr;
- (NSString *)getSecondLineFirBoxStr;
- (NSString *)getSecondLineSecBoxStr;
- (NSString *)getThiredLineStr;
- (NSString *)getFourLineStr;
- (NSString *)getFiveLineStr;
- (NSString *)getSixLineFirBoxStr;
- (NSString *)getSixLineSecBoxStr;

- (CGFloat) getSecLineHeight;
- (CGFloat) getThiredLineHeight;
- (CGFloat) getFourLineHeight;
- (CGFloat) getFiveLineHeight;

@end
