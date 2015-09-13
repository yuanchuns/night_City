//
//  T2TNavController.m
//  T2TBasicLib
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TNavController.h"
#import "T2TBasicLib.h"
@interface T2TNavController ()

@end

@implementation T2TNavController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{

    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self initializeNormalState];
    }
    return self;
}

- (void)initializeNormalState
{
    if (kIsIOS7) {
       
//                self.navigationBar.barTintColor = RGB(225, 59, 41, 1);
        [T2TNavController setNavigationBackRedColor:self];
    }
}


+ (void)setNavigationBackRedColor:(UIViewController *)vc
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    NSDictionary* attrs = @{NSForegroundColorAttributeName:
                                [UIColor whiteColor],
                            NSFontAttributeName:
                                [UIFont fontWithName:@"Helvetica"size:17.0],
                            };
    
    if ([vc isKindOfClass:[T2TNavController class]]) {
        [((T2TNavController *)vc).navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#2c2c2c"]] forBarMetrics:UIBarMetricsDefault];
        [((T2TNavController *)vc).navigationBar setTitleTextAttributes:attrs];
        [((T2TNavController *)vc) setNavigationBarHidden:NO animated:YES];
    } else {
        
        [((T2TNavController *)vc.navigationController).navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#2c2c2c"]] forBarMetrics:UIBarMetricsDefault];
        [((T2TNavController *)vc.navigationController).navigationBar setTitleTextAttributes:attrs];
        vc.navigationItem.leftBarButtonItem = [T2TView backItemWithTarget:self];
        [((T2TNavController *)vc.navigationController) setNavigationBarHidden:NO animated:YES];
    }
    
}


#pragma mark - push pop
// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count >= 1) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];
    
    
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
