//
//  XSDSecondViewController.h
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 08-02-12.
//  Copyright (c) 2012 Xebia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSDSecondViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel * animatedLabel;

-(IBAction) animateButtonPressed:(id)sender;
-(IBAction) glitchToggled:(id)sender;

@end
