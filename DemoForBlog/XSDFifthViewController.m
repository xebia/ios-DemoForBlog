//
//  XSDFifthViewController.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 07-05-12.
//  Copyright (c) 2012 Xebia. All rights reserved.
//

#import "XSDFifthViewController.h"

@interface XSDViewExt : UIView

@end

@implementation XSDViewExt
//Custom hittesting is needed to allow the scroll view to respond to drag events outside it's own bounds.
- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return [self.subviews objectAtIndex:0];
    }
    return nil;
}
@end

@interface XSDFifthViewController ()

@end

@implementation XSDFifthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Fifth", @"Fifth");
        self.tabBarItem.image = [UIImage imageNamed:@"fifth"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    self.view = [[XSDViewExt alloc] initWithFrame:frame];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
    scrollView.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:0.6 alpha:0.5];
    scrollView.contentSize = CGSizeMake(320, 1000);
    scrollView.pagingEnabled = YES;

    //The interesting part. ;)
    // By not clipping to bounds we make sure the contentview's content is always shown. It allows half view being visible.
    scrollView.clipsToBounds = NO;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1000)];
    scrollView.contentSize = contentView.frame.size;

    contentView.backgroundColor= [UIColor colorWithRed:0.6 green:0.8 blue:0.8 alpha:0.5];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(110, 50, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
    [contentView addSubview:view1];

    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(110, 250, 100, 100)];
    view2.backgroundColor = [UIColor blueColor];
    [contentView addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(110, 450, 100, 100)];
    view3.backgroundColor = [UIColor purpleColor];
    [contentView addSubview:view3];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(110, 650, 100, 100)];
    view4.backgroundColor = [UIColor orangeColor];
    [contentView addSubview:view4];
    
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(110, 850, 100, 100)];
    view5.backgroundColor = [UIColor greenColor];
    [contentView addSubview:view5];
    
    [scrollView addSubview:contentView];

    
    [self.view addSubview:scrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
