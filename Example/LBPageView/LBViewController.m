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

@interface LBViewController ()

@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
//
//    NSArray *pageNamesArray = @[@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController"];
//    LBHeaderPageView *headerPageView = [LBHeaderPageView headerPageViewWithClassNamesArray:pageNamesArray titlesArray:@[@"首页",@"娱乐",@"体育",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
//    [self.view addSubview:headerPageView];
//    headerPageView.frame = CGRectMake(0, 74, [UIScreen mainScreen].bounds.size.width , 200);

    NSArray *pageNamesArray2 = @[@"UIViewController",@"UIViewController",@"UIViewController"];
//    LBHeaderPageView *headerPageView2 = [LBHeaderPageView headerPageViewWithClassNamesArray:pageNamesArray2 titlesArray:@[@"首页",@"娱乐",@"体育",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
//    headerPageView2.lineWidthIsNeedAutoChange = YES;
//    [self.view addSubview:headerPageView2];
//    headerPageView2.frame = CGRectMake(0, headerPageView.LB_y + headerPageView.LB_height + 10, [UIScreen mainScreen].bounds.size.width , 200);
//
    LBNavigationPageView *navigationPageView = [LBNavigationPageView pageViewWithClassNamesArray:pageNamesArray2 titlesArray:@[@"首页",@"娱乐",@"体育"] ViewController:self];

    [self.view addSubview:navigationPageView];
    navigationPageView.frame = CGRectMake(0,100, [UIScreen mainScreen].bounds.size.width , 300);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
