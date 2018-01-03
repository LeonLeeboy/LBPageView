//
//  LBViewController.m
//  LBPageView
//
//  Created by j1103765636@iCloud.com on 12/21/2017.
//  Copyright (c) 2017 j1103765636@iCloud.com. All rights reserved.
//

#import "LBViewController.h"
#import <LBPageView/LBPageView.h>
#import <LBPageView/LBHeaderPageView.h>
#import <LBPageView/LBNavigationPageView.h>

#define topSpace [UIApplication sharedApplication].statusBarFrame.size.height + 44

@interface LBViewController ()

@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    });
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - topSpace)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.bounds.size.height * 2);
    [self.view addSubview:scrollView];
    

    NSArray *pageNamesArray2 = @[@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController"];
    LBHeaderPageView *headerPageView2 = [LBHeaderPageView headerPageViewWithClassNamesArray:pageNamesArray2 titlesArray:@[@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育"]];
    headerPageView2.lineWidthIsNeedAutoChange = YES;
    [scrollView addSubview:headerPageView2];
    headerPageView2.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 200);

    LBNavigationPageView *navigationPageView = [LBNavigationPageView pageViewWithClassNamesArray:pageNamesArray2 titlesArray:@[@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育",@"首页",@"娱乐",@"体育"] ViewController:self];
    navigationPageView.lineWidthIsNeedAutoChange = NO;
    [scrollView addSubview:navigationPageView];
    navigationPageView.frame = CGRectMake(0,300, [UIScreen mainScreen].bounds.size.width , 100);
    
    

//    NSArray *pageNamesArray2 = @[@"UIViewController",@"UIViewController",@"UIViewController"];
//    LBHeaderPageView *headerPageView2 = [LBHeaderPageView headerPageViewWithClassNamesArray:pageNamesArray2 titlesArray:@[@"首页",@"娱乐",@"体育"]];
//    headerPageView2.lineWidthIsNeedAutoChange = YES;
//    [self.view addSubview:headerPageView2];
//    headerPageView2.frame = CGRectMake(0, 84, [UIScreen mainScreen].bounds.size.width , 200);
//
//    LBNavigationPageView *navigationPageView = [LBNavigationPageView pageViewWithClassNamesArray:pageNamesArray2 titlesArray:@[@"首页",@"娱乐",@"体育"] ViewController:self];
//    navigationPageView.lineWidthIsNeedAutoChange = YES;
//    [self.view addSubview:navigationPageView];
//    navigationPageView.frame = CGRectMake(0,300, [UIScreen mainScreen].bounds.size.width , 300);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
