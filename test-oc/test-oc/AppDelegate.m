//
//  AppDelegate.m
//  test-oc
//
//  Created by lymos on 2021/10/1.
//

#import "AppDelegate.h"
#import "xibController.h"

@interface AppDelegate ()
// @property (nonatomic, strong) UIWindow *window;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
  //  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 创建窗口 ios 13+ window交给sceneDelegate 管理
    /*
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    UIViewController *uvc = [[xibController alloc] init];
    self.window.rootViewController = uvc;
    [self.window makeKeyAndVisible];
    */
    NSLog(@"application  被调用");
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
