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

@interface LBViewController ()

@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray<NSString *> * controllersArray = @[@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController"];
    LBPageView *pageView = [LBPageView pageViewWithControllerNamesArray:controllersArray];
    [self.view addSubview:pageView];
    pageView.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 2 * 10, [UIScreen mainScreen].bounds.size.height - 100 - 20);
    NSArray *pageNamesArray = @[@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController"];
    LBHeaderPageView *headerPageView = [LBHeaderPageView headerPageViewWithClassNamesArray:pageNamesArray titlesArray:@[@"首页",@"娱乐",@"体育",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
    [self.view addSubview:headerPageView];
    headerPageView.frame = CGRectMake(10, 74, [UIScreen mainScreen].bounds.size.width - 2 * 10, [UIScreen mainScreen].bounds.size.height - 74);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
