//
//  XSDAppDelegate.h
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 Xebia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XSDSyncOperation.h"

@interface XSDAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, XSDSyncDelegate> {
    NSManagedObjectContext *managedObjectContext;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain, readonly) NSOperationQueue *operationQueue;

-(void)doSync;

@end
