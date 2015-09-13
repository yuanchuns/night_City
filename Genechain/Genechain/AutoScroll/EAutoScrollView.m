//
//  EAutoScrollView.m
//  Examda
//
//  Created by mark on 15/4/27.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EAutoScrollView.h"

#define TagAdd  105
#define animationTime 3

@interface EAutoScrollView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSUInteger totalPage;
@property (nonatomic,assign) NSUInteger curPage;
@property (nonatomic, assign) BOOL enableRolling;
@property (nonatomic,strong) NSArray *arrImas;
@property (nonatomic,strong) TReturnObjectWithOtherObjectBlock fentchBlock;
@property (nonatomic,strong) T2TIndexBlock indexBlock;
@end

@implementation EAutoScrollView

-(instancetype)initWithFrame:(CGRect)frame withArrIma:(NSArray *)arrIma withFentchBlock:(TReturnObjectWithOtherObjectBlock)fentchBlock{

    if (self = [super initWithFrame:frame]) {
        
        self.totalPage = arrIma.count;
        self.curPage = 1;
        self.arrImas = arrIma;
        self.fentchBlock = fentchBlock;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        for(int i = 0; i < 3;i++){
            UIImageView *imav = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
            imav.userInteractionEnabled = YES;
            imav.tag = i + TagAdd;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imavTap:)];
            [imav addGestureRecognizer:tap];
            imav.frame = CGRectOffset(imav.frame, self.scrollView.width*i, 0);
            [self.scrollView addSubview:imav];
        }
        self.scrollView.contentSize = CGSizeMake(3*self.scrollView.width, 0);
        [self startRolling];
    }
    return self;
}


-(void)setScorllIndexBlock:(T2TIndexBlock)indexBlock{
    self.indexBlock = indexBlock;
}

- (void)reloadBannerWithData:(NSArray *)images{
    if (self.enableRolling)
    {
        [self stopRolling];
    }
    
    self.arrImas = [[NSArray alloc] initWithArray:images];
    
    self.totalPage = images.count;
    _curPage = 1;
    self.pageControl.numberOfPages = self.totalPage;
    self.pageControl.currentPage = 0;
    [self refreshScrollView];
    [self startRolling];
}

#pragma mark - private
-(void)imavTap:(UITapGestureRecognizer *)tap{

    if([self.delegate respondsToSelector:@selector(tapIndex:)]){
    
        [self.delegate tapIndex:self.curPage - 1];
    }
    
    
}

- (NSInteger)getPageIndex:(NSInteger)index
{
    // value＝1为第一张，value = 0为前面一张
    if (index == 0)
    {
        index = _totalPage;
    }
    
    if (index == _totalPage + 1)
    {
        index = 1;
    }
    
    return index;
}

- (NSArray *)getDisplayImagesWithPageIndex:(NSInteger)page
{
    if (self.arrImas.count  == 0) {
        return @[];
    }
    NSInteger pre = [self getPageIndex:self.curPage-1];
    NSInteger last = [self getPageIndex:_curPage+1];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    
    [images addObject:[self.arrImas objectAtIndex:pre-1]];
    [images addObject:[self.arrImas objectAtIndex:self.curPage-1]];
    [images addObject:[self.arrImas objectAtIndex:last-1]];
    
    return images;
}

- (void)refreshScrollView
{
    NSArray *curimageUrls = [self getDisplayImagesWithPageIndex:self.curPage];
    if(curimageUrls.count == 0)return;
    for (NSInteger i = 0; i < 3; i++)
    {
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:TagAdd+i];
        NSString *url = [curimageUrls objectAtIndex:i];
        if (self.fentchBlock) {
            url = self.fentchBlock(url);
        }
        if (imageView && [imageView isKindOfClass:[UIImageView class]] )
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f2f2f2"]]];
//            [imageView loadImageWithUrlStr:url placeHolderImage:kDefaultIma300x190];
        }
    }
    if(self.indexBlock)self.indexBlock(0);
    // 水平滚动
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
   
    self.pageControl.currentPage = self.curPage - 1;
}

- (void)startRolling
{
    if (!self.arrImas || self.arrImas.count == 1)
    {
        return;
    }
    
    [self stopRolling];
    
    self.enableRolling = YES;
    [self performSelector:@selector(rollingScrollAction) withObject:nil afterDelay:animationTime];
}

- (void)stopRolling
{
    self.enableRolling = NO;
    //取消已加入的延迟线程
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(rollingScrollAction) object:nil];
}


- (void)rollingScrollAction
{
    //NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    [UIView animateWithDuration:0.25 animations:^{
        // 水平滚动
    self.scrollView.contentOffset = CGPointMake(1.99*self.scrollView.frame.size.width, 0);
        
    } completion:^(BOOL finished) {
        self.curPage = [self getPageIndex:self.curPage+1];
        [self refreshScrollView];
        
        if (self.enableRolling)
        {
            [self performSelector:@selector(rollingScrollAction) withObject:nil afterDelay:animationTime];
        }
    }];
}



#pragma mark - scr
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger x = scrollView.contentOffset.x;
//    NSInteger y = scrollView.contentOffset.y;
    if (x >= 2 * scrollView.frame.size.width)
    {
        _curPage = [self getPageIndex:self.curPage+1];
        [self refreshScrollView];
    }
    
    if (x <= 0)
    {
        _curPage = [self getPageIndex:self.curPage-1];
        [self refreshScrollView];
    }
    if(self.indexBlock)self.indexBlock(self.curPage - 1);
}


@end
