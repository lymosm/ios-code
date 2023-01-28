//
//  ViewController.m
//  imageView
//
//  Created by lymos on 2023/1/28.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)next:(id)sender;
- (IBAction)prev;
@property (nonatomic, strong) NSArray *picArr;
@property (nonatomic, assign) int index;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.picArr;
    self.index = 0;
    [self next: nil];
    NSDictionary *dict1 = @{@"name": @"admin", @"age": @12};
    NSDictionary *dict2 = @{@"name": @"user", @"age": @14};
    NSArray *arr = @[dict1, dict2];
    NSLog(@"%@", arr);
}

/**
  重写getter方法
 */
- (NSArray *) picArr{
    NSLog(@"get pic Arr init");
    if(_picArr == nil){
        NSLog(@"get pic Arr");
        NSString *path = [[NSBundle mainBundle] pathForResource: @"picData" ofType: @".plist"];
        // NSLog(@"%@", path);
        NSArray *arr = [NSArray arrayWithContentsOfFile: path];
        NSLog(@"%@", arr);
        _picArr = arr;
    }
    return _picArr;
}

- (IBAction)prev {
    self.index--;
    [self setImages];
}

- (IBAction)next:(id)sender {
    NSLog(@"action next");
    self.index++;
    [self setImages];
}
- (void)setImages {
    NSDictionary *dict = self.picArr[self.index - 1];
    NSString *indexLabel = [NSString stringWithFormat: @"%d/%ld", self.index, self.picArr.count ];
    NSString *title = dict[@"label"];
    UIImage *img = [UIImage imageNamed: dict[@"icon"]];
    self.indexLabel.text = indexLabel;
    self.myTitle.text = title;
    self.img.image = img;
    NSLog(@"index: %d", self.index);
    self.btnNext.enabled = self.index != self.picArr.count;
    self.btnPrev.enabled = self.index != 1;
}
@end
