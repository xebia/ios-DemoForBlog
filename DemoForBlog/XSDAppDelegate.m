//
//  XSDAppDelegate.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 Xebia. All rights reserved.
//

#import "XSDAppDelegate.h"

#import "XSDFirstViewController.h"

#import "XSDSecondViewController.h"

#import "XSDThirdViewController.h"

#import "XSDFourthViewController.h"

#import "XSDFifthViewController.h"

@implementation XSDAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize operationQueue;

static void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    // Normal launch stuff
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[XSDFirstViewController alloc] initWithNibName:@"XSDFirstViewController" bundle:nil];
    UIViewController *viewController2 = [[XSDSecondViewController alloc] initWithNibName:@"XSDSecondViewController" bundle:nil];
    UIViewController *viewController3 = [[XSDThirdViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *viewController4 = [[XSDFourthViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *viewController5 = [[XSDFifthViewController alloc] initWithNibName:nil bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3, viewController4, viewController5, nil];
    self.tabBarController.selectedIndex = 2;
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
#pragma mark Sync related code

-(void)doSync
{
    XSDSyncOperation *sync = [[XSDSyncOperation alloc]init];
    sync.syncDelegate = self;
    
    [sync setCompletionBlock:^{
        [self doSync];
    }];
    
    if (sync)
        [[self operationQueue] addOperation: sync];
}

- (void)syncDidSave:(NSNotification *)saveNotification {
    
    if ([NSThread isMainThread]) {
        [self.managedObjectContext mergeChangesFromContextDidSaveNotification:saveNotification];
    } else {
        [self performSelectorOnMainThread:@selector(syncDidSave:) withObject:saveNotification waitUntilDone:YES];
    }
}

- (void)syncDidAbort
{
    if ([NSThread isMainThread]) {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Sync Failed"
                                   message: @"An error occured while attempting to synchronize with the back-end."
                                  delegate: nil
                         cancelButtonTitle: @"OK"
                         otherButtonTitles: nil];
        [alert show];
    } else {
        [self performSelectorOnMainThread:@selector(syncDidAbort) withObject:nil waitUntilDone:NO];
    }
}

- (NSOperationQueue *)operationQueue {
    if (operationQueue == nil) {
        operationQueue = [[NSOperationQueue alloc] init];
        //hard coded settings, we want to make sure only one sync runs concurrently.
        operationQueue.maxConcurrentOperationCount = 1;
    }
    return operationQueue;
}

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
