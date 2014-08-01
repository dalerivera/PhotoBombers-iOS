//
//  DRAppDelegate.m
//  PhotoBombers
//
//  Created by Dale Rivera on 7/25/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "DRAppDelegate.h"
#import "PhotosViewController.h"
#import <SimpleAuth/SimpleAuth.h>
@implementation DRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    SimpleAuth.configuration[@"instagram"] = @{
         @"client_id": @"57e7a9a434ff442fb8d137d1ed505891",
         SimpleAuthRedirectURIKey : @"photobombers://auth/instagram"
     };
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    PhotosViewController *photosViewController = [[PhotosViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:photosViewController];
    self.window.rootViewController = navigationController;
    UINavigationBar *navigationBar = navigationController.navigationBar;
    navigationBar.barTintColor = [UIColor colorWithRed:242.0/255.0 green:122.0/255.0 blue:87.0/255.0 alpha:1.0];
    navigationBar.barStyle = UIBarStyleBlackOpaque;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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
