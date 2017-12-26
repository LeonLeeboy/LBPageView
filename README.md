# LBPageView

## 辛辛苦苦点进来，～留个star吧～

 ![](http://g.recordit.co/GcTgEDfUam.gif)

- demo
`it support autoLayout , code etc.`

```
//auto layout and frame code both of them are ok!
NSArray *pageNamesArray = @[@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController"];
LBHeaderPageView *headerPageView = [LBHeaderPageView headerPageViewWithClassNamesArray:pageNamesArray titlesArray:@[@"首页",@"娱乐",@"体育",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
[self.view addSubview:headerPageView];
[headerPageView mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.mas_equalTo(10);
make.right.mas_equalTo(-10);
make.top.mas_equalTo(100);
make.bottom.mas_equalTo(-50);
}];

NSArray *pageNamesArray = @[@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController"];
LBHeaderPageView *headerPageView = [LBHeaderPageView headerPageViewWithClassNamesArray:pageNamesArray titlesArray:@[@"首页",@"娱乐",@"体育",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
[self.view addSubview:headerPageView];
headerPageView.frame = CGRectMake(0, 74, [UIScreen mainScreen].bounds.size.width , 200);

NSArray *pageNamesArray2 = @[@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController",@"UIViewController"];
LBHeaderPageView *headerPageView2 = [LBHeaderPageView headerPageViewWithClassNamesArray:pageNamesArray2 titlesArray:@[@"首页",@"娱乐",@"体育",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
headerPageView2.lineWidthIsNeedAutoChange = YES;
[self.view addSubview:headerPageView2];
headerPageView2.frame = CGRectMake(0, headerPageView.LB_y + headerPageView.LB_height + 10, [UIScreen mainScreen].bounds.size.width , 100);

```



[![CI Status](http://img.shields.io/travis/j1103765636@iCloud.com/LBPageView.svg?style=flat)](https://travis-ci.org/j1103765636@iCloud.com/LBPageView)
[![Version](https://img.shields.io/cocoapods/v/LBPageView.svg?style=flat)](http://cocoapods.org/pods/LBPageView)
[![License](https://img.shields.io/cocoapods/l/LBPageView.svg?style=flat)](http://cocoapods.org/pods/LBPageView)
[![Platform](https://img.shields.io/cocoapods/p/LBPageView.svg?style=flat)](http://cocoapods.org/pods/LBPageView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LBPageView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LBPageView'
```

## Author

j1103765636@iCloud.com, 1103765636@qq.com

## License

LBPageView is available under the MIT license. See the LICENSE file for more info.
