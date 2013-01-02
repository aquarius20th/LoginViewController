//
//  KTLAppDelegate.m
//  LoginViewController
//
//  Created by Steven Baranski on 1/2/13.
//  Copyright (c) 2013 komorka technology, llc. All rights reserved.
//

#import "KTLAppDelegate.h"
#import "KTLLoginViewController.h"

@implementation KTLAppDelegate

#pragma mark - UIApplicationDelegate

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    KTLLoginViewController *vc = [[KTLLoginViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.viewController = navVC;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
