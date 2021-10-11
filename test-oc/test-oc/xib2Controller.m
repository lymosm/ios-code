//
//  xib2Controller.m
//  test-oc
//
//  Created by lymos on 2021/10/10.
//

#import "xib2Controller.h"

@interface xib2Controller()

@end

@implementation xib2Controller
- (void) viewDidLoad{
    NSLog(@"viewDidLoad 被调用");
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(174, 50, 200, 200)];
    label.text = @"Hello World";
    [self.view addSubview:label];
    
   // [self addAlertView];
}

- (void) loadView{
    NSLog(@"loadView 被调用");
    [super loadView];
}

- (void) addAlertView{
    UIAlertController *uc = [UIAlertController alertControllerWithTitle:@"Test" message:@"This is a test" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:uc animated:YES completion:nil];
}

- (void) viewDidAppear{
    NSLog(@"viewDidAppear 被调用");
    [super viewDidAppear:YES];
    [self addAlertView];
}

- (void) didReceiveMemoryWarning {
    NSLog(@"didReceiveMemoryWarning 被调用");
    [super didReceiveMemoryWarning];
}

@end

