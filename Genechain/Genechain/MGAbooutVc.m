//
//  MGAbooutVc.m
//  Genechain
//
//  Created by mark_zhang on 15/8/18.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGAbooutVc.h"

@interface MGAbooutVc ()
@property (weak, nonatomic) IBOutlet UIImageView *imavHead;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblRight;
@property (weak, nonatomic) IBOutlet UILabel *lblSupport;

@property (weak, nonatomic) IBOutlet UIButton *btnVersion;
@end

@implementation MGAbooutVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于";
    
    self.imavHead.image = kImaWithImaName(@"120-1");
     [self.btnVersion setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#46bbf0"]] forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnActionVersion:(id)sender {
    
    [EAPPUnit autoCheckNetToView:self.view];
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
