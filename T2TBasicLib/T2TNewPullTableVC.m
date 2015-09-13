//
//  T2TNewPullTableVC.m
//  T2TBasicLib
//
//  Created by mark on 15/1/4.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "T2TNewPullTableVC.h"
#import "PullingRefreshTableView.h"
#import "T2THttpManager.h"
@interface T2TNewPullTableVC ()<PullingRefreshTableViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation T2TNewPullTableVC

#pragma mark - public
-(NSString *)getRequestUrlStr{

    return nil;
}

-(void)handleContentData:(id)content{

}

-(void)handleContentResponse:(T2TResponse *)content
{

}
-(void)reloadFirPage{

    [self.pullTable launchRefreshing];
}

#pragma mark - ScrDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


    [_pullTable tableViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [_pullTable tableViewDidEndDragging:scrollView];

}



#pragma mark - private

-(void)loadData{

    
    self.isLoading = YES;
    NSString *str = [self getRequestUrlStr];
    [T2THttpManager  getWithUrl:str success:^(T2TResponse *responseObject) {
        [self loadDidEndWithResponse:responseObject];
    } failure:^(id res) {
        [self loadDidEndWithResponse:res];
    }];
    

}


-(void)loadDidEndWithResponse:(T2TResponse *)respose{
    if (![respose isKindOfClass:[T2TResponse class]]) {
        respose = [[T2TResponse alloc] initWithDic:nil];
    }
    
    _allPages = (int)respose.count;
    if (!self.arrData) _arrData = [NSMutableArray array];
    [self handleContentData:respose.list];
    [self handleContentResponse:respose];
    self.isLoading = NO;
    [_pullTable tableViewDidFinishedLoading];
    [_pullTable setReachedTheEnd:(_arrData.count>=_allPages)];
    [_pullTable reloadData];
    
    
}


#pragma mark - pullDelegate
#pragma mark  下拉刷新
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{

    self.curPageIndex = 1;
    self.arrData = [NSMutableArray array];
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];
}

#pragma mark  上拉加载
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{

    self.curPageIndex++;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];
}

-(void)loadView{
    [super loadView];
    _pullTable = [[PullingRefreshTableView alloc] initWithFrame:self.view.bounds pullingDelegate:self];
    _pullTable.autoScrollToNextPage = kIsIOS7?YES:NO;
    self.tableView = _pullTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [T2TView backItemWithTarget:self];
   
    if ([self getRequestUrlStr]) {
        [_pullTable launchRefreshing];
    }
   

}

-(void)navBackAction:(UIBarButtonItem *)backBar
{
   
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"aa";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
