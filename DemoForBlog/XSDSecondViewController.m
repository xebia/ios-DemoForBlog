//
//  XSDSecondViewController.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 Xebia. All rights reserved.
//

#import "XSDSecondViewController.h"

@interface XSDSecondViewController ()

@property (nonatomic) BOOL shouldGlitch;

@end


@implementation XSDSecondViewController

@synthesize animatedLabel, shouldGlitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
        animatedLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}
							
#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction) animateButtonPressed:(id)sender {
    NSLog(@"%@", sender);
    
    [UIView animateWithDuration:2.0 animations:^{
        CGRect frame = animatedLabel.frame;
        if(frame.origin.x != 10) {
            frame.origin.x = 10;
        } else {
            frame.origin.x = 100;
        }
        
        if (self.shouldGlitch) {
            if (frame.size.width == 150.0) {
                frame.size.width = 155.0;
            } else {
                frame.size.width = 150.0;
            }
        }
        
        animatedLabel.frame = frame;
    }];
}

-(IBAction) glitchToggled:(id)sender {
    NSLog(@"%@", sender);
    self.shouldGlitch = !self.shouldGlitch;
}


@end
