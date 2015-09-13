//
//  DES.h
//  Genechain
//
//  Created by mark_zhang on 15/8/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TObject.h"

@interface DES : T2TObject
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密
+ (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
@end
