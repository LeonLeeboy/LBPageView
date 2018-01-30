//
//  ILBPageView.h
//  LBPageView
//
//  Created by ivan on 2018/1/30.
//

#import <Foundation/Foundation.h>

@protocol ILBPageView <NSObject>


@required
+ (instancetype)pageViewWithControllerNamesArray:(NSArray *)classNameArray;

- (void)pageViewDidScrollContentOffset:(NSDictionary *)infoDic;

- (void)scrollToViewControllerAtIndex:(NSUInteger)index;

- (void)placeSubViews;

- (void)prepare;

- (void)pageViewAtIndex:(NSUInteger)index; //for subClass

- (void)pageViewDidEndDragging; //for subClass
- (void)pageViewDidEndDecelerate;//for subClass

@end
