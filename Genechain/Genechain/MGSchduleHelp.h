//
//  MGSchduleHelp.h
//  Genechain
//
//  Created by mark_zhang on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#ifndef Genechain_MGSchduleHelp_h
#define Genechain_MGSchduleHelp_h

#import "MGSchdulePullVc.h"
#define MGSchduleTextColor_kind_1 [UIColor colorWithHexString:@"#FF8B00"]
#define MGSchduleTextColor_kind_2 [UIColor colorWithHexString:@"#14A5F7"]
#define MGSchduleTextColor_kind_3 [UIColor colorWithHexString:@"#58D62E"]
#define MGSchduleTextColor_kind_4 [UIColor colorWithHexString:@"#FF215D"]
#define MGSchduleTextColor_content [UIColor colorWithHexString:@"#808080"]

NS_INLINE UIColor * getTextColorWithKind(int kind){

    UIColor *color = MGSchduleTextColor_kind_1;
    
    switch (kind) {
        case 2:
            color = MGSchduleTextColor_kind_2;
            break;
        case 3:
            color = MGSchduleTextColor_kind_3;
            break;
        case 4:
            color = MGSchduleTextColor_kind_4;
            break;
            
        default:
            break;
    }
    return color;
}

#endif
