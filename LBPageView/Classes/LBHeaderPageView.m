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

@property (nonatomic , strong , readwrite) NSMutableArray<LBHeaderButton *> *buttonsArray;

@property (weak , nonatomic,readwrite) UIScrollView *scrollView;



@property (weak , nonatomic,readwrite) LBHeaderButton *selectedHeaderButton;

@property (assign , nonatomic,readwrite) NSUInteger currentIndex;


@property (assign , nonatomic) CGFloat dividedWidth;

@property (assign , nonatomic) BOOL isNavigation;

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
    _currentIndex = 0;
    self.backgroundColor = [UIColor lightGrayColor];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.scrollEnabled = NO;
    
    scrollView.alwaysBounceHorizontal = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    self.dividedWidth = titleButtonWidth;
    UIView *line = UIView.new;
    [self.scrollView addSubview:line];
    line.LB_height = LBHeaderView_LineHeight;
    line.LB_width = self.dividedWidth;
    line.LB_x = titlePadding;
    line.backgroundColor = [UIColor whiteColor];
    self.lineView = line;
}

- (void)layoutSubviews{
    [self placeSubViews];
    [super layoutSubviews];
   
}

- (void)placeSubViews{
    self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.lineView.LB_y = self.scrollView.frame.size.height - LBHeaderView_LineHeight;
    
    if ((self.buttonsArray.lastObject.LB_x + self.buttonsArray.lastObject.LB_width + titlePadding) <= self.scrollView.LB_width){
        CGFloat dividedWidth = (self.scrollView.LB_width - (self.buttonsArray.count + 1)*titlePadding) / self.buttonsArray.count;
        self.dividedWidth = dividedWidth;
        [self.buttonsArray enumerateObjectsUsingBlock:^(LBHeaderButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.LB_width = dividedWidth;
            if (obj.isSelected) {
                self.lineView.LB_width = dividedWidth;
            }
        }];
    }
    self.scrollView.contentSize = CGSizeMake(titlePadding * (self.buttonsArray.count + 1) + self.dividedWidth * self.buttonsArray.count, self.scrollView.frame.size.height);
    
    [self.buttonsArray enumerateObjectsUsingBlock:^(LBHeaderButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.LB_x = (obj.LB_width + titlePadding) * idx + titlePadding;
    }];
    
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
        button.LB_width = self.dividedWidth;
        button.LB_height = self.isNavigation?navigationTitleButtonHeight:titleButtonHeight;
        button.LB_y = titlePadding;
        button.tag = i;
        [button addTarget:self action:@selector(headerViewDidClickAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            self.selectedHeaderButton = button;
        }else{
            button.selected = NO;
        }
        [self.buttonsArray addObject:button];
        [self.scrollView addSubview:button];
    }
}

- (void)headerViewDidClickAtIndex:(LBHeaderButton *)sender{
    self.isNeedLineAnnimate = YES;
    [self refreshWithSelectedIndex:sender.tag];
    if ([self.delegate respondsToSelector:@selector(headerView:DidClickAtIndex:)]) {
        [self.delegate headerView:self DidClickAtIndex:sender.tag];
    }
}

+ (instancetype)headerViewWithTitlesArray:(NSArray *)titlesArray withNavigation:(BOOL)flag{
    LBHeaderView *headerView = [[self alloc] init];
    headerView.isNavigation = flag;
    headerView.titlesArray = titlesArray;
    return headerView;
}

- (void)refreshWithSelectedIndex:(NSUInteger)index{
    self.currentIndex = index;
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
    if (_isNeedLineAnnimate) {
        [UIView animateWithDuration:0.38 animations:^{
            self.lineView.LB_x = [self.buttonsArray objectAtIndex:index].LB_x;
            self.lineView.LB_width = self.dividedWidth;
        }];
    }else{
        self.lineView.LB_x = [self.buttonsArray objectAtIndex:index].LB_x;
        self.lineView.LB_width = self.dividedWidth;
    }
    
    if ((self.buttonsArray.lastObject.LB_x + self.buttonsArray.lastObject.LB_width + titlePadding) <= self.scrollView.LB_width) {
        isNeedDeal = NO;
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

        return;
    }
    CGRect f = CGRectMake(headerButton.center.x - self.scrollView.LB_width / 2.0, self.scrollView.LB_y, self.scrollView.LB_width, self.scrollView.LB_height);
    [self.scrollView scrollRectToVisible:f animated:YES];
}

