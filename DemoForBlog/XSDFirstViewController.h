//
//  XSDFirstViewController.h
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface XSDFirstViewController : UITableViewController <NSFetchedResultsControllerDelegate>

//-- Data related properties
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
