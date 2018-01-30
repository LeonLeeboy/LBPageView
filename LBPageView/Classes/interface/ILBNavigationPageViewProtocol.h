//
//  ILBNavigationPageViewProtocol.h
//  LBPageView
//
//  Created by ivan on 2018/1/29.
//

#import <Foundation/Foundation.h>

@protocol ILBNavigationPageViewProtocol <NSObject>
@required
+ (instancetype)pageViewWithClassNamesArray:(NSArray *)classNamesArray titlesArray:(NSArray *)titlesArray ViewController:(UIViewController *)vc;

@end
