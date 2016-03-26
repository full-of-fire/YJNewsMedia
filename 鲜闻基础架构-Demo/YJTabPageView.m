//
//  YJTabPageView.m
//  鲜闻基础架构-Demo
//
//  Created by yj on 16/3/24.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "YJTabPageView.h"
#import "MNTopTitleBar.h"
#import "YJTestViewController.h"
@interface YJTabPageView()<UIScrollViewDelegate>

@property (strong,nonatomic) MNTopTitleBar *topTitleBar; // 顶部标题bar

@property (strong,nonatomic) UIScrollView *bottomScrollView; //底部滚动视图

@property (assign,nonatomic) NSInteger page;

@end

@implementation YJTabPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


#pragma mark - set方法

- (void)setViewControllers:(NSArray *)viewControllers {

    _viewControllers = viewControllers;
    if (viewControllers.count==0) {
        
        return;
    }
    
    [_bottomScrollView removeFromSuperview];
    
    _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-44)];
    _bottomScrollView.showsHorizontalScrollIndicator = NO;
    _bottomScrollView.showsVerticalScrollIndicator = NO;
    _bottomScrollView.pagingEnabled = YES;
    _bottomScrollView.delegate = self;
    [self addSubview:_bottomScrollView];
    
    for (int i = 0; i<viewControllers.count; i++) {
        
        YJTestViewController *vc = viewControllers[i];
        vc.view.frame = CGRectMake(i*_bottomScrollView.width, 0, _bottomScrollView.width, _bottomScrollView.height);
        [_bottomScrollView addSubview:vc.view];
        
        [self.parentViewController addChildViewController:vc];
    }
    
    _bottomScrollView.contentSize = CGSizeMake(_bottomScrollView.width*viewControllers.count, _bottomScrollView.height);

    
}


- (void)setTopBarTitles:(NSArray *)topBarTitles {

    _topBarTitles = topBarTitles;
    if (topBarTitles.count==0) {
        return;
    }
    
    [_topTitleBar removeFromSuperview];
    
    _topTitleBar = [[MNTopTitleBar alloc] initWithFrame:CGRectMake(0, 0, self.width-40, 44)];
    

    
    _topTitleBar.titles = topBarTitles;
    
    
    __weak typeof(self) weakSelf = self;
    
    [_topTitleBar setTitleButtonClickedBlock:^(UIButton *titletButotn, NSUInteger selectedIndex) {
       
        [weakSelf p_setBottomScrollViewWithPage:selectedIndex];
        
        if (weakSelf.pageChageBlock) {
            
            weakSelf.pageChageBlock(weakSelf.viewControllers[selectedIndex],selectedIndex);
        }
        
    }];
    
    [self addSubview:_topTitleBar];
}


#pragma mark - 懒加载

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger page = scrollView.contentOffset.x/self.width + 0.5;
    
    self.page = page;
    
    _topTitleBar.selectedIndex = page;
    
   
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if (self.pageChageBlock) {
        
        self.pageChageBlock(self.viewControllers[self.page],self.page);
    }
}


- (void)p_setBottomScrollViewWithPage:(NSUInteger)page {

    
    [UIView animateWithDuration:0.25 animations:^{
        
        _bottomScrollView.contentOffset = CGPointMake(self.width*page, 0);
        
    }];
}

@end
