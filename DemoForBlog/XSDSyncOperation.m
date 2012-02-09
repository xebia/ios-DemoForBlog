//
//  XSDSyncOperation.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "XSDAppDelegate.h"
#import "XSDEntityNames.h"
#import "XSDSyncOperation.h"
#import "XSDDemo.h"

NSString * const SyncOperationFinishedNotification = @"SyncOperationFinishedNotification";

@implementation XSDSyncOperation

@synthesize syncDelegate;

- (BOOL)syncOnContext:(NSManagedObjectContext*) context {
    
    NSDate *syncStart = [NSDate date];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:DEMO_ENTITY_NAME inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSError *error = nil;
//    NSArray *demos = [context executeFetchRequest:fetchRequest error:&error];
//    if (error) {
//        NSLog(@"Error occured fetching demo objects: %@", error);
//        return NO;
//    }
    
    XSDDemo *demo = [NSEntityDescription insertNewObjectForEntityForName:DEMO_ENTITY_NAME inManagedObjectContext:context];
    demo.name = @"Test";
    demo.info = @"Info";

    
    //Store resulting objects and broadcast the save operation to the syncdelegate.
    [[NSNotificationCenter defaultCenter] addObserver:syncDelegate selector:@selector(syncDidSave:) name:NSManagedObjectContextDidSaveNotification object:context];

    [context save:&error];
    [[NSNotificationCenter defaultCenter] removeObserver:syncDelegate name:NSManagedObjectContextDidSaveNotification object:context];
    if (error) {
        NSLog(@"Error occured saving sync: %@", error);
        return NO;
    }
    
    
    //If succesful
    NSDate *syncEnd = [NSDate date];
    NSLog(@"Sync completed in %f seconds.", ([syncEnd timeIntervalSinceDate:syncStart]));

    return YES;
}

#pragma mark NSURLConnection Delegate methods
/*
 Disable caching so that each time we run this app we are starting with a clean slate. You may not want to do this in your application.
 */
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void)main {
    @autoreleasepool {
    
        XSDAppDelegate *appDelegate = (XSDAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //Create new managed object context on existing persistence store coordinator.

        //Create a new NSManagedObjectContext for this thread, but take the NSPersistentStoreCoordinator from the existing NSManagedObjectContext.
        NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: [[appDelegate managedObjectContext] persistentStoreCoordinator]];
        [managedObjectContext setUndoManager:nil];

        if (![self syncOnContext:managedObjectContext]) {
            [syncDelegate syncDidAbort];
        }
        
    }
}

@end
