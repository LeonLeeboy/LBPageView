//
//  LBPageView.h
//  XSGeneration
//
//  Created by ivan on 2017/12/21.
//  Copyright © 2017年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBPageView : UIView

@property (nonatomic , strong) NSArray *classNameArray;

+ (instancetype)pageViewWithControllerNamesArray:(NSArray *)classNameArray;

@end
