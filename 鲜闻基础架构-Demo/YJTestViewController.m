//
//  YJTestViewController.m
//  鲜闻基础架构-Demo
//
//  Created by yj on 16/3/24.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "YJTestViewController.h"
#import "MJRefresh.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface YJTestViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation YJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    
    NSLog(@"给我掉一次");
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    
    [self createFreshUp];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString*reuseID = @"reuseID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    
    return cell;
    
}

- (void)refresh {

    NSLog(@"我需要刷新哦");
    
    NSLog(@"%d",_index);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      
            [self.tableView.mj_header beginRefreshing];
    });
    

}





#pragma  mark - 刷新
-(void)createFreshUp{
    
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    //     __weak TableViewController *weakSelf = self;
    // 下拉刷新
    // if (self.index == 0) {
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
      
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            [self.tableView.mj_header endRefreshing];
        });
    }];
        [self.tableView.mj_header beginRefreshing];
    
}

@end
