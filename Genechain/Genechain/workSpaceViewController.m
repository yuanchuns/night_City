//
//  workSpaceViewController.m
//  Genechain
//
//  Created by nextone on 15/8/28.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "workSpaceViewController.h"
#import "WorkTableViewCell.h"
#import "WorkSecondTableViewCell.h"
#import "costViewController.h"
#import "SearchViewController.h"
#import "workMode.h"
#import "MGSchudleDetailModel.h"
#import "YCButton.h"
#import "MJRefresh.h"
@interface workSpaceViewController ()< UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UITableView *TBTableView;
@property (strong, nonatomic)  UIButton *alreadyButton;
@property (strong, nonatomic)  UIButton *untreatedButton;

@property (strong, nonatomic)  UIButton *travelButton;
@property (strong, nonatomic)  UIButton *bookButton;


@property(nonatomic,strong)UITableView *TBSecondTableView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)NSMutableArray *arrDataSecond;

@property(nonatomic,strong)NSMutableArray *BookArrData;
@property(nonatomic,strong)NSMutableArray *BookArrDataSecond;


@property(nonatomic,strong)MGSchudleDetailModel *model;
@property(nonatomic)BOOL isBook;

@property(nonatomic)int page;
@property(nonatomic)int pageSec;
@property(nonatomic)int pageThree;
@property(nonatomic)int pageFour;
@property(nonatomic)int pageFive;
@property(nonatomic)int pageSix;
@property(nonatomic)int pageSeven;
@property(nonatomic)int pageEight;
//@property(nonatomic)int count;

@property(nonatomic)BOOL isRefsh;


@end

@implementation workSpaceViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isBook) {
        self.pageFive=1;
        self.pageSix=1;
        [self request_BookListDelaWithList_connection:0];
        
        }else{
            self.page=1;
            self.pageSec=1;
            [self request_DealWithList_connection:0];
        }
}

