//
//  MGLoginVC.m
//  Genechain
//
//  Created by mark on 15/7/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGLoginVC.h"

@interface MGLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPsd;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnForgetPwd;
@property (nonatomic ,copy) T2TBacsicBlock blockSuccessLogin;
//@property (nonatomic, assign) BOOL statubarState;
@end

@implementation MGLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户登录";
    
    MGUserModel *model = [MGUserModel shareMGUserModel];
    
    self.txtUserName.text = [model getUserName];
    self.txtPsd.text = [model getPwd];
    [self.btnLogin setBackgroundImage:kMGBtnColorIma forState:UIControlStateNormal];
    UIControl *control = [[UIControl alloc] initWithFrame:self.view.bounds];
    [control addTarget:self.view action:@selector(endEditing:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:control];
    [self.view sendSubviewToBack:control];
    
    if (!self.isHaveBackBtn) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}


+ (MGLoginVC *)getLoginVC{

    return [[[self class] alloc] initWithNibName:@"MGLoginVC" bundle:nil];
}

- (void)setLoginSuccessBlock:(T2TBacsicBlock)successBlock{

    self.blockSuccessLogin = successBlock;
}

- (IBAction)actionBtnLogin:(id)sender {
    
    [self.view endEditing:YES];
    NSString *msg ;

    if (self.txtUserName.text.length == 0) {
        msg = @"用户名为空";
    }else if (self.txtPsd.text.length == 0){
    
        msg = @"密码为空";
    }
    if (msg.length > 0) {
        kAlter(@"提示", msg);
        return;
    }
   
    
   
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
     NSString *pwdOld = [self.txtPsd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
    
    [MGUserManger loginWithUserName:self.txtUserName.text psdStr:pwdOld handleBlock:^(T2TResponse *ron) {
        if (ron) {
            if (ron.code == kMGOkStatuCode) {
                MGUserModel *model = [MGUserModel shareMGUserModel];
                [model saveLoginUserName:self.txtUserName.text pwd:pwdOld];
                [T2TView showOKHUDWithHUD:hub test:@"登陆成功"];
                !self.blockSuccessLogin ?: self.blockSuccessLogin();
                [self navBackAction:nil];
            }else{
             [T2TView showFailHUDWithHUD:hub text:ron.reson];
            }
        }else{
        
            [T2TView showFailHUDWithHUD:hub text:@"登陆失败"];
        }
    }];
    
}

- (IBAction)actionBtnForgetPsd:(id)sender {
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
