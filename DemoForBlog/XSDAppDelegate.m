//
//  XSDAppDelegate.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XSDAppDelegate.h"

#import "XSDFirstViewController.h"

#import "XSDSecondViewController.h"

@implementation XSDAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[XSDFirstViewController alloc] initWithNibName:@"XSDFirstViewController" bundle:nil];
    UIViewController *viewController2 = [[XSDSecondViewController alloc] initWithNibName:@"XSDSecondViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark -
#pragma mark Core Data


/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
    if(managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    // get NSManagedObjectModel
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];    
    
    // get documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    // get NSPersistentStoreCoordinator
	NSString *databaseFilePath = [documents stringByAppendingPathComponent: @"DemoForBlog.sqlite"];
	NSURL *storeUrl = [NSURL fileURLWithPath: databaseFilePath];	
    
    if(DEBUG) {
        NSLog(@"Store URL: %@", databaseFilePath);
    }
    
	NSError *error;
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] 
                                                 initWithManagedObjectModel:managedObjectModel];
    
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        //Removes the data file and then tries again of creating MOC fails.:
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *rmError = nil;
        if([fileManager removeItemAtURL:storeUrl error:&rmError]) {
            NSLog(@"Error creating managed object context %@, %@", error, [error userInfo]);
            error = nil;
            if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
                NSLog(@"Unresolved error at 2nd attempt %@, %@", rmError, [rmError userInfo]);
                exit(-1);
            }
        } else {
            NSLog(@"Unresolved error %@, %@", rmError, [rmError userInfo]);
            exit(-1);
        }
    } 
    
    NSManagedObjectContext *newContext = [[NSManagedObjectContext alloc] init];
    [newContext setPersistentStoreCoordinator: coordinator];
    [newContext setUndoManager:nil];
    
    managedObjectContext = newContext;
    
    
    return managedObjectContext;
}

@end
