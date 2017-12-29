//
//  LBHeaderPageView.h
//  XSGeneration
//
//  Created by ivan on 2017/12/22.
//  Copyright © 2017年 ivan. All rights reserved.
//

#import "LBPageView.h"

@interface LBHeaderButton : UIControl

@property (nonatomic , weak) UILabel *labTitle;

@end


@class LBHeaderView;
@protocol LBHeaderViewDelegate <NSObject>

@optional
- (void)headerView:(LBHeaderView *)headerView DidClickAtIndex:(NSUInteger)index;

@end

@interface LBHeaderView : UIView

@property (nonatomic , strong) NSArray *titlesArray;

@property (weak , nonatomic,readonly) UIScrollView *scrollView;//无需操作

@property (weak , nonatomic,readonly) LBHeaderButton *selectedHeaderButton;

@property (weak , nonatomic) UIView *lineView; //无需操作

@property (assign , nonatomic,readonly) NSUInteger currentIndex;

@property (nonatomic , strong , readonly) NSMutableArray<LBHeaderButton *> *buttonsArray;

@property (assign , nonatomic) BOOL isNeedLineAnnimate;//to fix a little bug

@property (weak , nonatomic) id <LBHeaderViewDelegate> delegate;

+ (instancetype)headerViewWithTitlesArray:(NSArray *)titlesArray withNavigation:(BOOL)flag;

- (void)refreshWithSelectedIndex:(NSUInteger)index;

@end



@interface LBHeaderPageView : LBPageView

@property (assign , nonatomic) BOOL lineWidthIsNeedAutoChange;

/**
 直接用类方法初始化就行 直接搞定
 */
@property (strong , nonatomic) UIColor *titleViewBackgroundColor;

+ (instancetype)headerPageViewWithClassNamesArray:(NSArray *)classNamesArray titlesArray:(NSArray *)titlesArray;

@end
