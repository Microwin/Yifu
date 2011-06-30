//
//  iPictureViewController.m
//  almondw
//
//  Created by Wu Jianjun on 11-5-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "iPictureViewController.h"
#import "ToolView.h"

@implementation iPictureViewController
@synthesize scrollView;
@synthesize plistData = _plistData;
@synthesize category = _category;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [scrollView release];
//    [_plistData release];
    [_category release];
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)hideAndShowToolView {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    if (_toolView.alpha == 0.f) {
        _toolView.alpha = 1.f;
    }
    else
        _toolView.alpha = 0.f;
    [UIView commitAnimations];
}

#pragma mark - View lifecycle

- (IBAction)hideNav:(id)sender {
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    self.tabBarController.tabBar.hidden = !self.tabBarController.tabBar.hidden;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _category];
    
    _plistData = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
//    UIImageView *subview = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@0.png", path, _category]]];
//    
//    if (subview) {
//        [self.scrollView addSubview:subview];
//    }
//    [subview release];
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(hideAndShowToolView) userInfo:nil repeats:YES];
    [time fire];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAndShowToolView)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    for (int i = 0; i < [_plistData count]; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIImageView *subview = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%d.png", path, i]]];

        
        subview.frame = frame;
        [self.scrollView addSubview:subview];
        [subview release];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * _plistData.count, self.scrollView.frame.size.height);
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ToolView" owner:self options:nil];
    _toolView = [array objectAtIndex:0];
    _toolView.center = CGPointMake(160, 320);
    [self.view addSubview:_toolView];
}

- (void)viewDidUnload
{
    self.scrollView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
