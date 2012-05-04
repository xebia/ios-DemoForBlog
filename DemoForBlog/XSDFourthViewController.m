//
//  XSDFourthViewController.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 04-05-12.
//  Copyright (c) 2012 Xebia. All rights reserved.
//

#import "XSDFourthViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface XSDFourthViewController ()

@end

@implementation XSDFourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Fourth", @"Fourth");
        self.tabBarItem.image = [UIImage imageNamed:@"fourth"];
    }
    return self;
}

-(void)loadView {
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *glowView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width /2 -10, frame.size.height /2 -30, 20, 60)];
    glowView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | 
                                    UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleLeftMargin |
                                    UIViewAutoresizingFlexibleRightMargin;
    
    glowView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:glowView];
    
    //Setup the shadow on the view's CALayer.
    CALayer *viewLayer = glowView.layer;
    viewLayer.shadowOffset = CGSizeMake(0, 0);
    viewLayer.shadowColor = [[UIColor yellowColor] CGColor];
    viewLayer.shadowPath = [UIBezierPath bezierPathWithRect:glowView.bounds].CGPath;
    viewLayer.shadowRadius = 10.0f;
    viewLayer.shadowOpacity = 1.0f;
 
    //Let's animate it while we're at it.
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    [viewLayer addAnimation:animation forKey:@"shadowOpacity"];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
