//
//  LBHeaderPageView.h
//  XSGeneration
//
//  Created by ivan on 2017/12/22.
//  Copyright © 2017年 ivan. All rights reserved.
//

#import "LBPageView.h"
#import "ILBHeaderPageViewProtocol.h"

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

@property (assign , nonatomic) CGFloat dividedWidth;

@property (assign , nonatomic) BOOL isNeedLineAnnimate;//to fix a little bug

@property (weak , nonatomic) id <LBHeaderViewDelegate> delegate; //代理

+ (instancetype)headerViewWithTitlesArray:(NSArray *)titlesArray withNavigation:(BOOL)flag;

- (void)refreshWithSelectedIndex:(NSUInteger)index;

@end



@interface LBHeaderPageView : LBPageView <ILBHeaderPageViewProtocol>


/**
 直接用类方法初始化就行 直接搞定
 */
@property (strong , nonatomic) UIColor *titleViewBackgroundColor;


@property (assign , nonatomic) BOOL lineWidthIsNeedAutoChange;


@end
