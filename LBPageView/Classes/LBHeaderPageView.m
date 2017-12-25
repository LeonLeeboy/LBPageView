//
//  LBHeaderPageView.m
//  XSGeneration
//
//  Created by ivan on 2017/12/22.
//  Copyright © 2017年 ivan. All rights reserved.
//

#import "LBHeaderPageView.h"

//---------------------------------------------------------------------------------------------------------------------
@implementation LBHeaderButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
    }
    return self;
}

- (void)prepare{
    //ui
    UILabel *labTitle = [[UILabel alloc] init];
    labTitle.font = [UIFont systemFontOfSize:14];
    labTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labTitle];
    self.labTitle = labTitle;
    self.selected = NO;
}

- (void)layoutSubviews{
    [self placeSubViews];
    [super layoutSubviews];
   self.labTitle.frame = self.bounds;
}

- (void)placeSubViews{
    self.labTitle.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
        self.labTitle.textColor = [UIColor blackColor];
    }else{
        self.backgroundColor = LB_RandomColor;
        self.labTitle.textColor = [UIColor whiteColor];
    }
}

@end



//--------------------------------------------------------*************-------------------------------------------------------------

@interface LBHeaderView ()

@property (strong , nonatomic) NSArray *titlesArray;

@property (nonatomic , strong) NSMutableArray<LBHeaderButton *> *buttonsArray;
@property (weak , nonatomic) UIScrollView *scrollView;

@property (weak , nonatomic) UIView *lineView;

@property (weak , nonatomic) LBHeaderButton *selectedHeaderButton;

@end

@implementation LBHeaderView


- (NSMutableArray<LBHeaderButton *> *)buttonsArray{
    if (_buttonsArray == nil) {
        _buttonsArray = [NSMutableArray array];
    }
    
    return _buttonsArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
    }
    return self;
}

- (void)prepare{
    
    self.backgroundColor = [UIColor lightGrayColor];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.scrollEnabled = NO;
    
    scrollView.alwaysBounceHorizontal = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    UIView *line = UIView.new;
    [self addSubview:line];
    line.LB_height = LBHeaderView_LineHeight;
    line.LB_width = titleButtonWidth;
    line.LB_x = titlePadding;
    line.backgroundColor = [UIColor whiteColor];
    self.lineView = line;
}

- (void)layoutSubviews{
    [self placeSubViews];
    [super layoutSubviews];
   
}

- (void)placeSubViews{
    self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - LBHeaderView_LineHeight);
    self.scrollView.contentSize = CGSizeMake(titlePadding * (self.buttonsArray.count + 1) + titleButtonWidth * self.buttonsArray.count, self.scrollView.frame.size.height);
    self.lineView.LB_y = self.scrollView.frame.size.height;
    [self.buttonsArray enumerateObjectsUsingBlock:^(LBHeaderButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         obj.LB_x = (obj.LB_width + titlePadding) * idx + titlePadding;
    }];
    
    if ((self.buttonsArray.lastObject.LB_x + self.buttonsArray.lastObject.LB_width + titlePadding) <= self.scrollView.LB_width){
        CGFloat dividedWidth = (self.scrollView.LB_width - (self.buttonsArray.count + 1)*titlePadding) / self.buttonsArray.count;
        
        [self.buttonsArray enumerateObjectsUsingBlock:^(LBHeaderButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.LB_width = dividedWidth;
            if (obj.isSelected) {
                self.lineView.LB_width = obj.LB_width;
            }
        }];
    }
    
}

- (void)setTitlesArray:(NSArray *)titlesArray{
    if (titlesArray == nil || titlesArray == _titlesArray) {
        return;
    }
    _titlesArray = titlesArray;
    [self prepareUIWithData:titlesArray];
}

- (void)prepareUIWithData:(NSArray *)titlesArray{
    for (int i = 0 ; i < titlesArray.count; i++) {
        LBHeaderButton *button = [[LBHeaderButton alloc] init];
        button.labTitle.text = [titlesArray objectAtIndex:i];
        button.backgroundColor = LB_RandomColor;
        button.LB_width = titleButtonWidth;
        button.LB_height = titleButtonHeight;
        button.LB_y = titlePadding;
        button.tag = i;
        [button addTarget:self action:@selector(headerViewDidClickAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            self.selectedHeaderButton = button;
        }
        [self.buttonsArray addObject:button];
        [self.scrollView addSubview:button];
    }
}

- (void)headerViewDidClickAtIndex:(LBHeaderButton *)sender{
    [self refreshWithSelectedIndex:sender.tag];
    if ([self.delegate respondsToSelector:@selector(headerView:DidClickAtIndex:)]) {
        [self.delegate headerView:self DidClickAtIndex:sender.tag];
    }
}

+ (instancetype)headerViewWithTitlesArray:(NSArray *)titlesArray{
    LBHeaderView *headerView = [[self alloc] init];
    headerView.titlesArray = titlesArray;
    return headerView;
}

- (void)refreshWithSelectedIndex:(NSUInteger)index{
     NSUInteger count = self.buttonsArray.count;
    CGSize contentSize = self.scrollView.contentSize;
    [self.buttonsArray enumerateObjectsUsingBlock:^(LBHeaderButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
        if (idx == index) {
            obj.selected = YES;
        }
    }];
    if (index == 0 ) {
        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.LB_width, self.scrollView.LB_height) animated:NO];
    }
    if (index == count -1) {
        [self.scrollView scrollRectToVisible:CGRectMake(contentSize.width - self.scrollView.LB_width, 0, self.scrollView.LB_width, self.scrollView.LB_height) animated:NO];
    }
  
   
    [self dealScrollElementsWithIndex:index];
}

