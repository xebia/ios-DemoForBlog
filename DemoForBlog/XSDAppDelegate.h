//
//  XSDAppDelegate.h
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSDAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    NSManagedObjectContext *managedObjectContext;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

@end
