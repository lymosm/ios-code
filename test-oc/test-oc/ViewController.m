//
//  ViewController.m
//  test-oc
//
//  Created by lymos on 2021/10/1.
//

#import "ViewController.h"
#import "xibController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *left_button;
@property (nonatomic, strong) UIButton *mybtn;
@property (nonatomic, strong) UIColor *myred;
// @property (nonatomic, strong) UIWindow *window2;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    NSLog(@"ViewController viewDidLoad in");
    //创建窗口
     // self.window2 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

      // 方式一：明确initWithNibName:方法的两个参数
      //UIViewController *vc = [[ViewController alloc] initWithNibName:@"View" bundle:[NSBundle mainBundle]];
      // 方式二：initWithNibName:方法的两个参数，只明确第一个参数，省略第二个参数
      // bundle写nil时，系统默认[NSBundle mainBundle]
      //UIViewController *vc = [[ViewController alloc] initWithNibName:@"View" bundle:nil];
      // 方式三：initWithNibName:方法的两个参数都省略
      //UIViewController *vc = [[ViewController alloc] initWithNibName:nil bundle:nil];
      // 方式四：调用init方法
     // UIViewController *vc = [[xibController alloc] init];

      // 设置窗口的根控制器
     // self.window2.rootViewController = vc;

      // 设置程序的主窗口并显示窗口
    //  [self.window2 makeKeyAndVisible];
    
    // Do any additional setup after loading the view.
    [self addText];
  //  [self alert];
   // UIView *superview = self.view;
    self.left_button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    self.left_button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.left_button setTitle: @"left button haha" forState: UIControlStateNormal];
  //  [self.view addSubview: self.left_button];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview = [story instantiateViewControllerWithIdentifier:@"my-view-controller"];
    
    // 获取view中的控件
    UISwitch *btn_switch = (UISwitch *)[self.view viewWithTag:2];
    UILabel *label = (UILabel *)[self.view viewWithTag:3];
    label.text = @"view label test";
    
}

- (void)addText {
    NSLog(@"This is a log test.ooo");
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) myViewXib{
    NSObject *mynib = [[NSBundle mainBundle]loadNibNamed:@"xibController"owner:self options:nil];
   // UIView *uiview_nib = [mynib objectAtIndex:0];

    // 添加到父视图中
    [self.navigationController pushViewController:mynib animated:YES];
}

/**
 弹窗信息 
 */
- (void) alert {
    UIAlertController *alert_obj = [UIAlertController alertControllerWithTitle: @"test" message: @"this is alert" preferredStyle: UIAlertControllerStyleAlert];
    [self presentViewController:alert_obj animated:YES completion:nil];
}

- (IBAction) done: (UIStoryboardSegue *)segue {
    [self.navigationController popViewControllerAnimated: YES];
}

@end
