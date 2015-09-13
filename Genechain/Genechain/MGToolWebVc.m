//
//  MGTestWebVc.m
//  Genechain
//
//  Created by mark_zhang on 15/7/30.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGToolWebVc.h"

@interface MGToolWebVc ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation MGToolWebVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    [self reloadWeb];
    // Do any additional setup after loading the view.
}

-(void)navBackAction:(UIBarButtonItem *)backBar{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.35;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)setUrl:(NSString *)url{
    _url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self reloadWeb];
}

- (void)reloadWeb{
    
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:kUnNilStr(self.url)]]];
//    [MGLodingView removeFromSuperView:self.view];
    [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
        [self performSelector:@selector(reloadWeb) withObject:nil afterDelay:1];
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.height = kScreenHeight - (kNavBarHeight + self.tabBarController.tabBar.height);
    [MGLodingView removeFromSuperView:self.view];
    //    [webView sizeToFit];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
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
