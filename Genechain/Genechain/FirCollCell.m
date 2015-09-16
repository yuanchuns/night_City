//
//  FirCollCell.m
//  Genechain
//
//  Created by nextone on 15/9/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "FirCollCell.h"
#import "CommpraiseView.h"
@implementation FirCollCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorWithRed:0.16f green:0.18f blue:0.20f alpha:1.00f];
    
}
//CreateDate = 1442242942;
//GiftNum = 36;
//HeadICON = "http://211.162.55.59/img55.yeds.net/FileSource3/87b955f5-ea93-410b-8a42-3ea405a54345.jpg";
//ID = 358229;
//IsAuthLogo = 0;
//IsShare = 1;
//IsVIPView = 0;
//Msg = "\U82b1\U82b1";
//NickName = "\U66f9\U66f9";
//PicHeight = 480;
//PicWidth = 480;
//PlayNum = 942;
//RID = 358229;
//ReviewNum = 4;
//UID = 5487374;
//VType = 3;
//VideoCoverSmallUrl = "http://211.162.55.59/img50.yeds.net/20150914-cd4c4589-2db3-48d2-b02e-1131cfdd2b4a-cover.jpg?imageView2/1/w/290/h/386";
//VideoCoverUrl = "http://211.162.55.59/img50.yeds.net/20150914-cd4c4589-2db3-48d2-b02e-1131cfdd2b4a-cover.jpg?imageView2/1/w/580/h/774";
//VideoTime = 17;
//VideoUrl = "http://211.162.55.59/img50.yeds.net/20150914-cd4c4589-2db3-48d2-b02e-1131cfdd2b4a.mp4";


-(void)drawRect:(CGRect)rect{
    
    NSMutableArray *imageArr =[NSMutableArray arrayWithObjects:@"gift_num",@"play_num",@"recome_num", nil];
    NSMutableArray *TitleArr =[NSMutableArray arrayWithObjects:kUnNilStr(self.model.GiftNum),kUnNilStr(self.model.PlayNum),kUnNilStr(self.model.ReviewNum), nil];
    CommpraiseView *comm =[[CommpraiseView alloc]initWithFrame:CGRectMake(self.VideoImage.x, self.VideoImage.height+self.VideoImage.y+7, kScreenWidth-10, 20)];
    comm.backgroundColor = [UIColor clearColor];
    [comm initImageViewArr:imageArr  withTitleArr:TitleArr];
    [self addSubview:comm];

    [self.headImage sd_setImageWithURL:[NSURL URLWithString:kUnNilStr(self.model.HeadICON)] placeholderImage:[UIImage imageNamed:@"ico_head_portrait"]];
    self.nameLB.text =kUnNilStr(self.model.NickName);
    self.nameLB.textColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    [self.VideoImage sd_setImageWithURL:[NSURL URLWithString:kUnNilStr(self.model.VideoCoverSmallUrl)] placeholderImage:[UIImage imageNamed:@"trends_wait"]];
    self.contentLB.text = kUnNilStr(self.model.Msg);
    self.contentLB.textColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];

    
}
@end