- (void)refresh{
    __weak workSpaceViewController *block_self = self;
    [self.TBTableView addHeaderWithCallback:^{
        block_self.isRefsh=YES;

        if (block_self.isBook) {
            block_self.pageFive=1;
            block_self.pageSix=1;
            if ([block_self.model.isSearch integerValue]==1) {
                [block_self request_BookListDelaWithList_connection:1];
            }else{
                [block_self request_BookListDelaWithList_connection:0];
            }
        }else{
            block_self.page=1;
            block_self.pageSec=1;
            if ([block_self.model.isSearch integerValue]==1) {
                [block_self request_DealWithList_connection:1];
            }else{
                [block_self request_DealWithList_connection:0];
            }
        }
    }];
    [self.TBTableView addFooterWithCallback:^{
        block_self.isRefsh=YES;
        if (block_self.isBook) {
            if ([block_self.model.isSearch integerValue]==1) {
                [block_self request_BookListDelaWithList_connection:1];
            }else{
                [block_self request_BookListDelaWithList_connection:0];
            }
            
        }else{
            if ([block_self.model.isSearch integerValue]==1) {
                [block_self request_DealWithList_connection:1];
            }else{
                [block_self request_DealWithList_connection:0];
            }
            
        }
    }];
    
    [self.TBSecondTableView addHeaderWithCallback:^{
        block_self.isRefsh=YES;

        if (block_self.isBook) {
            block_self.pageSeven=1;
            block_self.pageEight=1;
            if ([block_self.model.isSearch integerValue]==1) {
                [block_self request_BookListDelaWithListFinish_connection:1];
            }else{
                [block_self request_BookListDelaWithListFinish_connection:0];
            }
        }else{
            block_self.pageThree=1;
            block_self.pageFour=1;
            if ([block_self.model.isSearch integerValue]==1) {
                [block_self request_DealWithListFinish_connection:1];
            }else{
                [block_self request_DealWithListFinish_connection:0];
            }
            
        }
    }];
    [self.TBSecondTableView addFooterWithCallback:^{
        block_self.isRefsh=YES;

        if (block_self.isBook) {
            if ([block_self.model.isSearch integerValue]==1) {
                [block_self request_BookListDelaWithListFinish_connection:1];
            }else{
                [block_self request_BookListDelaWithListFinish_connection:0];
            }
            
        }else{
            if ([block_self.model.isSearch integerValue]==1) {
                [block_self request_DealWithListFinish_connection:1];
            }else{
                [block_self request_DealWithListFinish_connection:0];
            }
            
        }
    }];
    
}
-(void)initPageSize{
    self.page =1;
    self.pageSec=1;
    self.pageThree=1;
    self.pageFour=1;
    self.pageFive =1;
    self.pageSix=1;
    self.pageSeven=1;
    self.pageEight=1;
    self.arrData = [NSMutableArray array];
    self.arrDataSecond =[NSMutableArray array];
    
    self.BookArrData =[NSMutableArray array];
    self.BookArrDataSecond=[NSMutableArray array];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPageSize];
    // Do any additional setup after loading the view from its nib.
    self.title = @"差旅费";
    
    self.model =[[MGSchudleDetailModel alloc] init];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame: CGRectMake(10, 0, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"schedule_type_button_focus"] forState:UIControlStateNormal];
    rightButton.tag=1000001;
    [rightButton addTarget:self action:@selector(actionRightBarAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
    
    self.alreadyButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0, 0, kScreenWidth/2, 34);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTintColor:[UIColor colorWithHexString:@"#666666"]];
        [btn setTitle:@"未处理" forState:UIControlStateNormal];
        btn.tag = 1001;
        [btn addTarget:self action:@selector(btnClickACtion:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4-50, self.alreadyButton.y+self.alreadyButton.height-1, 100, 1)];
    imageView.backgroundColor = [UIColor orangeColor];
    self.imageView =imageView;
    [self.view addSubview:self.imageView];
    
    
    
    self.untreatedButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 34);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"已处理" forState:UIControlStateNormal];
        [btn setTintColor:[UIColor colorWithHexString:@"#666666"]];
        btn.tag = 1002;
        [btn addTarget:self action:@selector(btnClickACtion:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.frame = CGRectMake(0, 34, kScreenWidth, kScreenHeight-140);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize =CGSizeMake(kScreenWidth*2,kScreenHeight-140);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];
    
    
    
    
    self.TBTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.scrollView.height+10) style:UITableViewStyleGrouped];
    self.TBTableView.delegate=self;
    self.TBTableView.dataSource= self;
    self.TBTableView.separatorStyle = NO;
    self.TBTableView.scrollsToTop=YES;
    [self.scrollView addSubview:self.TBTableView];
    
    
    
    self.TBSecondTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollView.height+10) style:UITableViewStyleGrouped];
    self.TBSecondTableView.delegate=self;
    self.TBSecondTableView.dataSource= self;
    self.TBSecondTableView.separatorStyle = NO;
    self.TBSecondTableView.scrollsToTop=YES;
    [self.scrollView addSubview:self.TBSecondTableView];
    
     
    //使用UIButton的子类
    YCButton *sButton=[[YCButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-120, kScreenWidth/2, 60)];
    [sButton setTitle:@"差旅" forState:UIControlStateNormal];
    sButton.titleLabel.font  =[UIFont systemFontOfSize:12.0];
    [sButton setImage:[UIImage imageNamed:@"flight_plan_focus_90.png"] forState:UIControlStateNormal];
    [sButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [sButton addTarget:self action:@selector(btnClickACtion:) forControlEvents:UIControlEventTouchUpInside];
    sButton.tag =1009;
    self.travelButton = sButton;
    [self.view addSubview:self.travelButton];
    
    
    YCButton *nButton=[[YCButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight-120, kScreenWidth/2, 60)];
    [nButton setTitle:@"教具" forState:UIControlStateNormal];
    [nButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [nButton addTarget:self action:@selector(btnClickACtion:) forControlEvents:UIControlEventTouchUpInside];
    nButton.titleLabel.font  =[UIFont systemFontOfSize:12.0];
    [nButton setImage:[UIImage imageNamed:@"flight_express_normel_90.png"] forState:UIControlStateNormal];
    nButton.tag=1010;
    self.bookButton = nButton;
    [self.view addSubview:self.bookButton];
        
    //差旅未处理
    [self request_DealWithList_connection:0];
    //差旅已处理
    [self  request_DealWithListFinish_connection:0];
    //教具未处理
    [self  request_BookListDelaWithList_connection:0];
    //教具已处理
    [self  request_BookListDelaWithListFinish_connection:0];
    
    if (self.isBookMessage) {
        self.isBook=YES;
        self.title =@"教具";
        [self.TBSecondTableView reloadData];
        [self.TBTableView reloadData];
    }
    [self refresh];
}
-(void)btnClickACtion:(UIButton *)button{
    
    if (button.tag==1001) {
        [UIView animateWithDuration:0.3f delay:0.1f options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             self.imageView.frame =CGRectMake(kScreenWidth/4-50, self.alreadyButton.y+self.alreadyButton.height-1, 100, 1);
         } completion:nil];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        
    }else if (button.tag==1002){
        [UIView animateWithDuration:0.3f delay:0.1f options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             self.imageView.frame =CGRectMake(kScreenWidth/2+30, self.alreadyButton.y+self.alreadyButton.height-1, 100, 1);
             
         } completion:nil];
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        
        
    }else if (button.tag==1009){
        self.isBook=NO;
        self.title =@"差旅费";
        [self.travelButton setImage:[UIImage imageNamed:@"flight_plan_focus_90.png"] forState:UIControlStateNormal];
        [self.bookButton setImage:[UIImage imageNamed:@"flight_express_normel_90.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3f delay:0.1f options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             self.imageView.frame =CGRectMake(kScreenWidth/4-50, self.alreadyButton.y+self.alreadyButton.height-1, 100, 1);
         } completion:nil];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.TBSecondTableView reloadData];
        [self.TBTableView reloadData];
        
    }else if (button.tag==1010){
        self.isBook=YES;
        self.title =@"教具";
        [self.travelButton setImage:[UIImage imageNamed:@"flight_plan_normel_90.png"] forState:UIControlStateNormal];
        [self.bookButton setImage:[UIImage imageNamed:@"flight_express_focus_90.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3f delay:0.1f options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             self.imageView.frame =CGRectMake(kScreenWidth/4-50, self.alreadyButton.y+self.alreadyButton.height-1, 100, 1);
         } completion:nil];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.TBSecondTableView reloadData];
        [self.TBTableView reloadData];
        
    }
}
-(void)actionRightBarAction{
    __weak workSpaceViewController *weakBlocks =self;
    SearchViewController *vc = [[SearchViewController alloc] init];
    T2TNavController *nav = getNavWithVc(vc);
    if (self.scrollView.contentOffset.x/kScreenWidth==0) {
        if (self.isBook) {
            vc.type=@"10003";
        }else{
            vc.type=@"10001";
        }
    }else{
        if (self.isBook) {
            vc.type=@"10004";
            
        }else{
            vc.type=@"10002";
        }
    }
    vc.isBook =self.isBook;
    vc.DtepName= self.model.deptName;
    vc.answerBlock = ^(MGSchudleDetailModel *model){
        weakBlocks.model.userName =model.userName;
        weakBlocks.model.deptId = model.deptId;
        weakBlocks.model.deptName = model.deptName;
        weakBlocks.model.startDate = model.startDate;
        weakBlocks.model.clientName = model.clientName;
        weakBlocks.model.taskName =model.taskName;
        weakBlocks.model.subjectId =model.subjectId;
        weakBlocks.model.isSearch  = model.isSearch;
        if (model.deptId==0) {
            weakBlocks.model.deptIds = @" ";
        }else{
            weakBlocks.model.deptIds = [NSString stringWithFormat:@"%d",model.deptId];
        }
        if ([model.type integerValue]==10001) {
            //差旅未处理查询
            self.pageSec=1;
            [weakBlocks request_DealWithList_connection:1];
        }else if ([model.type integerValue]==10002){
            self.pageFour=1;

            //差旅已处理查询
            [weakBlocks request_DealWithListFinish_connection:1];
            
        }else if ([model.type integerValue]==10003){
            //教具未处理查询
            self.pageSix=1;

            [weakBlocks request_BookListDelaWithList_connection:1];
            
        }else if ([model.type integerValue]==10004){
            //教具已处理查询
            self.pageEight=1;

            [weakBlocks request_BookListDelaWithListFinish_connection:1];
        }
    };
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}
#pragma -mark 差旅未处理
-(void)request_DealWithList_connection:(NSInteger)type{
//    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
//    if (type==1) {
//        if (![self.model.subjectId isEqualToString:[user objectForKey:@"tpye"]]) {
//            [user setObject:self.model.subjectId forKey:@"tpye"];
//            [user synchronize];
//        }
//    }
    __weak workSpaceViewController *block_self = self;
    NSDictionary *dicPost;
    if (type==0) {
        dicPost= @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"yearMonth":@"",@"deptId":@"",@"pageNo":kStrWithInter(self.page),@"employeeName":@"",@"passengerName":@"",@"subjectId":@""}};
        
    }else{
        dicPost= @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"yearMonth":kUnNilStr(self.model.startDate),@"deptId":kUnNilStr(self.model.deptIds),@"pageNo":kStrWithInter(self.pageSec),@"employeeName":kUnNilStr(self.model.taskName),@"passengerName":kUnNilStr(self.model.clientName),@"subjectId":kUnNilStr(self.model.subjectId)}};
        
    }
    
    NSLog(@"===++===%@",dicPost);
    NSString *url = [NSString stringWithFormat:kMGDefaultURL,kMGAirplanScheduleUrl,[dicPost JSONString]];
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [T2THttpManager getWithUrl:url success:^(T2TResponse *responseObject) {
        [hub hide:YES];
        NSArray *totalArr = [NSArray arrayWithArray:responseObject.list];

        if (type==0) {
            if (responseObject.code == kMGOkStatuCode) {
                block_self.TBTableView.hidden=NO;
                if (block_self.page == 1) {
                    [block_self.arrData removeAllObjects];
                }
                for (NSDictionary *dicInfo in responseObject.list) {
                    workMode *model = [[workMode alloc] initWithDic:dicInfo];
                    [block_self.arrData addObject:model];
                    [T2TFailedView  removeFromView:self.TBTableView];

                }
            } else {
                
                if (block_self.isRefsh) {
                    if(totalArr.count == 0)
                    {
                        [block_self.TBTableView footerEndRefreshing];
                        [block_self.TBTableView headerEndRefreshing];
                        [T2TView showFailHUDWithText:@"数据已经加载完毕"];
                        block_self.isRefsh=NO;
                        return ;
                    }
                    
                }else{
                
                    if ([responseObject.reson isEqualToString:@"not data"]) {
                        [block_self.arrData removeAllObjects];
                        [block_self.TBTableView reloadData];
                        [T2TFailedView showFailedInView:block_self.TBTableView response:responseObject arrData:block_self.arrData withRefreshBlock:^{
                            [T2TFailedView removeFromView:block_self.TBTableView];
                            [block_self request_DealWithList_connection:0];
                        } editFailedView:^(T2TFailedView *failedView) {
                            if(block_self.failedViewBlock)block_self.failedViewBlock(failedView);
                        }];
                    }
                    [block_self.TBTableView footerEndRefreshing];
                    [block_self.TBTableView headerEndRefreshing];
                    return ;
                }
            }
            block_self.page++;
            [block_self.TBTableView reloadData];
            [block_self.TBTableView footerEndRefreshing];
            [block_self.TBTableView headerEndRefreshing];
            NSLog(@"responseObject===%@",responseObject);
        }else{
            if (responseObject.code == kMGOkStatuCode) {
                block_self.TBTableView.hidden=NO;
                
                if (block_self.pageSec == 1) {
                    [block_self.arrData removeAllObjects];
                }
                for (NSDictionary *dicInfo in responseObject.list) {
                    workMode *model = [[workMode alloc] initWithDic:dicInfo];
                    [block_self.arrData addObject:model];
                    [T2TFailedView  removeFromView:self.TBTableView];
                }
                
            } else {
                
                if (block_self.isRefsh) {
                    if(totalArr.count == 0)
                    {
                        block_self.isRefsh=NO;
                        [block_self.TBTableView footerEndRefreshing];
                        [block_self.TBTableView headerEndRefreshing];
                        [T2TView showFailHUDWithText:@"数据已经加载完毕"];
                       // return ;
                    }
 
                }else{
                
                if ([responseObject.reson isEqualToString:@"not data"]) {
                    [block_self.arrData removeAllObjects];
                    [block_self.TBTableView reloadData];
                    [T2TFailedView showFailedInView:block_self.TBTableView response:responseObject arrData:block_self.arrData withRefreshBlock:^{
                        [T2TFailedView removeFromView:block_self.TBTableView];
                        [block_self request_DealWithList_connection:1];
                    } editFailedView:^(T2TFailedView *failedView) {
                        if(block_self.failedViewBlock)block_self.failedViewBlock(failedView);
                    }];
                }
                [block_self.TBTableView footerEndRefreshing];
                [block_self.TBTableView headerEndRefreshing];
                //return ;
               }
            }
            
            block_self.pageSec++;
            [block_self.TBTableView reloadData];
            [block_self.TBTableView footerEndRefreshing];
            [block_self.TBTableView headerEndRefreshing];
            NSLog(@"responseObject===%@",responseObject);
        }
        
    } failure:^(id error) {
        [hub hide:YES];
        [block_self.TBTableView footerEndRefreshing];
        [block_self.TBTableView headerEndRefreshing];
        [T2TView showFailHUDWithHUD:hub text:error];
        NSLog(@"error===%@",error);
    } otherHttpHeader:MGGetOtherHttpHear()];
}


