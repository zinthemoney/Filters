//
//  AppDelegate.m
//  Filter
//
//  Created by Zhuo Huang on 4/29/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navBar"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    // back button
    UIImage *backButtonImage = [[UIImage imageNamed:@"roundBack"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 10)];//allow left arrow
    UIImage *backButtonImageLand = [[UIImage imageNamed:@"roundBackLand"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 10)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImageLand forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    // navigation button
    UIImage *barButtonImage = [[UIImage imageNamed:@"roundButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //UIButtons
    UIImage *resizableButton = [[UIImage imageNamed:@"blackButton.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(17, 5, 17, 5)];
    UIImage *resizableButtonHighlighted = [[UIImage imageNamed:@"greenButton.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(17, 5, 17, 5)];
    [[UIButton appearance] setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [[UIButton appearance] setBackgroundImage:resizableButtonHighlighted forState:UIControlStateSelected];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
