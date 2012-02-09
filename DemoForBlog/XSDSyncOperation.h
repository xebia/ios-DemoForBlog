//
//  XSDSyncOperation.h
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Protocol for the importer to communicate with its delegate.
@protocol XSDSyncDelegate <NSObject>
// Notification posted by NSManagedObjectContext when saved.
- (void)syncDidSave:(NSNotification *)saveNotification;
- (void)syncDidAbort;
@end

@interface XSDSyncOperation : NSOperation {
}

@property(nonatomic, assign, readwrite) id <XSDSyncDelegate> syncDelegate;

@end
