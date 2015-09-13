//
//  Define_block.h
//  TTHttpManager
//
//  Created by mark on 14/12/11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#ifndef TTHttpManager_Define_block_h
#define TTHttpManager_Define_block_h
#import <UIKit/UIKit.h>
typedef void (^T2TBacsicBlock)(void);
typedef void (^T2TBasicBlock)(void);

typedef void (^T2TBOOLBlock)(BOOL);

typedef void (^T2TIndexBlock)(NSUInteger);
typedef void (^T2TTextBlock)(NSString *);
typedef void (^T2TObjBlock)(id error);
typedef void (^T2TFloatBlock)(float);
typedef bool (^T2TReturnBlock)(void);
typedef void (^T2TIndexWithObjBlock) (NSInteger index,id obj);
typedef void (^T2TDictionaryBlock)(NSDictionary *dict);

typedef id (^TReturnObjectWithOtherObjectBlock)(id);
typedef UIImage *(^TReturnImgWithImgBlock)(UIImage *);
typedef void (^TArrBlock)(NSArray *);
#endif
