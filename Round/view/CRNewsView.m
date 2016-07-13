//
//  CRNewsView.m
//  SmartAgriculture
//
//  Created by onlyou1991 on 16/6/27.
//  Copyright © 2016年 LEE . All rights reserved.
//

#import "CRNewsView.h"
#import "GCRNewsCell.h"

#define CellIdentifier @"news"
#define MaxSections 100
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width


@interface CRNewsView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation CRNewsView

-(void)setDatasourceImages:(NSArray *)datasourceImages{
    _datasourceImages = datasourceImages;
    [self.collectionView reloadData];
    //默认是最中间组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:MaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    self.pageControl.numberOfPages = datasourceImages.count;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initColletionAndPageController];
    }
    return self;
}
/**
 *  初始化collectionview和pagecollector
 */
- (void)initColletionAndPageController
{
    [self initCollectionView];
    [self initPageController];
    //添加定时器
    [self addTimer];
}
/**
 *  添加定时器
 */
-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
/**
 *  移除定时器
 */
-(void)removeTimer{
    //停止定时器
    [self.timer invalidate];
    self.timer = nil;
}
-(NSIndexPath *)resetIndexPath{
    //当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems]lastObject];
    //马上显示回中间的那组数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}
/**
 *  下一页
 */
-(void)nextPage{
    //1.马上显示最中间的那组数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    //2,计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.datasourceImages.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    //3,通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

/**
 *  初始化CollectionView
 */
-(void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame),CGRectGetHeight(self.frame));
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"GCRNewsCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    
    [self addSubview:self.collectionView];
   
}
/**
 *  初始化PageController
 */
-(void)initPageController{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.collectionView.frame.size.height-30, SCREEN_WIDTH, 30)];
    self.pageControl.numberOfPages = self.datasourceImages.count;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
}
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio{
    return self.datasourceImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GCRNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.news = _datasourceImages[indexPath.item];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return MaxSections;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, self.frame.size.height);
}



#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate cr_newsView:self didCRNewsViewAtIndex:indexPath.row];
}

/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width ) % self.datasourceImages.count;
    self.pageControl.currentPage = page;
}

@end