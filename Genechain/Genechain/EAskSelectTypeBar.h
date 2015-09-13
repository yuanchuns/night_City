//
//  EAskSelectTypeBar.h
//  Examda
//
//  Created by mark on 15/8/10.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    selectedOneBox = 1,
    selectedTwoBox = 2
}selectedType;
typedef void (^EAskSelectTypeBlock)(selectedType type);
static NSString *const EAskSelectTypeBarClassName = @"EAskSelectTypeBar";
@interface EAskSelectTypeBar : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnOneBox;
@property (weak, nonatomic) IBOutlet UIButton *btnTwoBox;
@property (weak, nonatomic) IBOutlet UIView *viewCenter;
@property (weak, nonatomic) IBOutlet UIView *viewLineOne;
@property (weak, nonatomic) IBOutlet UIView *viewLineTwo;
@property (weak, nonatomic) IBOutlet UIView *viewLineBottom;
@property (nonatomic, getter=type) selectedType type;

- (void)setSelectedHandle:(EAskSelectTypeBlock)block;

@end
