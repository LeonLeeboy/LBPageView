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
#import "ILBPageView.h"


@interface LBPageView : UIView <ILBPageView>

@property (nonatomic , strong) NSArray *classNameArray;

@property (nonatomic, strong) UIPageViewController *pageViewController;


@end
