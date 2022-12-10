//
//  ViewController.m
//  Calculator
//
//  Created by lymos on 2022/12/7.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)calculator:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *num1;
@property (weak, nonatomic) IBOutlet UITextField *num2;
@property (weak, nonatomic) IBOutlet UILabel *total;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)calculator:(UIButton *)sender {
    NSString *num1 = self.num1.text;
    NSString *num2 = self.num2.text;
    int n1 = [num1 intValue];
    int n2 = [num2 intValue];
    int total = n1 + n2;
    // 转成字符串并赋值
    self.total.text = [NSString stringWithFormat: @"%d", total];
    
    // 隐藏键盘 单个操作
   // [self.num1 resignFirstResponder];
   // [self.num2 resignFirstResponder];
    
    // 隐藏键盘 整个操作 view
    [self.view endEditing: YES];
    
}
@end
