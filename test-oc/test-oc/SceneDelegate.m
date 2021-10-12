//
//  SceneDelegate.m
//  test-oc
//
//  Created by lymos on 2021/10/1.
//

#import "SceneDelegate.h"
#import "xibController.h"
#import "xib2Controller.h"
#import "xib3ViewController.h"
#import "VCFirst.h"
#import "VCSecond.h"
#import "VCThird.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
   
    // 把window的内容替换成别的controller
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    
    // self.window.backgroundColor = [UIColor redColor];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setWindowScene:windowScene];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    UIViewController *uvc = [[xib3ViewController alloc] init];
    // uvc.view.backgroundColor = UIColor.redColor;
    self.window.rootViewController = uvc;
    
    [self.window makeKeyAndVisible];
    NSLog(@"willConnectToSession  被调用");
    
    VCFirst *vf = [[VCFirst alloc] init];
    VCSecond *vs = [[VCSecond alloc] init];
    VCThird *vt = [[VCThird alloc] init];
    
    vf.title = @"首页";
    vs.title = @"搜索";
    vt.title = @"个人";
    
    vf.view.backgroundColor = [UIColor redColor];
    vs.view.backgroundColor = [UIColor blueColor];
    vt.view.backgroundColor = [UIColor yellowColor];
    
    // nav 包含viewController
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vf];
    nav1.navigationBar.barTintColor = [UIColor whiteColor];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vs];
    nav2.navigationBar.barTintColor = [UIColor whiteColor];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vt];
    nav3.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    UITabBarController *ub = [[UITabBarController alloc] init];
    ub.tabBar.tintColor = [UIColor colorWithRed:112.0/255.0 green:100.0/255.0 blue:255.0/255.0 alpha:1.0];
    // 直接放 viewController
   // NSArray *arr = [NSArray arrayWithObjects:vf, vs, vt, nil];
    
    // 直接放nav
    NSArray *arr = [NSArray arrayWithObjects:nav1, nav2, nav3, nil];
    
    ub.viewControllers = arr;
    self.window.rootViewController = ub;
    
    ub.tabBar.translucent = NO;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    NSLog(@"sceneDidDisconnect  被调用");
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    
    NSLog(@"sceneDidBecomeActive  被调用");
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    NSLog(@"sceneWillResignActive  被调用");
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    NSLog(@"sceneWillEnterForeground  被调用");
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    NSLog(@"sceneDidEnterBackground  被调用");
}


@end