@end






//-----------------------------------------------------**************----------------------------------------------------------------
@interface LBHeaderPageView()<LBHeaderViewDelegate>

@property (nonatomic , strong) NSArray *titlesArray;

@property (weak , nonatomic) LBHeaderView *titleView;

@property (nonatomic , assign) CGFloat s; // 滚动了多少距离

@property (nonatomic , assign)BOOL isFinished;

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
    //data
    _s = 0;
    _isFinished = NO;
    _lineWidthIsNeedAutoChange = NO;
    //UI
    
}

- (void)prepareHeaderUIWithData:(NSArray *)titlesArray{
    LBHeaderView *titleView = [LBHeaderView headerViewWithTitlesArray:titlesArray withNavigation:NO];
    titleView.delegate = self;
    [self addSubview:titleView];
    self.titleView = titleView;
    self.titleView.backgroundColor = [UIColor lightGrayColor];
}

- (void)placeSubViews{
    [super placeSubViews];
    CGRect titleViewFrame = CGRectMake(0, 0, self.frame.size.width,titleViewHeight);
    self.titleView.frame = titleViewFrame;
   
    
    self.pageViewController.view.frame = CGRectMake(self.titleView.frame.origin.x, self.titleView.frame.origin.y + self.titleView.frame.size.height, self.titleView.frame.size.width, self.frame.size.height - self.titleView.frame.size.height);
    
    
}

- (void)setLineWidthIsNeedAutoChange:(BOOL)lineWidthIsNeedAutoChange{
    if (lineWidthIsNeedAutoChange == _lineWidthIsNeedAutoChange) {
        return;
    }
    _lineWidthIsNeedAutoChange = lineWidthIsNeedAutoChange;
}

#pragma mark - LBHeaderViewDelegate
- (void)headerView:(LBHeaderView *)headerView DidClickAtIndex:(NSUInteger)index{
    [self scrollToViewControllerAtIndex:index];
}


//继承自父View
- (void)pageViewAtIndex:(NSUInteger)index{
    self.isFinished = YES;
    if (self.lineWidthIsNeedAutoChange) {
        self.titleView.isNeedLineAnnimate = NO;
    }else{
        self.titleView.isNeedLineAnnimate = YES;
    }
    [self.titleView refreshWithSelectedIndex:index];

}

- (void)pageViewDidScrollContentOffset:(NSDictionary *)infoDic{
    
    if (!self.lineWidthIsNeedAutoChange) {
        return;
    }
    [super pageViewDidScrollContentOffset:infoDic];
    LBHeaderButton *obj = self.titleView.selectedHeaderButton;
    CGFloat w = self.titleView.scrollView.LB_width;
    CGFloat c = self.titleView.dividedWidth  + titlePadding;
    NSValue *newdic = infoDic[@"new"];
    NSValue *olddic = infoDic[@"old"];
    CGPoint newPoint = [newdic CGPointValue];
    CGPoint oldPoint = [olddic CGPointValue];

    if (_isFinished) {
        self.s = 0;
        _isFinished = NO;
        return;
    }
    if (newPoint.x == oldPoint.x||newPoint.x * 2 ==  oldPoint.x) {
        self.s = 0;
        return;
    }
    self.s += newPoint.x - oldPoint.x;
    CGFloat objW = c / w * self.s;
    if (self.s > 0) {
        self.titleView.lineView.LB_width = self.titleView.dividedWidth + objW;
    }
    
    if (self.s < 0) {
        self.titleView.lineView.LB_width =self.titleView.dividedWidth- objW;
        self.titleView.lineView.LB_right = [self.titleView.buttonsArray objectAtIndex:self.titleView.currentIndex].LB_right;
    }
   
    
    NSLog(@"------------%@-----",infoDic);
    
}

@end

