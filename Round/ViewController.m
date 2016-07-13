//
//  ViewController.m
//  Round
//
//  Created by onlyou1991 on 16/7/13.
//  Copyright © 2016年 onlyou1991. All rights reserved.
//

#import "ViewController.h"
#import "News.h"
#import "CRNewsView.h"
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<CRNewsViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    NSMutableArray *datasourceImages = [NSMutableArray array];

    for (int i=1; i<5; i++) {
        News *news = [[News alloc]init];
        news.picture = [NSString stringWithFormat:@"%d.jpg",i];
        news.title = [NSString stringWithFormat:@"标题%d",i];;
        [datasourceImages addObject:news];
    }
    
    
    
    
    CRNewsView *newsView = [[CRNewsView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200)];
    newsView.delegate = self;
    newsView.datasourceImages = datasourceImages;
    [self.view addSubview:newsView];
}

-(void)cr_newsView:(CRNewsView *)cr_newsView didCRNewsViewAtIndex:(NSUInteger)index{
    NSLog(@"点击：%ld",index);
}

@end
