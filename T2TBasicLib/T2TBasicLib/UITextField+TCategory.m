//
//  UITextField+TCategory.m
//  TBasicLib
//
//  Created by kevin.huang on 14-9-19.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import "UITextField+TCategory.h"
#import <objc/runtime.h>

@implementation UITextField (TCategory)

static char textDidChangeHandle;

-(void)textFieldDidChange:(id)sender{
    T2TBacsicBlock block = objc_getAssociatedObject(self, &textDidChangeHandle);
    if (block) {
        block();
    }
}

-(void)setTextDidChangeHandle:(T2TBacsicBlock)aBlock{
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    objc_setAssociatedObject(self, &textDidChangeHandle, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
