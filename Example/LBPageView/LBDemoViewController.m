//
//  LBDemoViewController.m
//  LBPageView_Example
//
//  Created by ivan on 2018/1/2.
//  Copyright © 2018年 j1103765636@iCloud.com. All rights reserved.
//

#import "LBDemoViewController.h"

#define LBPageViewPanGestureRecognizerState @"state"

@interface LBDemoViewController ()

@property (nonatomic) UIPanGestureRecognizer *recognizer;

@end

@implementation LBDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (UIScrollView *)topScrollView{
    __block UIScrollView *topView = nil;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            topView = obj;
            return ;
        }
    }];
    return topView;
}

- (void)viewWillAppear:(BOOL)animated{
    [self addObservers];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self removeObservers];
}

- (void)addObservers{
    UIScrollView *scrollView = [self topScrollView];
    self.recognizer = scrollView.panGestureRecognizer;
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    [self.recognizer addObserver:self forKeyPath:LBPageViewPanGestureRecognizerState    options:options context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:LBPageViewPanGestureRecognizerState]) {
        [self scrollStateChanged:change];
    }
}

- (void)scrollStateChanged:(NSDictionary *)info{
    CGFloat velocity = [self.recognizer velocityInView:[self topScrollView]].y;
    if (velocity < -5) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else if (velocity > 5){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else if (velocity ==0 ){
        
    }
}

- (void)removeObservers{
    [self.recognizer removeObserver:self forKeyPath:LBPageViewPanGestureRecognizerState];
    self.recognizer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
