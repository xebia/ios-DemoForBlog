//
//  XSDFirstViewController.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XSDFirstViewController.h"

#import "XSDAppDelegate.h"
#import "EntityNames.h"

@implementation XSDFirstViewController

@synthesize fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - Table View methods

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
//    XSDAppDelegate *appDelegate = (XSDAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate navigateToNextManagedObject:managedObject];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView 
{
    NSUInteger count = [[self.fetchedResultsController sections] count];
    
    return count;
}

- (NSInteger)tableView:(UITableView*)tableView 
 numberOfRowsInSection:(NSInteger)section 
{
    NSInteger numberOfRows = 0;
    if ([[self.fetchedResultsController sections] count]) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}

- (void)configureCell:(UITableViewCell*)cell 
          atIndexPath:(NSIndexPath*)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [[cell textLabel] setText:[[managedObject valueForKey:@"name"] description]];
    [[cell detailTextLabel] setText:[[managedObject valueForKey:@"info"] description]];
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:[item objectForKey:@"imageKey"] ofType:@"png"];
    //    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    //    cell.imageView.image = theImage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;                                  
    }
    
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController*)fetchedResultsController 
{
    // if allready created return the created conroller;
    if (fetchedResultsController) return fetchedResultsController;
    
    // managed object context
    XSDAppDelegate *appDelegate = (XSDAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // create fetch request for project entities
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:DEMO_ENTITY_NAME  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"syncForProject = %@", self.sync];
    //    [fetchRequest setPredicate:predicate];
    
    //    [fetchRequest setFetchBatchSize:20];
    
    // set sort properties
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // create a new NSFetchedResultsController
    NSFetchedResultsController *frc = nil;
    frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                              managedObjectContext:context 
                                                sectionNameKeyPath:nil 
                                                         cacheName:nil];
    //                                                         cacheName:@"Root"];
    // delegate events to self
    [frc setDelegate:self];
    
    // assign the created controller to the property and release it
    [self setFetchedResultsController:frc];
    
    return fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {  
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            //TODO
            //            [[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // perform fetch
    NSError *error = nil;
    [[self fetchedResultsController] performFetch:&error];
    if (error) {
        NSLog(@"Error occured fetching projects: %@", error);
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(synchingDone:)
//                                                 name:SyncOperationFinishedNotification object:nil];
//    [self refreshToolbarItemsToRunningState: NO withUpdatedDate: nil];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
