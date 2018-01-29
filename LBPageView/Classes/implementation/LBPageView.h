//
//  LBPageView.h
//  XSGeneration
//
//  Created by ivan on 2017/12/21.
//  Copyright © 2017年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LBPageView.h"
#import "LBPageViewConst.h"


@interface LBPageView : UIView

@property (nonatomic , strong) NSArray *classNameArray;

@property (nonatomic, strong) UIPageViewController *pageViewController;


+ (instancetype)pageViewWithControllerNamesArray:(NSArray *)classNameArray;

- (void)pageViewDidScrollContentOffset:(NSDictionary *)infoDic;

- (void)scrollToViewControllerAtIndex:(NSUInteger)index;

- (void)placeSubViews;

- (void)prepare;

- (void)pageViewAtIndex:(NSUInteger)index;

- (void)pageViewDidEndDragging;
- (void)pageViewDidEndDecelerate;

@end
