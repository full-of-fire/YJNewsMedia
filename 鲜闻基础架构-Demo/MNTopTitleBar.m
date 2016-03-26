//
//  MNTopTitleBar.m
//  鲜闻基础架构-Demo
//
//  Created by yj on 16/3/24.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "MNTopTitleBar.h"

@interface MNTopTitleBar()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *backScrollView; //

@property (strong,nonatomic) UIView *indexView; //索引视图

@property (assign,nonatomic) CGFloat titleButtonWidth; //按钮宽度

@property (assign,nonatomic) CGFloat titleButtonHeight; //按钮高度

@property (assign,nonatomic) CGFloat indexViewHeight; // 索引视图的的高度

@property (strong,nonatomic) UIColor *normalCorl;


@property (strong,nonatomic) NSMutableArray *buttons; // 记录创建好的按钮

@end

@implementation MNTopTitleBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleButtonWidth = ScreenW/4;
        _titleButtonHeight = 42;
        _indexViewHeight = 2;
        
        _buttons = [NSMutableArray array];
        
        self.backScrollView = [[UIScrollView alloc] init];
        self.backScrollView.delegate = self;
        self.backScrollView.showsHorizontalScrollIndicator = NO;
        self.backScrollView.showsVerticalScrollIndicator = NO;
        self.backScrollView.bounces = NO;
        
        
        self.indexView = [[UIView alloc] init];
        self.indexView.backgroundColor = [UIColor redColor];
        [self.backScrollView addSubview:self.indexView];
        
        [self addSubview:self.backScrollView];
    }
    return self;
}

#pragma mark- 按钮响应事件
- (void)buttonAction:(UIButton*)button {

    
    if (self.titleButtonClickedBlock) {
        
        self.titleButtonClickedBlock(button,button.tag);
    }
    
   
    // 调整scorllview
    [self p_adjustBackScrollViewAndIndexViewWithButton:button];
    
    //调整选中按钮
    [self p_adjuestSelectedButton:button];
    

}


#pragma mark - set方法

- (void)setTitles:(NSArray *)titles {

    if (titles.count==0) {
        return;
    }
    _titles = titles;
    
  
  
    
    for(int i = 0;i<_titles.count;i++){
        
       
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_buttons addObject:button];
        
        if (i==0) {
            
            button.selected = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        
        [self.backScrollView addSubview:button];
   
    }
        
   
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex {

    _selectedIndex = selectedIndex;
    UIButton *selectedButton = _buttons[selectedIndex];
    
    [self p_adjustBackScrollViewAndIndexViewWithButton:selectedButton];
    
    [self p_adjuestSelectedButton:selectedButton];
}

- (void)setTitleWidth:(CGFloat)titleWidth {

    _titleWidth = titleWidth;
    
    _titleButtonWidth = titleWidth;
}






#pragma mark - 布局
- (void)layoutSubviews {

    [super layoutSubviews];
    
    
    self.backScrollView.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.indexView.frame = CGRectMake(0, _titleButtonHeight, _titleButtonWidth, _indexViewHeight);
      _backScrollView.contentSize = CGSizeMake(_titleButtonWidth*_titles.count, _titleButtonHeight);
    
    for(int i = 0;i<_buttons.count;i++){
    
        UIButton *button = _buttons[i];
        
        button.tag = i;
        
        if (i==0) {
            
            button.selected = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        
        button.x = _titleButtonWidth*i;
        button.y = 0;
        button.width = _titleButtonWidth;
        button.height = _titleButtonHeight;
    }
}

#pragma mark - 私有方法

//调整按钮的位置，和索引视图的位置
- (void)p_adjustBackScrollViewAndIndexViewWithButton:(UIButton*)button{

    [UIView animateWithDuration:0.25 animations:^{
        
        self.indexView.centerX = button.centerX;
    }];
    
    //跳转contensize
    
    // 如果数量不够就不需要调整
    if (self.backScrollView.width<self.width) {
        
        return;
    }
    //按钮的中心
    CGFloat centerX = button.centerX;
    //该控件的宽度
    CGFloat scrollViewW = self.width;
    
    CGFloat leftX = centerX - scrollViewW*0.5;
    if (leftX<0) {
        
        leftX = 0;
    }
    
    //计算最右边能滚动最大的距离
    CGFloat maxOffSetX = self.backScrollView.contentSize.width -scrollViewW;
    if (leftX>maxOffSetX) {
        
        leftX = maxOffSetX;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.backScrollView setContentOffset:CGPointMake(leftX, 0)];
    }];
    
}

// 调整选中的按钮
- (void)p_adjuestSelectedButton:(UIButton*)button {

    for (int i = 0; i<_buttons.count; i++) {
        
        UIButton *selectedButton = _buttons[i];
        if (selectedButton.tag == button.tag) {
            button.selected = YES;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                selectedButton.titleLabel.font = [UIFont systemFontOfSize:20];
                
            }];
            
           
        }
        else {
            
            selectedButton.selected = NO;
            [UIView animateWithDuration:0.25 animations:^{
                
                selectedButton.titleLabel.font = [UIFont systemFontOfSize:16];
                
            }];
           
        }
    }
    
   
    
    
}

@end
