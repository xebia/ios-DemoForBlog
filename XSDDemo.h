//
//  Demo.h
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 09-02-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface XSDDemo : NSManagedObject

@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *graphDataForDemo;
@end

@interface XSDDemo (CoreDataGeneratedAccessors)

- (void)addGraphDataForDemoObject:(NSManagedObject *)value;
- (void)removeGraphDataForDemoObject:(NSManagedObject *)value;
- (void)addGraphDataForDemo:(NSSet *)values;
- (void)removeGraphDataForDemo:(NSSet *)values;

@end
