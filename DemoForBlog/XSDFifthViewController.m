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
        // Custom initialization
    }
    return self;
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
