//
//  ViewController.m
//  createButtonWithCode
//
//  Created by lymos on 2022/12/11.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
   // UIButton *button = [[UIButton alloc] init];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    
    [button setTitle: @"click me" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    
    [button setTitle: @"actived" forState: UIControlStateHighlighted];
    [button setTitleColor: [UIColor blueColor] forState: UIControlStateHighlighted];
    
    UIImage *img_btn = [UIImage imageNamed: @"btn"];
    UIImage *img_btn2 = [UIImage imageNamed: @"btn2"];
    [button setBackgroundImage: img_btn forState: UIControlStateNormal];
    [button setBackgroundImage: img_btn2 forState: UIControlStateHighlighted];
    
    button.frame = CGRectMake(150, 150, 100, 100);
    
    [button addTarget: self action: @selector(actionClick) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview: button];
}

- (void) actionClick{
    NSLog(@"click");
}
@end