- (void)dealScrollElementsWithIndex:(NSUInteger)index{
    
    BOOL isNeedDeal = NO;
    if ((self.buttonsArray.lastObject.LB_x + self.buttonsArray.lastObject.LB_width + titlePadding) <= self.scrollView.LB_width) {
        isNeedDeal = NO;
        LBHeaderButton *obj = [self.buttonsArray objectAtIndex:index];
        self.lineView.LB_x = obj.LB_x;
    }else{
        isNeedDeal = YES;
    }
    if (!isNeedDeal) {
        return;
    }
    //找出可以处理button 和 需要处理的按钮
    __block NSMutableArray *needDealsButton = [NSMutableArray array];
    __block LBHeaderButton *headerButton;
    [self.buttonsArray enumerateObjectsUsingBlock:^(LBHeaderButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((self.scrollView.center.x < obj.center.x  && (self.scrollView.contentSize.width - obj.center.x) > self.scrollView.LB_width/2.0)&&index == idx) {
            [needDealsButton addObject:obj];
            headerButton = obj;
        }
    }];
    self.selectedHeaderButton = headerButton;
    if (headerButton==nil) {
        LBHeaderButton *obj = [self.buttonsArray objectAtIndex:index];
        //to fix bug
        if ((obj.LB_x + obj.LB_width) > (self.scrollView.contentOffset.x + self.scrollView.LB_width)) {
             [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - self.scrollView.LB_width, 0, self.scrollView.LB_width, self.scrollView.LB_height) animated:NO];
        }
        
        if (self.scrollView.contentOffset.x >= obj.LB_x ) {
             [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.LB_width, self.scrollView.LB_height) animated:NO];
        }
        CGFloat x = obj.LB_x - self.scrollView.contentOffset.x;
        [UIView animateWithDuration:0.38 animations:^{
            self.lineView.LB_x = x;
        }];
        return;
    }
    CGRect f = CGRectMake(headerButton.center.x - self.scrollView.LB_width / 2.0, self.scrollView.LB_y, self.scrollView.LB_width, self.scrollView.LB_height);
    [self.scrollView scrollRectToVisible:f animated:YES];
    [UIView animateWithDuration:0.38 animations:^{
        [UIView animateWithDuration:0.38 animations:^{
            self.lineView.LB_x = self.scrollView.center.x - headerButton.LB_width / 2.0;
        }];
    }];
    
}

@end






//-----------------------------------------------------**************----------------------------------------------------------------
@interface LBHeaderPageView()<LBHeaderViewDelegate>

@property (nonatomic , strong) NSArray *titlesArray;

@property (weak , nonatomic) LBHeaderView *titleView;



@end

@implementation LBHeaderPageView




+ (instancetype)headerPageViewWithClassNamesArray:(NSArray *)classNamesArray titlesArray:(NSArray *)titlesArray{
    LBHeaderPageView *headerPageView = [[self alloc] init];
    headerPageView.classNameArray = classNamesArray;
    headerPageView.titlesArray = titlesArray;
    return headerPageView;
}

- (void)setTitlesArray:(NSArray *)titlesArray{
    if (titlesArray == nil || titlesArray == _titlesArray) {
        return;
    }
    _titlesArray = titlesArray;
    [self prepareHeaderUIWithData:titlesArray];
}

- (void)prepare{
    [super prepare];
    LBHeaderView *titleView = [[LBHeaderView alloc] init];;
    titleView.delegate = self;
    [self addSubview:titleView];
    self.titleView = titleView;
    self.titleView.backgroundColor = [UIColor lightGrayColor];
}

- (void)prepareHeaderUIWithData:(NSArray *)titlesArray{
    self.titleView.titlesArray = titlesArray;
}

- (void)placeSubViews{
    [super placeSubViews];
    CGRect titleViewFrame = CGRectMake(0, 0, self.frame.size.width,titleViewHeight);
    self.titleView.frame = titleViewFrame;
   
    
    self.pageViewController.view.frame = CGRectMake(self.titleView.frame.origin.x, self.titleView.frame.origin.y + self.titleView.frame.size.height, self.titleView.frame.size.width, self.frame.size.height - self.titleView.frame.size.height);
    
    
}

//继承自父View
- (void)pageViewAtIndex:(NSUInteger)index{
    [self.titleView refreshWithSelectedIndex:index];

}

- (void)headerView:(LBHeaderView *)headerView DidClickAtIndex:(NSUInteger)index{
    [self scrollToViewControllerAtIndex:index];
}




@end

