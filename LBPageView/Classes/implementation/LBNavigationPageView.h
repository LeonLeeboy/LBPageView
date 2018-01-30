//
//  LBNavigationPageView.h
//  LBPageView
//
//  Created by ivan on 2017/12/28.
//

#import <LBPageView/LBPageView.h>
#import "ILBNavigationPageViewProtocol.h"

@interface LBNavigationPageView : LBPageView <ILBNavigationPageViewProtocol>

@property (assign , nonatomic) BOOL lineWidthIsNeedAutoChange;

@end