#pragma -mark   差旅已处理
-(void)request_DealWithListFinish_connection:(NSInteger)type{
    
//    if (type==1) {
//        NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
//        
//        NSLog(@"%@======+++===%@",self.model.subjectId,[user objectForKey:@"tpyeTow"]);
//        if (![self.model.subjectId isEqualToString:[user objectForKey:@"tpyeTow"]]) {
//            self.pageFour=1;
//            [user setObject:self.model.subjectId forKey:@"tpyeTow"];
//            [user synchronize];
//        }
//    }
    __weak workSpaceViewController *block_self = self;
    NSDictionary *dicPost;
    if (type==0) {
        dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"yearMonth":@"",@"deptId":@"",@"pageNo":kStrWithInter(self.pageThree),@"employeeName":@"",@"passengerName":@"",@"subjectId":@""}};
    }else{
        dicPost= @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"yearMonth":kUnNilStr(self.model.startDate),@"deptId":kUnNilStr(self.model.deptIds),@"pageNo":kStrWithInter(self.pageFour),@"employeeName":kUnNilStr(self.model.taskName),@"passengerName":kUnNilStr(self.model.clientName),@"subjectId":kUnNilStr(self.model.subjectId)}};
    }
    NSLog(@"==+++===%@", dicPost);
    NSString *url = [NSString stringWithFormat:kMGDefaultURL,kMGNotAirplanScheduleUrl,[dicPost JSONString]];
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [T2THttpManager getWithUrl:url success:^(T2TResponse *responseObject) {
        [hub hide:YES];
        NSArray *totalArr = [NSArray arrayWithArray:responseObject.list];

        if (type==0) {
            if (responseObject.code == kMGOkStatuCode) {
                block_self.TBSecondTableView.hidden=NO;
                if (block_self.pageThree == 1) {
                    [block_self.arrDataSecond removeAllObjects];
                }
                for (NSDictionary *dicInfo in responseObject.list) {
                    workModeSecond *model = [[workModeSecond alloc] initWithDic:dicInfo];
                    [block_self.arrDataSecond addObject:model];
                    [T2TFailedView  removeFromView:self.TBSecondTableView];

                }
            } else {
                
                if (block_self.isRefsh) {
                    if(totalArr.count == 0)
                    {
                        [block_self.TBSecondTableView footerEndRefreshing];
                        [block_self.TBSecondTableView headerEndRefreshing];
                        [T2TView showFailHUDWithText:@"数据已经加载完毕"];
                        block_self.isRefsh=NO;
                        return ;
                    }
                    
                }else{
                    
                    if ([responseObject.reson isEqualToString:@"not data"]) {
                        [block_self.arrDataSecond removeAllObjects];
                        [block_self.TBSecondTableView reloadData];
                        [T2TFailedView showFailedInView:block_self.TBSecondTableView response:responseObject arrData:block_self.arrDataSecond withRefreshBlock:^{
                            [T2TFailedView removeFromView:block_self.TBSecondTableView];
                            [block_self request_DealWithListFinish_connection:0];
                        } editFailedView:^(T2TFailedView *failedView) {
                            if(block_self.failedViewBlock)block_self.failedViewBlock(failedView);
                        }];
                    }
                    [block_self.TBSecondTableView footerEndRefreshing];
                    [block_self.TBSecondTableView headerEndRefreshing];
                    return ;
                }
            }
            block_self.pageThree++;
            [self.TBSecondTableView reloadData];
            [block_self.TBSecondTableView footerEndRefreshing];
            [block_self.TBSecondTableView headerEndRefreshing];
            NSLog(@"responseObject===%@",responseObject);
            
        }else{
            if (responseObject.code == kMGOkStatuCode) {
                block_self.TBSecondTableView.hidden=NO;
                if (block_self.pageFour == 1) {
                    [block_self.arrDataSecond removeAllObjects];
                }
                for (NSDictionary *dicInfo in responseObject.list) {
                    workModeSecond *model = [[workModeSecond alloc] initWithDic:dicInfo];
                    [block_self.arrDataSecond addObject:model];
                    [T2TFailedView  removeFromView:self.TBSecondTableView];

                }
            } else {
                
                if (block_self.isRefsh) {
                    if(totalArr.count == 0)
                    {
                        [block_self.TBSecondTableView footerEndRefreshing];
                        [block_self.TBSecondTableView headerEndRefreshing];
                        [T2TView showFailHUDWithText:@"数据已经加载完毕"];
                        block_self.isRefsh=NO;
                        return ;
                    }
                    
                }else{
                    
                    if ([responseObject.reson isEqualToString:@"not data"]) {
                        [block_self.arrDataSecond removeAllObjects];
                        [block_self.TBSecondTableView reloadData];
                        [T2TFailedView showFailedInView:block_self.TBSecondTableView response:responseObject arrData:block_self.arrDataSecond withRefreshBlock:^{
                            [T2TFailedView removeFromView:block_self.TBSecondTableView];
                            [block_self request_DealWithListFinish_connection:1];
                        } editFailedView:^(T2TFailedView *failedView) {
                            if(block_self.failedViewBlock)block_self.failedViewBlock(failedView);
                        }];
                    }
                    [block_self.TBSecondTableView footerEndRefreshing];
                    [block_self.TBSecondTableView headerEndRefreshing];
                    return ;
                }
            }
            block_self.pageFour++;
            [block_self.TBSecondTableView reloadData];
            [block_self.TBSecondTableView footerEndRefreshing];
            [block_self.TBSecondTableView headerEndRefreshing];
            NSLog(@"responseObject===%@",responseObject);
        }
        
    } failure:^(id error) {
        [hub hide:YES];
        [block_self.TBSecondTableView footerEndRefreshing];
        [block_self.TBSecondTableView headerEndRefreshing];
        [T2TView showFailHUDWithHUD:hub text:error];
    } otherHttpHeader:MGGetOtherHttpHear()];
}

