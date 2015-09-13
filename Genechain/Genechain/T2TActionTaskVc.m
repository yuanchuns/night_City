//
//  T2TActionTaskVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/24.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TActionTaskVc.h"

@interface T2TActionTaskVc ()
@property (weak, nonatomic) IBOutlet RadioGroup *groupView;
@property (weak, nonatomic) IBOutlet RadioBox *boxOne;
@property (weak, nonatomic) IBOutlet RadioBox *boxTwo;
@property (weak, nonatomic) IBOutlet T2TTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (nonatomic, strong) T2TBacsicBlock successBlock;

@end

@implementation T2TActionTaskVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIControl *control = [[UIControl alloc] initWithFrame:self.view.bounds];
    [control addTarget:self action:@selector(actionControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:control];
    [self.view sendSubviewToBack:control];
    
    self.boxOne.text = @"同意";
    self.boxOne.value = 1;
    self.boxTwo.text = @"驳回";
    self.boxTwo.value = 2;
    
    self.groupView.selectValue = 1;
    
    self.textView.placeHolder = @"备注";
    
   [self.btnSure setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#46bbf0"]] forState:UIControlStateNormal];
    [self.btnCancel setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#46bbf0"]] forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

- (void)actionControl {

    [self.view endEditing:YES];
}

- (void)setHandleBlock:(T2TBacsicBlock)successBlock {
    self.successBlock = successBlock;
}

- (IBAction)actionBtnOk:(id)sender {
    //http://223.4.94.140:8091/pm/appTask!p202TaskConfirm.action?word={"userName":"伍然","beanName":"status","parameter":"2","ver":"1.0.0","sessionId":"C254240C1285B11110A0A10005A9CEE1","loginName":"wuran"},"object":{"id":7729,"confirmMsg":"112222","taskerStatus":"1"}}
    [self actionControl];
    
    NSDictionary *dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"id":kStrWithInter(self.taskId),@"confirmMsg":kUnNilStr(self.textView.text),@"taskerStatus":kStrWithInter(self.boxOne.isOn)}};
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [T2THttpManager getWithUrl:[NSString stringWithFormat:kMGDefaultURL,kMGMineScheduleUrl,[dicPost JSONString]] success:^(T2TResponse *responseObject) {
        if (responseObject.code == kMGOkStatuCode) {
            [T2TView showOKHUDWithHUD:hub test:@"确认成功"];
            [self performSelector:@selector(navBackAction:) withObject:nil afterDelay:1];
            (!self.successBlock) ?:self.successBlock();
        } else {
        
            [T2TView showFailHUDWithHUD:hub text:responseObject.reson];
        }
        
    } failure:^(id error) {
        [T2TView showFailHUDWithHUD:hub text:@"处理失败"];
    } otherHttpHeader:MGGetOtherHttpHear()];
    
    
    
}
- (IBAction)actionBtnCancel:(id)sender {
    [self navBackAction:nil];
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
