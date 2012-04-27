//
//  XSDThirdViewController.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 26-04-12.
//  Copyright (c) 2012 Xebia. All rights reserved.
//

#import "XSDThirdViewController.h"

@interface XSDThirdViewController ()

-(void)rightContainedViewTapped;
-(void)rightUncontainedViewTapped;

@end

@implementation XSDThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Third", @"Third");
        self.tabBarItem.image = [UIImage imageNamed:@"third"];
    }
    return self;
}

-(void)loadView {
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(5.0, 5.0, 0.5 * frame.size.width -10.0, frame.size.height -10.0)];
    leftView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    leftView.isAccessibilityElement = YES;
    leftView.accessibilityLabel = @"Left";
    leftView.backgroundColor = [UIColor colorWithRed:0.8 green:0.75 blue:0.75 alpha:0.75];
    [self.view addSubview:leftView];
    
    UIView *rightContainerView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width / 2.0 + 5.0, 5.0, 0.5 * frame.size.width -10.0, frame.size.height * 0.5 - 10.0)];
    rightContainerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    rightContainerView.backgroundColor = [UIColor colorWithRed:0.6 green:0.75 blue:0.75 alpha:0.75];
    [self.view addSubview:rightContainerView];
    
    UIView *rightContainedView = [[UIView alloc] initWithFrame:CGRectMake(5.0, 5.0, rightContainerView.frame.size.width -10.0, rightContainerView.frame.size.height -10.0)];
    rightContainedView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    rightContainedView.isAccessibilityElement = YES;
    rightContainedView.accessibilityLabel = @"Right Contained";
    rightContainedView.backgroundColor = [UIColor colorWithRed:0.4 green:0.75 blue:0.75 alpha:0.75];
    [rightContainerView addSubview:rightContainedView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width / 2.0 + 5.0, frame.size.height / 2.0 + 5.0, rightContainedView.frame.size.width, rightContainedView.frame.size.height)];
    rightView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    rightView.isAccessibilityElement = YES;
    rightView.accessibilityLabel = @"Right";
    rightView.backgroundColor = [UIColor colorWithRed:0.2 green:0.75 blue:0.75 alpha:0.75];
    [self.view addSubview:rightView];
    
    UITapGestureRecognizer *tapGestureContained = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightContainedViewTapped)];
    [rightContainedView addGestureRecognizer:tapGestureContained];
    
    UITapGestureRecognizer *tapGestureUncontained = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightUncontainedViewTapped)];
    [rightView addGestureRecognizer:tapGestureUncontained];
}

-(void)rightContainedViewTapped {
    UIView *containedView = [[[[self.view subviews] objectAtIndex:1] subviews]objectAtIndex:0];

    CGRect frame = containedView.frame;

    if (containedView.frame.origin.x == -50) {
        frame.origin.x = 5;
    } else {
        frame.origin.x = -50;
    }
    
    containedView.frame = frame;
}

-(void)rightUncontainedViewTapped {
    UIView *uncontainedView = [[self.view subviews] objectAtIndex:2];
    
    CGRect frame = uncontainedView.frame;
    
    if (uncontainedView.frame.origin.x == self.view.frame.size.width / 2.0 + 5.0) {
        frame.origin.x = self.view.frame.size.width / 2.0 + 5.0 - 50.0;
    } else {
        frame.origin.x = self.view.frame.size.width / 2.0 + 5.0;
    }
    
    uncontainedView.frame = frame;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