#pragma -mark  教具未处理列表

-(void)request_BookListDelaWithList_connection:(NSInteger)type{
//    if (type==1) {
//        NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
//        if ([self.model.startDate isEqualToString:[user objectForKey:@"typeThree"]]) {
//            
//        }else{
//            self.pageSix=1;
//            [user setObject:self.model.subjectId forKey:@"typeThree"];
//            [user synchronize];
//        }
//    }
    __weak workSpaceViewController *block_self = self;
    NSDictionary *dicPost;
    if (type==0) {
        dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"yearMonth":@"",@"deptId":@"",@"pageNo":kStrWithInter(self.pageFive),@"employeeName":@""}};
        
    }else{
        dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"yearMonth":kUnNilStr(self.model.startDate),@"deptId":kUnNilStr(self.model.deptIds),@"pageNo":kStrWithInter(self.pageSix),@"employeeName":kUnNilStr(self.model.clientName)}};
    }
    NSLog(@"==+++===%@", dicPost);
    
    NSString *url = [NSString stringWithFormat:kMGDefaultURL,kMGDelaWithBookListScheduleUrl,[dicPost JSONString]];
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [T2THttpManager getWithUrl:url success:^(T2TResponse *responseObject) {
        [hub hide:YES];
        NSArray *totalArr = [NSArray arrayWithArray:responseObject.list];

        if (type==0) {
            if (responseObject.code == kMGOkStatuCode) {
                
                block_self.TBTableView.hidden=NO;
                if (block_self.pageFive == 1) {
                    [block_self.BookArrData removeAllObjects];
                }
                
                for (NSDictionary *dicInfo in responseObject.list) {
                    bookMode *model = [[bookMode alloc] initWithDic:dicInfo];
                    [self.BookArrData addObject:model];
                    [T2TFailedView  removeFromView:self.TBTableView];

                }
            } else {
                
                if (block_self.isRefsh) {
                    if(totalArr.count == 0)
                    {
                        [block_self.TBTableView footerEndRefreshing];
                        [block_self.TBTableView headerEndRefreshing];
                        [T2TView showFailHUDWithText:@"数据已经加载完毕"];
                        block_self.isRefsh=NO;
                        return ;
                    }
                    
                }else{
                    
                    if ([responseObject.reson isEqualToString:@"not data"]) {
                        [block_self.BookArrData removeAllObjects];
                        [block_self.TBTableView reloadData];
                        [T2TFailedView showFailedInView:block_self.TBTableView response:responseObject arrData:block_self.BookArrData withRefreshBlock:^{
                            [T2TFailedView removeFromView:block_self.TBTableView];
                            [block_self request_BookListDelaWithList_connection:0];
                        } editFailedView:^(T2TFailedView *failedView) {
                            if(block_self.failedViewBlock)block_self.failedViewBlock(failedView);
                        }];
                    }
                    [block_self.TBTableView footerEndRefreshing];
                    [block_self.TBTableView headerEndRefreshing];
                    return ;
                }
            }
            block_self.pageFive++;
            [self.TBTableView reloadData];
            [block_self.TBTableView footerEndRefreshing];
            [block_self.TBTableView headerEndRefreshing];
            NSLog(@"responseObject===%@",responseObject);
        }else{
            
            if (responseObject.code == kMGOkStatuCode) {
                block_self.TBTableView.hidden=NO;
                if (block_self.pageSix == 1) {
                    [block_self.BookArrData removeAllObjects];
                }
                for (NSDictionary *dicInfo in responseObject.list) {
                    bookMode *model = [[bookMode alloc] initWithDic:dicInfo];
                    [self.BookArrData addObject:model];
                    [T2TFailedView  removeFromView:self.TBTableView];

                }
            } else {
                
                if (block_self.isRefsh) {
                    if(totalArr.count == 0)
                    {
                        [block_self.TBTableView footerEndRefreshing];
                        [block_self.TBTableView headerEndRefreshing];
                        [T2TView showFailHUDWithText:@"数据已经加载完毕"];
                        block_self.isRefsh=NO;
                        return ;
                    }
                    
                }else{
                    
                    if ([responseObject.reson isEqualToString:@"not data"]) {
                        [block_self.BookArrData removeAllObjects];
                        [block_self.TBTableView reloadData];
                        [T2TFailedView showFailedInView:block_self.TBTableView response:responseObject arrData:block_self.BookArrData withRefreshBlock:^{
                            [T2TFailedView removeFromView:block_self.TBTableView];
                            [block_self request_BookListDelaWithList_connection:1];
                        } editFailedView:^(T2TFailedView *failedView) {
                            if(block_self.failedViewBlock)block_self.failedViewBlock(failedView);
                        }];
                    }
                    [block_self.TBTableView footerEndRefreshing];
                    [block_self.TBTableView headerEndRefreshing];
                    return ;
                }
            }
            block_self.pageSix++;
            [block_self.TBTableView reloadData];
            [block_self.TBTableView footerEndRefreshing];
            [block_self.TBTableView headerEndRefreshing];
            NSLog(@"responseObject===%@",responseObject);
        }
    } failure:^(id error) {
        [hub hide:YES];
        [block_self.TBTableView footerEndRefreshing];
        [block_self.TBTableView headerEndRefreshing];
        [T2TView showFailHUDWithHUD:hub text:error];
        
    } otherHttpHeader:MGGetOtherHttpHear()];
}

