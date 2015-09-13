
#import <UIKit/UIKit.h>

typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,

    buttonTagForget
    
}buttonTag;


@interface GestureViewController : T2TViewController


/**
 *  控制器来源类型
 */
@property (nonatomic, assign) GestureViewControllerType type;

@property (nonatomic, copy) T2TBacsicBlock handleSuccessBlock;

@end
