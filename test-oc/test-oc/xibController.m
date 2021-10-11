//
//  xibController.m
//  test-oc
//
//  Created by lymos on 2021/10/9.
//

#import "xibController.h"
// #import "ViewController.h"

@interface xibController()

@end

@implementation xibController

/**
 *  重写init
 */
- (instancetype) init{
    self = [super init];
    if(self){
        NSLog(@"init 被调用 self = %@", self);
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        NSLog(@"initWithCoder 被调用 self = %@", self);
    }
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awakeFromNib 被调用");
}

- (void) showView{
    
}

/**
 * 重写viewDidLoad
 */
- (void) viewDidLoad{
    NSLog(@"viewDidLoad 被调用");
  //  xibController *myxib_ctrl = [[xibController alloc] init];
    // [[NSBundle mainBundle] loadNibNamed:@"xibController" owner:self options:nil];
  //  xibController *bfView= (xibController *)[[[NSBundle mainBundle] loadNibNamed:@"xibController" owner:self options:nil] lastObject];
  //  [self.view addSubview:bfView];
    
 // UIView *myxib = [[[NSBundle mainBundle] loadNibNamed:@"myxib" owner:nil options:nil] lastObject];
    
    UIViewController *cxib = [[UIViewController alloc] initWithNibName:@"xib2Controller" bundle:nil];
    
 //[self presentedViewController:myxib animated: YES completion: nil];
   // UIView *uiv = [myxib objectAtIndex:0];
    /*
    UIViewController *uiv = [[xibController alloc] init];
   [self.navigationController pushViewController:uiv animated:YES];
  //  [self.navigationController popViewControllerAnimated: YES];
 */
    [self.view addSubview:cxib.view];
    [super viewDidLoad];
    
    /*
    ViewController *v = [[ViewController alloc] init];
    [v viewDidLoad];
    [self addChildViewController:v];
     */
}

@end
