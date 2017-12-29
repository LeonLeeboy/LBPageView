//
//  LBPageView.m
//  XSGeneration
//
//  Created by ivan on 2017/12/21.
//  Copyright © 2017年 ivan. All rights reserved.
//



#import "LBPageView.h"

@interface LBPageView()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>


@property (assign , nonatomic) NSUInteger currentPageIndex;

@property (nonatomic , strong) NSMutableArray *ViewControllers;

@property (weak , nonatomic) UIScrollView *scrollView;

@end

@implementation LBPageView

#pragma mark - lazy
- (NSMutableArray *)ViewControllers{
    if (_ViewControllers == nil) {
        _ViewControllers = [NSMutableArray arrayWithCapacity:self.classNameArray.count];
        for (int i = 0; i < self.classNameArray.count; i ++) {
            [_ViewControllers addObject:@""];
        }
       
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
    _currentPageIndex = 0;
    
    //UI
    
    NSDictionary *option = @{UIPageViewControllerOptionInterPageSpacingKey:@20};
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [self addSubview:_pageViewController.view];
    [self findScrollView:_pageViewController].delegate = self;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self pageViewDidEndDragging];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self pageViewDidEndDecelerate];
}

- (void)pageViewDidEndDragging{}

- (void)pageViewDidEndDecelerate{}



- (UIScrollView *)findScrollView:(UIPageViewController *)pageViewController{
    __block UIScrollView *scro;
    [pageViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            scro = obj;
        }
    }];
    return scro;
}

- (void)layoutSubviews{
    [self placeSubViews];
    [super layoutSubviews];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self removeObservers];
    if (newSuperview) {
        [self addObservers];
    }
}

- (void)addObservers{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    self.scrollView = [self findScrollView:_pageViewController];
    [self.scrollView addObserver:self forKeyPath:LBPageViewContentOffset options:options context:nil];
}

- (void)removeObservers{
    [self.scrollView removeObserver:self forKeyPath:LBPageViewContentOffset];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:LBPageViewContentOffset]) {
        if([self findScrollView:_pageViewController].isDragging){
            [self pageViewDidScrollContentOffset:change];
        }
       
        
    }
}
- (void)pageViewDidScrollContentOffset:(NSDictionary *)infoDic{
    
}

- (void)scrollToViewControllerAtIndex:(NSUInteger)index{
    UIViewController *vc = [self controllerAtIndex:index];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        ;
    }];
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
        [self.ViewControllers replaceObjectAtIndex:0 withObject:firstViewController];
    }
    firstViewController.view.backgroundColor = [UIColor lightGrayColor];
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
    if (self.ViewControllers.count <= index) {
        return nil;
    }
    UIViewController *ViewController ;
    if ([[self.ViewControllers objectAtIndex:index] isKindOfClass:[NSString class]]) {
         ViewController = [[NSClassFromString([self.classNameArray objectAtIndex:index]) alloc] init];
        [self.ViewControllers replaceObjectAtIndex:index withObject:ViewController];
        ViewController.view.backgroundColor = [UIColor lightGrayColor];
    }else{
        ViewController = [self.ViewControllers  objectAtIndex:index];
    }
   
    
    return ViewController;
}

#pragma mark - UIPageViewController datasource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
     NSUInteger currentIndex = [self indexForViewController:viewController];
    if (viewController == nil ||currentIndex == 0) {
        return nil;
    }
    
    NSUInteger previousIndex = currentIndex - 1;
    [self pageViewAtIndex:currentIndex];
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

- (void)pageViewAtIndex:(NSUInteger)index{}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    self.currentPageIndex = [self indexForViewController:pendingViewControllers[0]];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        [self pageViewAtIndex:_currentPageIndex];
    }
}





@end
