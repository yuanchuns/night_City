//
//  MGWebVc.m
//  Genechain
//
//  Created by mark on 15/7/29.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGWebVc.h"

@interface MGWebVc ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation MGWebVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    [self reloadWeb];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUrl:(NSString *)url{
    _url = url;
    [self reloadWeb];
}

- (void)reloadWeb{

    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:kUnNilStr(self.url)]]];
    [MGLodingView removeFromSuperView:self.view];
    [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
        [self performSelector:@selector(reloadWeb) withObject:nil afterDelay:1];
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [MGLodingView removeFromSuperView:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
}

+ (MGWebVc *)getMGWebView{

    return [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
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
