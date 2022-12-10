//
//  ViewController.m
//  ctrlButton
//
//  Created by lymos on 2022/12/10.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)left;
- (IBAction)right;
- (IBAction)up;
- (IBAction)down;
- (IBAction)enlarge;
- (IBAction)narrow;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)narrow {
    NSLog(@"narrow");
    CGRect frame = self.btn.frame;
    frame.size.width -= 10;
    frame.size.height -= 10;
    self.btn.frame = frame;
}

- (IBAction)enlarge {
    NSLog(@"enlarge");
    CGRect frame = self.btn.frame;
    frame.size.width += 10;
    frame.size.height += 10;
    self.btn.frame = frame;
}

- (IBAction)down {
    NSLog(@"down");
    CGRect frame = self.btn.frame;
    frame.origin.y += 10;
    self.btn.frame = frame;
}

- (IBAction)up {
    NSLog(@"up");
    CGRect frame = self.btn.frame;
    frame.origin.y -= 10;
    self.btn.frame = frame;
}

- (IBAction)right {
    NSLog(@"right");
    CGRect frame = self.btn.frame;
    frame.origin.x += 10;
    self.btn.frame = frame;
}

- (IBAction)left {
    NSLog(@"left");
    CGRect frame = self.btn.frame;
    frame.origin.x -= 10;
    self.btn.frame = frame;
}
@end
