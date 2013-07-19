//
//  XSDSixthViewController.m
//  DemoForBlog
//
//  Created by Jeroen Leenarts on 19-07-13.
//
//

#import "XSDSixthViewController.h"

@interface XSDSixthViewController ()

@end

@implementation XSDSixthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Sixth", @"Sixth");
        self.tabBarItem.image = [UIImage imageNamed:@"sixth"];
    }
    return self;
}

-(void)loadView {
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *unalignedImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sixth"]];
    
    unalignedImageView.center = self.view.center;
    [self.view addSubview:unalignedImageView];
    
    UILabel *misalignedLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 50.75, 120, 20)];
    misalignedLabel.text = @"Am I misaligned?";
    [self.view addSubview:misalignedLabel];
    
    UITextView *infoTextView = [[UITextView alloc]initWithFrame:CGRectMake(5, 320, 310, 60)];
    infoTextView.text = @"Select from the simulator menu: Debug - Color misaligned images. Look for magenta colored views. (Yellow means stretched views, those are not a big problem.)";
    [self.view addSubview:infoTextView];
}

@end
