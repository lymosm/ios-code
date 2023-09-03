//
//  ViewController.m
//  超级猜图
//
//  Created by lymos on 2023/8/13.
//

#import "ViewController.h"
#import "CZQuestion.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray * questions;
@property (weak, nonatomic) IBOutlet UIButton *btn_score;
@property (weak, nonatomic) IBOutlet UILabel *lbl_index;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_next;
@property (weak, nonatomic) IBOutlet UIButton *bg;

@property (weak, nonatomic) IBOutlet UIButton *cover;

@property (nonatomic, assign) CGRect origin_bg_frame;

- (IBAction)clickbBigImage:(id)sender;
- (IBAction)clickShowBig:(id)sender;

@property (nonatomic, assign) int index;
- (IBAction)clickNext:(id)sender;



@end

@implementation ViewController

- (NSArray *) questions {
    if(_questions == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource: @"questions.plist" ofType: nil];
        // NSLog(@"%@", path);
        NSArray *array_dict = [NSArray arrayWithContentsOfFile: path];
        // NSLog(@"%@", array_dict);
        NSMutableArray *array_model = [ NSMutableArray array];
        
        for(NSDictionary *dict in array_dict){
            CZQuestion *model = [CZQuestion questionWithDict: dict];
            [array_model addObject: model];
        }
        _questions = array_model;
    }
    return _questions;
}

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
    
    self.index = -1;
    [self nextQuestion];
}


- (IBAction)clickNext:(id)sender {
    [self nextQuestion];
}

- (void) nextQuestion{
    NSLog(@"click next");
    self.index++;
    NSLog(@"%d", self.index);
    CZQuestion *model = self.questions[self.index];
    
    self.lbl_title.text = model.title;
    self.lbl_index.text = [NSString stringWithFormat: @"%d / %lu", self.index + 1, self.questions.count];
    [self.bg setImage: [UIImage imageNamed: model.icon ] forState: UIControlStateNormal];
    
    self.btn_next.enabled = self.index != self.questions.count - 1;
}
- (IBAction)clickShowBig:(id)sender {
    [self showBigImage];
}

- (IBAction)clickbBigImage:(id)sender {
    if(self.cover == nil){
        [self showBigImage];
    }else{
        [self smallImage];
    }
    
}

- (void) showBigImage{
    self.origin_bg_frame = self.bg.frame;
    UIButton *cover = [[UIButton alloc] init];
    cover.frame = self.view.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    
    [self.view addSubview: cover];
    
    // 把图片放到阴影上面
    [self.view bringSubviewToFront: self.bg];
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = w;
    CGFloat x = 0;
    CGFloat y = (self.view.frame.size.height - h) / 2;
    
    [UIView animateWithDuration: 0.4 animations: ^{
        cover.alpha = 0.6;
        self.bg.frame = CGRectMake(x,y, w, h);
    }];
    self.cover = cover;
    
    [cover addTarget: self action: @selector(smallImage) forControlEvents: UIControlEventTouchUpInside];
    
}

- (void) smallImage {
    [UIView animateWithDuration: 0.5 animations: ^{
        self.bg.frame = self.origin_bg_frame;
        self.cover.alpha = 0;
    } completion: ^(BOOL finished){
        if(finished){
            [self.cover removeFromSuperview];
            self.cover = nil;
        }
    }];
}

@end
