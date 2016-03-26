//
//  MNTopTitleBar.h
//  鲜闻基础架构-Demo
//
//  Created by yj on 16/3/24.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface MNTopTitleBar : UIView
/**
 *  标题数组
 */
@property (strong,nonatomic) NSArray *titles;


/**
 *  选中的页码
 */
@property (assign,nonatomic) NSUInteger selectedIndex;



@property (assign,nonatomic) CGFloat titleWidth; //按钮宽度

@property (assign,nonatomic) CGFloat indexWidth; // 索引视图的宽度






/**
 *  按钮被点击的block
 */
@property (copy,nonatomic) void(^titleButtonClickedBlock)(UIButton *titletButotn,NSUInteger selectedIndex);

- (void)setTitleButtonClickedBlock:(void (^)(UIButton *titletButotn, NSUInteger selectedIndex))titleButtonClickedBlock;

@end
