//
//  LBNavigationPageView.m
//  LBPageView
//
//  Created by ivan on 2017/12/28.
//

#import "LBNavigationPageView.h"
#import "LBHeaderPageView.h"


@interface LBNavigationPageView()<LBHeaderViewDelegate>

@property (nonatomic , strong) NSArray *titlesArray;

@property (strong , nonatomic) LBHeaderView *titleView;

@property (weak , nonatomic) UIViewController *viewontroller;


@property (nonatomic , assign) CGFloat s; // 滚动了多少距离

@end

@implementation     LBNavigationPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare{
    [super prepare];
   //data
    _s = 0;
    _lineWidthIsNeedAutoChange = NO;
    //UI
    LBHeaderView *titleView = [[LBHeaderView alloc] init];;
    titleView.delegate = self;
    self.titleView = titleView;
}

#pragma mark - LBHeaderViewDelegate
- (void)headerView:(LBHeaderView *)headerView DidClickAtIndex:(NSUInteger)index{
    [self scrollToViewControllerAtIndex:index];
}

+ (instancetype)pageViewWithClassNamesArray:(NSArray *)classNamesArray titlesArray:(NSArray *)titlesArray ViewController:(UIViewController *)vc{
    LBNavigationPageView *navigationPageView = [[self alloc] init];
    navigationPageView.classNameArray = classNamesArray;
    navigationPageView.titlesArray = titlesArray;
    navigationPageView.viewontroller = vc;
    return navigationPageView;
}

- (void)setTitlesArray:(NSArray *)titlesArray{
    if (titlesArray == nil || titlesArray == _titlesArray) {
        return;
    }
    _titlesArray = titlesArray;
    [self prepareHeaderUIWithData:titlesArray];
}

- (void)prepareHeaderUIWithData:(NSArray *)titlesArray{
    LBHeaderView *titleView = [LBHeaderView headerViewWithTitlesArray:titlesArray withNavigation:YES];
    titleView.delegate = self;
    [self addSubview:titleView];
    self.titleView = titleView;
    self.titleView.backgroundColor = [UIColor lightGrayColor];
}

- (void)setViewontroller:(UIViewController *)viewontroller{
    if (viewontroller==nil || viewontroller == _viewontroller) {
        return;
    }
    _viewontroller = viewontroller;

    self.titleView.frame = CGRectMake(0, 0, navigationTitleViewWidth, navigationTitleViewHeight);
    [self.titleView layoutIfNeeded];
    _viewontroller.navigationItem.titleView =  self.titleView;
}

- (void)pageViewDidScrollContentOffset:(NSDictionary *)infoDic{
    
    [super pageViewDidScrollContentOffset:infoDic];
    if (!self.lineWidthIsNeedAutoChange) {
        return;
    }
    
    CGFloat w = self.LB_width;
    CGFloat c = self.titleView.dividedWidth  + titlePadding;
    NSValue *newdic = infoDic[@"new"];
    NSValue *olddic = infoDic[@"old"];
    CGPoint newPoint = [newdic CGPointValue];
    CGPoint oldPoint = [olddic CGPointValue];
    self.s += newPoint.x - oldPoint.x;
    CGFloat k = self.LB_width / self.titleView.LB_width;
    CGFloat objW = c / w * self.s * (1.0/k);
    if (self.s > 0) {
        self.titleView.lineView.LB_width = self.titleView.dividedWidth + objW;
    }
    
    if (self.s < 0) {
        self.titleView.lineView.LB_width =self.titleView.dividedWidth- objW;
        self.titleView.lineView.LB_x = [self.titleView.buttonsArray objectAtIndex:self.titleView.currentIndex].LB_x + objW;
    }
    
    
    
}

//继承自父View
- (void)pageViewAtIndex:(NSUInteger)index{

    if (self.lineWidthIsNeedAutoChange) {
        self.titleView.isNeedLineAnnimate = NO;
    }else{
        self.titleView.isNeedLineAnnimate = YES;
    }
    [self.titleView refreshWithSelectedIndex:index];
    
}


- (void)pageViewDidEndDecelerate{
    self.s = 0;
    self.titleView.lineView.LB_width = self.titleView.dividedWidth;
    self.titleView.lineView.LB_x = self.titleView.selectedHeaderButton.LB_x;
}


@end
