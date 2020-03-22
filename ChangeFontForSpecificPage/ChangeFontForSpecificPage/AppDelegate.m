//
//  AppDelegate.m
//  ChangeFontForSpecificPage
//
//  Created by Yu Fan on 2019/5/15.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    HomeViewController *homeController = [HomeViewController new];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeController];
    
    return YES;
}


@end
