//
//  MGTestHomeVC.m
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGTestHomeVC.h"

@interface MGTestHomeVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation MGTestHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测评";
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.height -= kNavBarHeight;
    [self.view addSubview:self.webView];
    [self requestData];
   
}

- (void)requestData{

     [MGLodingView removeFromSuperView:self.view];
    [MGLodingView showLodingViewOn:self.view withEditBlock:nil withRefreshBlock:^{
        [MGLodingView changeLodingViewWithType:lodingViewStateIsLoding withSuperView:self.view];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
    }];
    
    MGUserModel *model = [MGUserModel shareMGUserModel];
    NSMutableDictionary *dicRequest = [NSMutableDictionary dictionaryWithDictionary:MGGetStausDic()];
    
    
    [dicRequest setObject:kUnNilStr(model.userName) forKey:@"userName"];
    
   
    [T2THttpManager getWithUrl:[NSString stringWithFormat:kMGDefaultURL,[@{@"status":dicRequest} JSONString]] success:^(T2TResponse *responseObject) {
        
        if (responseObject.code == kMGOkStatuCode) {
            [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:responseObject.url]]];
        }else{
            [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
        }
        
    } failure:^(id error) {
        [MGLodingView changeLodingViewWithType:lodingViewStateIsFailed withSuperView:self.view];
    } otherHttpHeader:MGGetOtherHttpHear()];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

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
