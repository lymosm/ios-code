//
//  VCFirst.m
//  test-oc
//
//  Created by lymos on 2021/10/11.
//

#import "VCFirst.h"

@interface VCFirst ()

@end

@implementation VCFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITabBarItem *tbi = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil tag:101];
    tbi.image = [[UIImage imageNamed:@"3d_picture"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tbi.selectedImage = [[UIImage imageNamed:@"3d_video"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = tbi;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