#pragma -mark  教具已处理列表

-(void)request_BookListDelaWithListFinish_connection:(NSInteger)type{
//    if (type==1) {
//        NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
//        if ([self.model.startDate isEqualToString:[user objectForKey:@"typefour"]]) {
//            
//        }else{
//            self.pageEight=1;
//            [user setObject:self.model.subjectId forKey:@"typefour"];
//            [user synchronize];
//        }
//    }
    __weak workSpaceViewController *block_self = self;
    
    NSDictionary *dicPost ;
    if (type==0) {
        dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"yearMonth":@"",@"deptId":@"",@"pageNo":kStrWithInter(self.pageSeven),@"employeeName":@""}};
    }else{
        dicPost = @{@"status":MGGetStatusDicHaveUserName(),@"object":@{@"yearMonth":kUnNilStr(self.model.startDate),@"deptId":kUnNilStr(self.model.deptIds),@"pageNo":kStrWithInter(self.pageEight),@"employeeName":kUnNilStr(self.model.clientName)}};
    }
    
    NSString *url = [NSString stringWithFormat:kMGDefaultURL,kMGDelaWithBookListFinishScheduleUrl,[dicPost JSONString]];
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [T2THttpManager getWithUrl:url success:^(T2TResponse *responseObject) {
        [hub hide:YES];
        NSArray *totalArr = [NSArray arrayWithArray:responseObject.list];

        if (type==0) {
            if (responseObject.code == kMGOkStatuCode) {
                block_self.TBSecondTableView.hidden=NO;
                if (block_self.pageSeven == 1) {
                    [block_self.BookArrDataSecond removeAllObjects];
                }
                for (NSDictionary *dicInfo in responseObject.list) {
                    bookModeFinish *model = [[bookModeFinish alloc] initWithDic:dicInfo];
                    [self.BookArrDataSecond addObject:model];
                    [T2TFailedView  removeFromView:self.TBSecondTableView];

                }
                
            } else {
                
                if (block_self.isRefsh) {
                    if(totalArr.count == 0)
                    {
                        [block_self.TBSecondTableView footerEndRefreshing];
                        [block_self.TBSecondTableView headerEndRefreshing];
                        [T2TView showFailHUDWithText:@"数据已经加载完毕"];
                        block_self.isRefsh=NO;
                        return ;
                    }
                    
                }else{
                    
                    if ([responseObject.reson isEqualToString:@"not data"]) {
                        [block_self.BookArrDataSecond removeAllObjects];
                        [block_self.TBSecondTableView reloadData];
                        [T2TFailedView showFailedInView:block_self.TBSecondTableView response:responseObject arrData:block_self.BookArrDataSecond withRefreshBlock:^{
                            [T2TFailedView removeFromView:block_self.TBSecondTableView];
                            [block_self request_BookListDelaWithListFinish_connection:0];
                        } editFailedView:^(T2TFailedView *failedView) {
                            if(block_self.failedViewBlock)block_self.failedViewBlock(failedView);
                        }];
                    }
                    [block_self.TBSecondTableView footerEndRefreshing];
                    [block_self.TBSecondTableView headerEndRefreshing];
                    return ;
                }
            }
            block_self.pageSeven++;
            [block_self.TBSecondTableView reloadData];
            [block_self.TBSecondTableView footerEndRefreshing];
            [block_self.TBSecondTableView headerEndRefreshing];
            NSLog(@"responseObject===%@",responseObject);
        }else{
            if (responseObject.code == kMGOkStatuCode) {
                block_self.TBSecondTableView.hidden=NO;
                if (block_self.pageEight == 1) {
                    [block_self.BookArrDataSecond removeAllObjects];
                }
                for (NSDictionary *dicInfo in responseObject.list) {
                    bookModeFinish *model = [[bookModeFinish alloc] initWithDic:dicInfo];
                    [self.BookArrDataSecond addObject:model];
                    [T2TFailedView  removeFromView:self.TBSecondTableView];

                }
            } else {
                
                if (block_self.isRefsh) {
                    if(totalArr.count == 0)
                    {
                        [block_self.TBSecondTableView footerEndRefreshing];
                        [block_self.TBSecondTableView headerEndRefreshing];
                        [T2TView showFailHUDWithText:@"数据已经加载完毕"];
                        block_self.isRefsh=NO;
                        return ;
                    }
                    
                }else{
                    
                    if ([responseObject.reson isEqualToString:@"not data"]) {
                        [block_self.BookArrDataSecond removeAllObjects];
                        [block_self.TBSecondTableView reloadData];
                        [T2TFailedView showFailedInView:block_self.TBSecondTableView response:responseObject arrData:block_self.BookArrDataSecond withRefreshBlock:^{
                            [T2TFailedView removeFromView:block_self.TBSecondTableView];
                            [block_self request_BookListDelaWithListFinish_connection:1];
                        } editFailedView:^(T2TFailedView *failedView) {
                            if(block_self.failedViewBlock)block_self.failedViewBlock(failedView);
                        }];
                    }
                    [block_self.TBSecondTableView footerEndRefreshing];
                    [block_self.TBSecondTableView headerEndRefreshing];
                    return ;
                }
            }
            block_self.pageEight++;
            [block_self.TBSecondTableView reloadData];
            [block_self.TBSecondTableView footerEndRefreshing];
            [block_self.TBSecondTableView headerEndRefreshing];
            NSLog(@"responseObject===%@",responseObject);
        }
    } failure:^(id error) {
        [hub hide:YES];
        [T2TView showFailHUDWithText:error];
        NSLog(@"error===%@",error);
        
    } otherHttpHeader:MGGetOtherHttpHear()];
}

