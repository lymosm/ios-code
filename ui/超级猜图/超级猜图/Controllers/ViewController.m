//
//  ViewController.m
//  超级猜图
//
//  Created by lymos on 2023/8/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


// 修改状态栏样式，用于黑色背景
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

// 隐藏状态栏
- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


@end
