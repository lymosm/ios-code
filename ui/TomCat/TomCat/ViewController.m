//
//  ViewController.m
//  TomCat
//
//  Created by lymos on 2023/1/28.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgObj;
// @property (nonatomic, strong) NSString *picName;
- (IBAction)actionDrink;
- (IBAction)actionFart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void) startAnimating: (int)count picName: (NSString *) picName{
    if(self.imgObj.isAnimating){
        return ;
    }
    NSMutableArray *arrM = [NSMutableArray array];
    for(int i = 0; i < count; i++){
        
        NSString *imgName = [NSString stringWithFormat: @"%@_%02d.jpg", picName, i];
        
        
        // 使用缓存，不释放内存
        // UIImage *img = [UIImage imageNamed: imgName];
        
        // 不使用缓存，释放内存
       // NSString *dir = [NSString stringWithFormat: @"%@_%02d.imageset", picName, i];
        NSString *path = [[NSBundle mainBundle] pathForResource: imgName ofType: nil inDirectory: @"Animations2"];
        // NSString *path = [[NSBundle mainBundle] pathForResource: imgName ofType: nil];
        // NSLog(@"%@", dir);
        NSLog(@"%@", path);
        UIImage *img = [UIImage imageWithContentsOfFile: path];
        
        
        [arrM addObject: img];
    }
    self.imgObj.animationImages = arrM;
    self.imgObj.animationDuration = self.imgObj.animationImages.count * 0.1;
    self.imgObj.animationRepeatCount = 1;
    [self.imgObj startAnimating];
    
    // 延迟销毁对象，释放内存
    [self.imgObj performSelector:@selector(setAnimationImages:)  withObject: nil afterDelay: self.imgObj.animationImages.count * 0.1];
    
}

/**
 test for this
 */
- (void) sayHi{
    
}

- (IBAction)actionFart {
    [self startAnimating: 27 picName: @"fart"];
}

- (IBAction)actionDrink {
    [self startAnimating: 81 picName: @"drink"];
}
@end
