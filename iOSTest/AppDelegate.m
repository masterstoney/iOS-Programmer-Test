//
//  AppDelegate.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "AppDelegate.h"
#import "iOSTest-Swift.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    MenuViewController *mainMenuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainMenuViewController];
    UIColor *barColor = [UIColor colorWithRed:0.05490196078 green:0.3607843137 blue:0.537254902 alpha:1];
    [[UINavigationBar appearance] setBarTintColor:barColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTintColor: [UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]
    }];
    self.window.rootViewController = self.navController;

    return YES;
}

@end
