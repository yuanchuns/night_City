//
//  MGSelectedActivityVc.h
//  Genechain
//
//  Created by mark_zhang on 15/8/13.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGSchdulePullVc.h"
#import "MGActivityCell.h"
typedef void (^selectedActivityBlock) (id obj,int indexTypeSelected);

@interface MGSelectedActivityVc : MGSchdulePullVc
- (void)setSelectedActivityHandle:(selectedActivityBlock)objBlock;
@end
