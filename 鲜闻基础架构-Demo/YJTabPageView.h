//
//  YJTabPageView.h
//  鲜闻基础架构-Demo
//
//  Created by yj on 16/3/24.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJTabPageView : UIView
/**
 *  子控制器数组
 */
@property (strong,nonatomic) NSArray *viewControllers;
/**
 *  所属父类控制
 */
@property (strong,nonatomic) UIViewController *parentViewController;

/**
 * 标题数组
 */
@property (strong,nonatomic) NSArray *topBarTitles;

@property (copy,nonatomic) void(^pageChageBlock)(UIViewController *viewController, NSUInteger index);

- (void)setPageChageBlock:(void (^)(UIViewController *viewController, NSUInteger index))pageChageBlock;

@end
