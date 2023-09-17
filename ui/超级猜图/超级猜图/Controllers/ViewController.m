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
@property (weak, nonatomic) IBOutlet UIView *answer_view;
@property (weak, nonatomic) IBOutlet UIView *options_view;
- (IBAction)btnTipClick:(id)sender;

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
    
    if(self.index >= self.questions.count){
        NSLog(@"%s", "finish");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Action Tip" message: @"success" preferredStyle: UIAlertControllerStyleAlert];
        
        [alert addAction: [UIAlertAction actionWithTitle: @"ok" style: UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action){
            NSLog(@"click alert ok");
            self.index = -1;
            [self nextQuestion];
        }]];
        
        [self presentViewController: alert animated: YES completion: nil];
        
        return ;
    }
    
    NSLog(@"%d", self.index);
    CZQuestion *model = self.questions[self.index];
    
    self.lbl_title.text = model.title;
    self.lbl_index.text = [NSString stringWithFormat: @"%d / %lu", self.index + 1, self.questions.count];
    [self.bg setImage: [UIImage imageNamed: model.icon ] forState: UIControlStateNormal];
    
    self.btn_next.enabled = self.index != self.questions.count - 1;
    
    // 删除之前的
    // while(self.answer_view.subviews.firstObject){
    //    [self.answer_view.subviews.firstObject removeFromSuperview];
    // }
    // 或使用以下方式 不用自己写循环
    [self.answer_view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    
    // 创建答案
    NSInteger len = model.answer.length;
    CGFloat margin = 10;
    CGFloat w = 35;
    CGFloat h = 35;
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat left = (self.answer_view.frame.size.width - (len * w + (len - 1) * margin)) / 2;
    
    for(int i = 0; i < len; i++){
        UIButton *btn = [[UIButton alloc] init];
        
        [btn setBackgroundImage: [UIImage imageNamed: @"btn_answer"] forState: UIControlStateNormal];
        [btn setBackgroundImage: [UIImage imageNamed: @"btn_answer_highlighted"] forState: UIControlStateHighlighted];
        x = left + i * (w + margin);
        
        [btn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        btn.frame = CGRectMake(x,y, w, h);
        
        [self.answer_view addSubview: btn];
        
        [btn addTarget: self action:@selector(answerClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    
    
    [self createOptions: model];
    
}

- (void) createOptions: (CZQuestion *) model{
    [self.options_view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    NSInteger len = model.options.count;
    NSLog(@"count: %ld", len);
    CGFloat w = 35;
    CGFloat h = 35;
    CGFloat x = 0;
    CGFloat y = 0;
    
    int col = 5;
    CGFloat margin = 10;
    CGFloat margin_left = (self.options_view.frame.size.width - (w * col + (col - 1) * margin)) / 2;
    
    
    for( int i = 0; i < len; i++ ){
        UIButton *btn = [[UIButton alloc] init];
        NSLog(@"%d", i);
        [btn setBackgroundImage: [UIImage imageNamed: @"btn_answer"] forState: UIControlStateNormal];
        [btn setBackgroundImage: [UIImage imageNamed: @"btn_answer_highlighted"] forState: UIControlStateHighlighted];
        
        [btn setTitle: model.options[i] forState: UIControlStateNormal];
        [btn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        [btn setTag: i];
        
        int col_index = i % col;
        int row_index = i / col;
        
        x = margin_left + col_index * (w + margin);
        y = 0 + row_index * (h + margin);
        
        btn.frame = CGRectMake(x, y, w, h);
        
        [self.options_view addSubview: btn];
        [btn addTarget: self action: @selector(optionClick:) forControlEvents: UIControlEventTouchUpInside];
    }
    
    self.options_view.userInteractionEnabled = YES;
    
}

- (void) answerClick: (UIButton *) sender {
    [sender setTitle: nil forState: UIControlStateNormal];
    
    for(UIButton *btn in self.options_view.subviews){
        if(btn.tag == sender.tag){
            btn.hidden = NO;
            self.options_view.userInteractionEnabled = YES;
            break;
        }
    }
    [self setAnswerColor: [UIColor blackColor]];
}

- (void) optionClick: (UIButton *) sender {
    
    
    sender.hidden = YES;
    
    for(UIButton *btn in self.answer_view.subviews){
        if(btn.currentTitle == nil){
            [btn setTitle: sender.currentTitle forState: UIControlStateNormal];
            btn.tag = sender.tag;
            break;
        }
    }
    
    BOOL is_full = YES;
    
    NSMutableString *str_user = [NSMutableString string];
    
    for(UIButton *btn2 in self.answer_view.subviews){
        if(btn2.currentTitle == nil){
            is_full = NO;
            break;
        }else{
            [str_user appendString: btn2.currentTitle];
        }
    }
    NSLog(@"current user answer: %@", str_user);
    
    if(is_full == YES){
        self.options_view.userInteractionEnabled = NO;
        
        CZQuestion *model = self.questions[self.index];
        
        if([model.answer isEqualToString: str_user]){
            [self addScore: 100];
            [self setAnswerColor: [UIColor blueColor]];
            [self performSelector: @selector(nextQuestion) withObject: nil afterDelay: 0.5];
        }else{
            [self setAnswerColor: [UIColor redColor]];
        }
    }
}

- (void) addScore: (int) score{
    NSString *str = self.btn_score.currentTitle;
    int current_score = str.intValue;
    current_score = current_score + score;
    [self.btn_score setTitle: [NSString stringWithFormat: @"%d", current_score] forState: UIControlStateNormal];
}

- (void) setAnswerColor: (UIColor *) color{
    for(UIButton *btn in self.answer_view.subviews){
        [btn setTitleColor: color forState: UIControlStateNormal];
    }
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

- (IBAction)btnTipClick:(id)sender {
    [self addScore: -100];
    
    for(UIButton *btn in self.answer_view.subviews){
        [self answerClick: btn];
    }
    
    CZQuestion *model = self.questions[self.index];
    
    NSString *first = [model.answer substringToIndex: 1];
    
    for(UIButton *btn2 in self.options_view.subviews){
        if([btn2.currentTitle isEqualToString: first]){
            [self optionClick: btn2];
            break;
        }
    }
}

@end
