//
//  MGChangePsdVc.m
//  Genechain
//
//  Created by mark on 15/7/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGChangePsdVc.h"

@interface MGChangePsdVc ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textCurPwd;
@property (weak, nonatomic) IBOutlet UITextField *textNewPsd;
@property (weak, nonatomic) IBOutlet UITextField *textTestPsd;
@property (weak, nonatomic) IBOutlet UIView *viewLow;
@property (weak, nonatomic) IBOutlet UIView *viewMid;
@property (weak, nonatomic) IBOutlet UIView *viewHigh;
@property (weak, nonatomic) IBOutlet UILabel *lblTYpe;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;
@property (weak, nonatomic) IBOutlet UIScrollView *scrBack;

@end

@implementation MGChangePsdVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改登陆密码";
    
    self.textCurPwd.delegate = self;
    self.textNewPsd.delegate = self;
    self.textTestPsd.delegate = self;
    self.textTestPsd.secureTextEntry = YES;
    self.textNewPsd.secureTextEntry = YES;
    [self.textCurPwd addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    [self.textNewPsd addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    [self.textTestPsd addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    [self.btnOk setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#c2c2c2"]] forState:UIControlStateNormal];
    self.btnOk.userInteractionEnabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
    UIControl *control = [[UIControl alloc] initWithFrame:self.view.bounds];
    [control addTarget:self.view action:@selector(endEditing:) forControlEvents:UIControlEventTouchUpInside];
    [self.textCurPwd.superview addSubview:control];
    [self.textCurPwd.superview sendSubviewToBack:control];
    [self changePsdViewWithPsdRank:0];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)actionBtnOk:(id)sender {
    [self.view endEditing:YES];
//     http://223.4.94.140:8091/pm/appPerson.do?method=updateLoginPwdByOld&word={"status":{"userName":"伍然","beanName":"status","parameter":"2","ver":"1.0.1","sessionId":"EA76AD3DAA4A9BB62BF0B453C871F06F","loginName":"wuran"},"object":{"newPwd":"5eQSLnQMCRI=","oldPwd":"8lUzk85Ky98=","loginName":"wuran"}}
    
    if ([self.textCurPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [T2TView showFailHUDWithText:@"请输入原密码"];
        return;
    } else if (![[self.textNewPsd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:[self.textTestPsd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]){
        [T2TView showFailHUDWithText:@"两次输入的密码不一致"];
        return;
    }
    
//    NSDate *today = [NSDate date];
//    NSCalendar *gregorian = [NSCalendar currentCalendar];
//    NSDateComponents *dateComm = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit   fromDate:today];
    NSString *pwdKey = @"gene2015!";
    NSString *pwdNew = [self.textNewPsd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *pwdOld = [self.textCurPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    MGUserModel *model = [MGUserModel shareMGUserModel];
    NSString *pwdNewWord =[DES encryptUseDES:pwdNew key:pwdKey];
    NSString *pwdOldWord=[DES encryptUseDES:pwdOld key:pwdKey];
    NSString* changePwdNew = [pwdNewWord stringByReplacingOccurrencesOfString:@"+" withString:@"2B%"];
    NSString *changePwdOld = [pwdOldWord stringByReplacingOccurrencesOfString:@"+" withString:@"2B%"];
    
    NSDictionary *dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"loginName":kUnNilStr(model.loginName),@"newPwd":changePwdNew,@"oldPwd":changePwdOld}};
    
    NSLog(@"===++++==%@",dicPost);
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [T2THttpManager getWithUrl:[NSString stringWithFormat:kMGDefaultURL,kMGChangePwdUrl,[dicPost JSONString]] success:^(T2TResponse *responseObject) {
        if(responseObject.code == kMGOkStatuCode) {
            [T2TView showOKHUDWithHUD:hub test:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [T2TView showFailHUDWithHUD:hub text:responseObject.reson];
        };
        
    } failure:^(id error) {
       [T2TView showFailHUDWithHUD:hub text:@"网络错误"];
    } otherHttpHeader:MGGetStatusDicHaveUserName()];
    
}


- (void)keyBoardWillHide{

    [self.scrBack setContentOffset:CGPointZero animated:YES];
    
}

- (void) textFiledChange:(UITextField *)textField {

    if (self.textTestPsd.text.length > 0 && self.textNewPsd.text.length >0 && self.textCurPwd.text.length > 0) {
        [self.btnOk setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#46bbf0"]] forState:UIControlStateNormal];
        self.btnOk.userInteractionEnabled = YES;
    }else{
        [self.btnOk setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#c2c2c2"]] forState:UIControlStateNormal];
        self.btnOk.userInteractionEnabled = NO;
    }

    
    if (textField == self.textNewPsd && textField.text.length > 0) {
        
        if (textField.text.length > 0) {
         [self changePsdViewWithPsdRank:[NSString judgePasswordStrength:textField.text]];
        } else {
         [self changePsdViewWithPsdRank:0];
        }
    }
}

#pragma mark - textFiedDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
  
    if (textField == self.textTestPsd) {
        [self.scrBack setContentOffset:CGPointMake(0, 40) animated:YES];
    }
    return  YES;
}



- (void)changePsdViewWithPsdRank:(psdRank)rank{
 
    UIColor *lightColor = [UIColor redColor];
     UIColor *Color = [UIColor colorWithHexString:@"#f2f2f2"];
    switch (rank) {
        case psdLowRank:
        {
            self.lblTYpe.hidden = NO;
            self.viewLow.backgroundColor = lightColor;
            self.viewMid.backgroundColor = Color;
            self.viewHigh.backgroundColor = Color;
            self.lblTYpe.text = @"低";
        }
            break;
        case psdMidRank:{
            self.lblTYpe.hidden = NO;
            self.viewLow.backgroundColor = lightColor;
            self.viewMid.backgroundColor = lightColor;
            self.viewHigh.backgroundColor = Color;
            self.lblTYpe.text = @"中";
        }
            break;
        case psdHighRank:{
            self.lblTYpe.hidden = NO;
            self.viewLow.backgroundColor = lightColor;
            self.viewMid.backgroundColor = lightColor;
            self.viewHigh.backgroundColor = lightColor;
            self.lblTYpe.text = @"高";
        }
            break;
            
        default:{
            self.lblTYpe.hidden = YES;
            self.viewLow.backgroundColor = Color;
            self.viewMid.backgroundColor = Color;
            self.viewHigh.backgroundColor = Color;
        }
            break;
    }
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