#pragma -mark  tableViewDeleGate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView==self.scrollView) {
        if (scrollView.contentOffset.x/kScreenWidth==0) {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 self.imageView.frame =CGRectMake(kScreenWidth/4-50, self.alreadyButton.y+self.alreadyButton.height-1, 100, 1);
             } completion:nil];
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            
        }else{
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 self.imageView.frame =CGRectMake(kScreenWidth/2+30, self.alreadyButton.y+self.alreadyButton.height-1, 100, 1);
                 
             } completion:nil];
            [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        }
  
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0000000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isBook) {
        if ([tableView isEqual:self.TBTableView]) {
            return [self.BookArrData count];
            
        }else{
            return [self.BookArrDataSecond count];
        }
    }else {
        if ([tableView isEqual:self.TBTableView]) {
            return [self.arrData count];
            
        }else{
            return [self.arrDataSecond count];
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isBook) {
        if ([tableView isEqual:self.TBTableView]) {
            bookMode *model =[self.BookArrData objectAtIndex:indexPath.section];
            return [WorkTableViewCell BookGetCellHeigth:model]+40;
        }
        else
        {
            bookModeFinish *model =[self.BookArrDataSecond objectAtIndex:indexPath.section];
            return [WorkSecondTableViewCell BookGetCellHeigth:model]+75;
        }
        
    }else
    {
        if ([tableView isEqual:self.TBTableView]) {
            workMode *model =[self.arrData objectAtIndex:indexPath.section];
            return [WorkTableViewCell getCellHeigth:model]+40;
        }
        else
        {
            workModeSecond *model =[self.arrDataSecond objectAtIndex:indexPath.section];
            return [WorkSecondTableViewCell getCellHeigth:model]+70;

        }
        
    }
}
//cell复用机制
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.TBTableView]) {
        WorkTableViewCell *cell = [WorkTableViewCell cellWithTableView:tableView];
        cell.isBook=self.isBook;
        if (self.isBook) {
            if (self.BookArrData.count > indexPath.row) {
                bookMode *model =[self.BookArrData objectAtIndex:indexPath.section];
                [cell  BookModeSetUivalueWithModel:model];
            }
            
        }else{
            if (self.arrData.count > indexPath.row) {
                workMode *model =[self.arrData objectAtIndex:indexPath.section];
                [cell  setUivalueWithModel:model];
                
            }
            
            
        }
        return cell;
        
    }else {
        WorkSecondTableViewCell *cell = [WorkSecondTableViewCell cellWithTableView:tableView];
        cell.isBook=self.isBook;
        if (self.isBook) {
            if (self.BookArrDataSecond.count > indexPath.row) {
                bookModeFinish *model =[self.BookArrDataSecond objectAtIndex:indexPath.section];
                [cell   BookModeSetUivalueWithModel:model];
            }
            
        }else{
            if (self.arrDataSecond.count > indexPath.row) {
                workModeSecond *model =[self.arrDataSecond objectAtIndex:indexPath.section];
                [cell  setUivalueWithModel:model];
            }
        }
        return cell;
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([tableView isEqual:self.TBTableView]) {
        if (self.isBook) {
            bookMode *booKmodel =[self.BookArrData objectAtIndex:indexPath.section];
            costViewController *vc= [[costViewController alloc]init];
            vc.Bookmodel =booKmodel;
            vc.isBook=self.isBook;
            [self.navigationController pushViewController:vc animated:YES];

        }else{
            workMode *model =[self.arrData objectAtIndex:indexPath.section];
            costViewController *vc= [[costViewController alloc]init];
            vc.model = model;
            vc.isBook=self.isBook;
            [self.navigationController pushViewController:vc animated:YES];

        }
        
    }else {
        return;
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
