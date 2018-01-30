//
//  ILBHeaderPageViewProtocol.h
//  LBPageView
//
//  Created by ivan on 2018/1/29.
//

#import <Foundation/Foundation.h>

@protocol ILBHeaderPageViewProtocol <NSObject>


@required
+ (instancetype)headerPageViewWithClassNamesArray:(NSArray *)classNamesArray titlesArray:(NSArray *)titlesArray;

@end
