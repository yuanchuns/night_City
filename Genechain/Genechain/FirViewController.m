//
//  FirViewController.m
//  Genechain
//
//  Created by nextone on 15/9/14.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "FirViewController.h"
#import "FirCollCell.h"
#import "HTTPHelper.h"
#import "firMode.h"

@interface FirViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,RefreshControlDelegate>

@property(nonatomic)int page;
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrData;//数据源

@end

@implementation FirViewController
#pragma mark - public


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.arrData = [NSMutableArray array];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"热门",@"广场",@"关注",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame =CGRectMake(0.0f, 0.0f, 150.0f, 30.0f);
    [segmentedControl addTarget:self action:@selector(SelectbuttonAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.layer.borderWidth = 0.0;
    segmentedControl.selectedSegmentIndex=0;
    segmentedControl.tintColor = [UIColor colorWithRed:0.69f green:0.75f blue:0.87f alpha:1.00f];
    segmentedControl.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = segmentedControl;
    
    
    
    self.navigationItem.leftBarButtonItem = nil;
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayOut];
    self.collectionView.backgroundColor =[UIColor colorWithRed:0.14f green:0.16f blue:0.17f alpha:1.00f];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:MGHomeItemCellReuseRedifilerAndName bundle:nil] forCellWithReuseIdentifier:MGHomeItemCellReuseRedifilerAndName];
    [self requestTopicView_dataSoure_connection];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)SelectbuttonAction:(UISegmentedControl *)seg{
    NSInteger Index = seg.selectedSegmentIndex;
    switch (Index) {
            
        case 0:
            break;
            
        case 1:
            
            break;
            
        case 2:
            
            break;
            
        default:
            
            break;
    }
}
#pragma mark - dataSoure
-(void)requestTopicView_dataSoure_connection
{
    NSString *url = [NSString stringWithFormat:kMGDefaultURL,[@{@"PageIndex":@"0",@"PageSize":@"16"} JSONString]];
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    [man GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hub hide:YES];
        
    if ([responseObject[@"code"] integerValue]== kMGOkStatuCode) {
        NSArray *totalArr = [NSArray arrayWithArray:responseObject[@"List"]];
        for (NSDictionary *dict in totalArr) {
            firMode *model =[[firMode alloc]initWithDic:dict];
            [self.arrData  addObject:model];
        }
        [self.collectionView reloadData];

    }
        FLOG(@"responseObject====%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hub hide:YES];
        FLOG(@"error====%@", error);
    }];
    
}
#pragma mark - colletionViewDelegate

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrData.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FirCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MGHomeItemCellReuseRedifilerAndName forIndexPath:indexPath];
    firMode *model =self.arrData[indexPath.item];
    cell.model = model;
    return cell;
    
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenWidth-20)/2+2.5, 272.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}
//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 5,5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - textFiledDelgate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - privateFunc
-(void)navBackAction:(UIBarButtonItem *)backBar
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.35;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"fade";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
