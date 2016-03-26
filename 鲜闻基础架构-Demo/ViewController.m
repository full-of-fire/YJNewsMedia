//
//  ViewController.m
//  鲜闻基础架构-Demo
//
//  Created by yj on 16/3/24.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "ViewController.h"
#import "MNTopTitleBar.h"
#import "YJTabPageView.h"
#import "YJTestViewController.h"
@interface ViewController ()

@property (strong,nonatomic) MNTopTitleBar *topBar;

@property (strong,nonatomic) NSMutableArray *viewContrllers;

@property (strong,nonatomic) NSMutableArray *titles;

@property (strong,nonatomic) YJTabPageView *pageVIew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    MNTopTitleBar *topBar = [[MNTopTitleBar alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width-44, 44)];
//    topBar.titles = @[@"测试1",@"测试2",@"测试2",@"测试2",@"测试2",@"测试2",@"测试2"];
//    
//    topBar.backgroundColor = [UIColor greenColor];
//    
//    [topBar setTitleButtonClickedBlock:^(UIButton *titletButotn, NSUInteger selectedIndex) {
//       
//        
//        NSLog(@"%d",selectedIndex);
//    }];
//    
//    NSLog(@"-----------%d",topBar.selectedIndex);
//    
//    topBar.titleWidth = 50;
//    
//    _topBar = topBar;
//    
//    [self.view addSubview:topBar];
    
    
    YJTabPageView *page = [[YJTabPageView alloc] initWithFrame:CGRectMake(0, 20, ScreenW, ScreenH-200)];
    
//    page.backgroundColor = [UIColor redColor];
    page.parentViewController = self;
    page.topBarTitles = self.titles;
    page.viewControllers = self.viewContrllers;
    
    _pageVIew = page;
    
    [page setPageChageBlock:^(UIViewController *viewController, NSUInteger index) {
       
        YJTestViewController *tesVC = (YJTestViewController*)viewController;
        
        tesVC.index = index;
        
        [tesVC refresh];
        
        
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    
    [self.view addSubview:page];
    
    
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    YJTestViewController *test = [YJTestViewController new];
    
    [self.viewContrllers addObject:test];
    
    [self.titles addObject:@"我擦啊"];
    
    
    _pageVIew.viewControllers = self.viewContrllers;
    
    _pageVIew.topBarTitles = self.titles;
    
    
    NSLog(@"%d",self.childViewControllers.count);
    
    NSLog(@"%d",self.view.subviews.count);

    
    NSLog(@"测试");
}

- (NSMutableArray*)viewContrllers {
    
    if (_viewContrllers  == nil) {
        
        _viewContrllers = [NSMutableArray array];
        for (int i = 0; i<4; i++) {
            
            
            
            YJTestViewController *test = [YJTestViewController new];
            
            [_viewContrllers addObject:test];
        }
    }
    return _viewContrllers;
}

- (NSMutableArray*)titles {
    
    if (_titles  == nil) {
    
        _titles = [NSMutableArray array];
        for (int i = 0; i<4; i++) {
            
            [_titles addObject:[NSString stringWithFormat:@"测试%d",i]];
        }
        
        
    }
    
    
    return _titles;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    _topBar.selectedIndex = 5;
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    _topBar.selectedIndex = 1;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
