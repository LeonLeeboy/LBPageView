//
//  LBNavigationPageView.h
//  LBPageView
//
//  Created by ivan on 2017/12/28.
//

#import <LBPageView/LBPageView.h>

@interface LBNavigationPageView : LBPageView

@property (assign , nonatomic) BOOL lineWidthIsNeedAutoChange;

+ (instancetype)pageViewWithClassNamesArray:(NSArray *)classNamesArray titlesArray:(NSArray *)titlesArray ViewController:(UIViewController *)vc;

@end
