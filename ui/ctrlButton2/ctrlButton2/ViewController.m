//
//  ViewController.m
//  ctrlButton
//
//  Created by lymos on 2022/12/10.
//

#import "ViewController.h"

@interface ViewController ()
/*
- (IBAction)left;
- (IBAction)right;
- (IBAction)up;
- (IBAction)down;
- (IBAction)enlarge;
- (IBAction)narrow;
 */

@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)move:(id)sender;
- (IBAction)resize:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
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
 */

- (IBAction)resize:(id)sender {
    NSLog(@"resize");
    // frame method
    /*
    CGRect frame = self.btn.frame;
    long tag = [sender tag];
    if(tag == 1){
        frame.size.width += 10;
        frame.size.height += 10;
    }else{
        frame.size.width -= 10;
        frame.size.height -= 10;
    }
    self.btn.frame = frame;
     */
    // bounds method
    CGRect bounds = self.btn.bounds;
    long tag = [sender tag];
    if(tag == 1){
        bounds.size.width += 50;
        bounds.size.height += 50;
    }else{
        bounds.size.width -= 50;
        bounds.size.height -= 50;
    }
    /*
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration: 1];
    self.btn.bounds = bounds;
    [UIView commitAnimations];
     */
    [UIView animateWithDuration: 1.0 animations: ^{
        self.btn.bounds = bounds;
    }];
}

- (IBAction)move:(id)sender {
    NSLog(@"move");
    
    //  frame method
    /*
    CGRect frame = self.btn.frame;
    long tag = [sender tag];
    switch(tag){
        case 1:
            frame.origin.y -= 10;
            break;
        case 2:
            frame.origin.x += 10;
            break;
        case 3:
            frame.origin.y += 10;
            break;
        case 4:
            frame.origin.x -= 10;
            break;
    }
    self.btn.frame = frame;
     */
    
    // center method
    long tag = [sender tag];
    CGPoint center = self.btn.center;
    switch(tag){
        case 1:
            center.y -= 100;
            break;
        case 2:
            center.x += 100;
            break;
        case 3:
            center.y += 100;
            break;
        case 4:
            center.x -= 100;
            break;
    }
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration: 1];
    self.btn.center = center;
    [UIView commitAnimations];
}
@end
