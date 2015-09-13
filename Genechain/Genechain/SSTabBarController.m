//
//  SSTabBarController.m
//  SSNavTabDemo
//
//  Created by luoluo on 15/6/17.
//  Copyright © 2015年 长沙二三三网络科技有限公司. All rights reserved.
//

#import "SSTabBarController.h"

//
#define kTabBarSelectedTitleColor [UIColor colorWithRed:225 / 255.f green:59 / 255.f blue:41 / 255.f alpha:1.f]
#define kTabBarNormalTitleColor [UIColor colorWithRed:66 / 255.f green:86 / 255.f blue:97 / 255.f alpha:1.f]

@implementation SSTabBarImage

- (id)initWithImageNames:(NSArray *)arrImageName
{
    if (self = [super init]) {
        if (self && [arrImageName isKindOfClass:[NSArray class]]) {
            _imgDefault = arrImageName[0];
            _imgSeleted = arrImageName[1];
        }
    }
    return self;
}

@end

@interface SSTabBarController ()

@end

@implementation SSTabBarController

- (id)initWithViewControllers:(NSArray *)arrViewController imageArray:(NSArray *)arrImg titleArray:(NSArray *)arrTitle
{
    if (self = [super init]) {
        self.viewControllers = arrViewController;
        [self initializeWithImages:arrImg titles:arrTitle];
    }
    return self;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)initializeWithImages:(NSArray *)imgArr titles:(NSArray *)titleArr
{
    
    UIImage *bgImg = [self imageWithColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.9]];
    [self.tabBar setBackgroundImage:bgImg];



    [[UITabBarItem appearanceWhenContainedIn:[SSTabBarController class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : kTabBarNormalTitleColor
                                                        } forState:UIControlStateNormal];
    
    [[UITabBarItem appearanceWhenContainedIn:[SSTabBarController class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#46bbf0"]
                                                        } forState:UIControlStateSelected];
    
    self.tabBar.translucent = YES;
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *vc = self.viewControllers[i];
        SSTabBarImage *imgObj = imgArr[i];
        vc.tabBarItem = [self tabBarItem:titleArr[i] image:imgObj.imgDefault selectedImage:imgObj.imgSeleted];
    }
}

- (UITabBarItem *)tabBarItem:(NSString *)title image:(NSString *)imgName selectedImage:(NSString *)selectedImage
{
    UIImage *sImage = [UIImage imageNamed:selectedImage];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imgName] selectedImage:[sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    item.titlePositionAdjustment = UIOffsetMake(0, -3);
//    item.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);

    return item;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 控制选择
- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return self.selectedViewController.supportedInterfaceOrientations;
    
}


@end
