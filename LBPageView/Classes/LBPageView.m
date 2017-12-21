//
//  LBPageView.m
//  XSGeneration
//
//  Created by ivan on 2017/12/21.
//  Copyright © 2017年 ivan. All rights reserved.
//

#define LB_RandomColor      [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];


#import "LBPageView.h"

@interface LBPageView()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic , strong) UIPageViewController *pageViewController;


@property (nonatomic , strong) NSMutableArray *ViewControllers;

@end

@implementation LBPageView

#pragma mark - lazy
- (NSMutableArray *)ViewControllers{
    if (_ViewControllers == nil) {
        _ViewControllers = [NSMutableArray array];
    }
    return _ViewControllers;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
    }
    return self;
}

- (void)prepare{
    //UI
    
    NSDictionary *option = @{UIPageViewControllerOptionInterPageSpacingKey:@20};
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [self addSubview:_pageViewController.view];
}


- (void)layoutSubviews{
    [self placeSubViews];
    [super layoutSubviews];
}

- (void)placeSubViews{
    self.pageViewController.view.frame = self.bounds;
}

+ (instancetype)pageViewWithControllerNamesArray:(NSArray *)classNameArray{
    LBPageView *view = [[LBPageView alloc] init];
    view.classNameArray = classNameArray;
    return view;
}

- (void)setClassNameArray:(NSArray *)classNameArray{
    if (classNameArray==_classNameArray || classNameArray == nil) {
        return;
    }
    _classNameArray = classNameArray;
    [self prepareUIWithData:classNameArray];
}

- (void)prepareUIWithData:(NSArray *)dataArray{
    if (dataArray.count <= 0 || dataArray == nil) {
        return;
    }
    NSString *firstClassName = [dataArray objectAtIndex:0];
    Class c = NSClassFromString(firstClassName);
    UIViewController *firstViewController = [[c alloc] init];
    if (![self.ViewControllers containsObject:firstViewController]) {
        [self.ViewControllers addObject:firstViewController];
    }
    firstViewController.view.backgroundColor = LB_RandomColor;
    [self.pageViewController setViewControllers:@[firstViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        ;
    }];
    
}

- (NSInteger)indexForViewController:(UIViewController *)controller{
    NSInteger index = [self.ViewControllers indexOfObject:controller];
    return index;
}

- (UIViewController *)controllerAtIndex:(NSUInteger)index{
    //在viewcontrollers array 中是否有，有就取出来，没有就添加加进去
    UIViewController *res_ViewController;
    if (index >= self.classNameArray.count) {
        return nil;
    }
    if (self.ViewControllers.count > index) {
         res_ViewController = [self.ViewControllers objectAtIndex:index];
        res_ViewController.view.backgroundColor = LB_RandomColor;
         return  res_ViewController;
    }
    //先添加
    UIViewController *ViewController = [[NSClassFromString([self.classNameArray objectAtIndex:index]) alloc] init];
    [self.ViewControllers addObject:ViewController];
    ViewController.view.backgroundColor = LB_RandomColor;
    return ViewController;
}

#pragma mark - UIPageViewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
     NSUInteger currentIndex = [self indexForViewController:viewController];
    if (viewController == nil ||currentIndex == 0) {
        return nil;
    }
    NSUInteger previousIndex = currentIndex - 1;
    return  [self controllerAtIndex:previousIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger currentIndex = [self indexForViewController:viewController];
    if (currentIndex >= self.classNameArray.count) {
        return nil;
    }
    NSUInteger nextIndex = currentIndex+1;
    return [self controllerAtIndex:nextIndex];
}




@end
