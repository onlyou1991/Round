# Round
使用步骤
1.copy View 文件夹到项目中
2，Model文件夹是对象，可以更改成自己的对象
3，在ViewController中引用
代码示例：
    CRNewsView *newsView = [[CRNewsView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200)];
    newsView.delegate = self;
    newsView.datasourceImages = datasourceImages;
    [self.view addSubview:newsView];
4，代理方法，图片被点击
-(void)cr_newsView:(CRNewsView *)cr_newsView didCRNewsViewAtIndex:(NSUInteger)index{
    NSLog(@"点击：%ld",index);
}
