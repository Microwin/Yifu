//
//  iPictureViewController.m
//  almondw
//
//  Created by Wu Jianjun on 11-5-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "iPictureViewController.h"

@implementation iPictureViewController
@synthesize scrollView;
@synthesize plistData = _plistData;
@synthesize category = _category;

static NSMutableArray *kImages = nil;

- (NSString *)currentPath {
    return [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _category];
}

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
    [kImages release];
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
        self.navigationController.navigationBarHidden = NO;
    }
    else {
        _toolView.alpha = 0.f;
        self.navigationController.navigationBarHidden = YES;

    }
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
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAndShowToolView)];
    [self.scrollView addGestureRecognizer:tap];
    [tap release];
    kImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_plistData count]; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        NSString *path = [NSString stringWithFormat:@"%@/%@", [self currentPath], [_plistData objectAtIndex:i]];
        UIImageView *subview = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        [subview setContentMode:UIViewContentModeScaleAspectFit];
        //        subview.tag = i + 1;
        
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        NSLog(@"Ori:%d", img.imageOrientation);
        
        subview.frame = frame;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:subview, @"imageView", path, @"path", nil];
        
        NSLog(@"Path:%@", [dic valueForKey:@"path"]);
        [kImages addObject:dic];
        [self.scrollView addSubview:[[kImages objectAtIndex:i] valueForKey:@"imageView"]];
        [subview release];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * _plistData.count, self.scrollView.frame.size.height);
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ToolView" owner:self options:nil];
    _toolView = [array objectAtIndex:0];
    _toolView.center = CGPointMake(160, 400);
    _toolView.delegate = self;
    [self.view addSubview:_toolView];
}

- (void)viewDidUnload
{
    self.scrollView = nil;
    kImages = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationItem setTitle:_category];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//当前页面的图片
- (UIImage *)currentImage {
    CGPoint point = self.scrollView.contentOffset;
    NSUInteger page = point.x / 320;
    NSLog(@"x:%f, y:%f", point.x, point.y);
    UIImage *theImage = ((UIImageView *)[[kImages objectAtIndex:page] valueForKey:@"imageView"]).image;
    return theImage;
}
//当前是第几页
- (NSUInteger)currentPage {
    CGPoint point = self.scrollView.contentOffset;
    NSUInteger page = point.x / 320;
    return page;
}
#pragma mark - Mail Delegate
- (void)sendMail:(id)sender{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.navigationBar.barStyle = UIBarStyleBlackOpaque;
    picker.mailComposeDelegate = self;
    [picker setSubject:[NSString stringWithFormat:@"分享照片"]];
    
    [picker setMessageBody:@"I share you this nice image from iFashion." isHTML:NO];
    

    [picker addAttachmentData:UIImagePNGRepresentation([self currentImage]) mimeType:@"image/png" fileName:@"SharePicture.png"];
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:picker animated:YES];
    [picker release];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
    
	[self dismissModalViewControllerAnimated:YES];
}




#pragma mark - ToolView Delegate
- (void)sharePicture {
    [self sendMail:nil];
}

- (void)deletePicture {
    if ([kImages count] == 0) {
        return;
    }
//    NSString *str = [NSString stringWithFormat:@"%@/%d.png", [self currentPath], [self currentPage]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除图片" message:@"确认要删除这张图片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];

}

#pragma mark - Alert Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {

        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationDuration:.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];

        NSString *str = [[kImages objectAtIndex:[self currentPage]] valueForKey:@"path"];
        NSLog(@"PATH:%@", str);
        [[NSFileManager defaultManager] removeItemAtPath:str error:nil];
        [[[kImages objectAtIndex:[self currentPage]] valueForKey:@"imageView"] removeFromSuperview];
        //如果不是最后一张图片
        if ([kImages count] != ([self currentPage] + 1)) {
            for (int i = [self currentPage] + 1; i < [kImages count]; i++) {
                UIImageView *imgV = [[kImages objectAtIndex:i] valueForKey:@"imageView"];
                CGRect rect = imgV.frame;
                rect.origin.x -= 320;
                imgV.frame = rect;
            }
            
            CGSize size = self.scrollView.contentSize;
            size.width -= 320;
            self.scrollView.contentSize = size;
        }
        //如果只有一张图片
        else if ([kImages count] == 1) {
            CGSize size = CGSizeMake(320, 480);
            self.scrollView.contentSize = size;
        }
        //如果是排在最后的一张图片
        else {
            CGSize size = self.scrollView.contentSize;
            size.width -= 320;
//            [self.scrollView scrollRectToVisible:CGRectMake(size.width, 0, 320, 480) animated:YES];
            self.scrollView.contentSize = size;
        }

        

        [kImages removeObjectAtIndex:[self currentPage]];
        [UIView commitAnimations];

    }
}
@end
