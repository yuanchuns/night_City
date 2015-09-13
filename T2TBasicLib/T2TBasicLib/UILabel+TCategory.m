//
//  UILabel+TCategory.m
//  TBasicLib
//
//  Created by kevin.huang on 14-10-23.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import "UILabel+TCategory.h"

@implementation UILabel (TCategory)

-(void)setAtsWithStr:(NSString *)str lineGap:(float)lineGap{
    self.attributedText = [T2TCommonAction atsForStr:str lineHeight:(self.height<self.font.pointSize*2+lineGap)?0:lineGap];
}


@end
