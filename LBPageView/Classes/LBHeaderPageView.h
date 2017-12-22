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

@property (weak , nonatomic) id <LBHeaderViewDelegate> delegate;

+ (instancetype)headerViewWithTitlesArray:(NSArray *)titlesArray;

- (void)refreshWithSelectedIndex:(NSUInteger)index;

@end



@interface LBHeaderPageView : LBPageView

/**
 直接用类方法初始化就行 直接搞定
 */
+ (instancetype)headerPageViewWithClassNamesArray:(NSArray *)classNamesArray titlesArray:(NSArray *)titlesArray;

@end
