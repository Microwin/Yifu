    //
//  BVScrollPageController.m
//  Study
//
//  Created by hjlin on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageScrollPageController.h"
#import "ImageOperController.h"
#import "ImageBrowseController.h"


@implementation ImageScrollPageController

@synthesize imageNames = imageNames_;
@synthesize page = page_;

@synthesize viewControllers = viewControllers_;
@synthesize scrollView = scrollView_;
@synthesize currentPage = currentPage_;

@synthesize browser = browser_;
@synthesize category = _category;

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

static NSMutableArray *kImages = nil;
static NSMutableArray *kControllers = nil;
- (NSString *)currentPath {
    return [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _category];
}

- (id)initWithImageNames:(NSMutableArray *)imageNames page:(int)page {

	if ((self = [super init])) {
        
	}
	isEditing = NO;
	self.imageNames = imageNames;
	self.page = page;
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	DEBUG_LOG_NULL;
    
//    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ToolView" owner:self options:nil];
//    _toolView = [array objectAtIndex:0];
//    _toolView.center = CGPointMake(160, 400);
//    _toolView.delegate = self;
//    [self.view addSubview:_toolView];
    
//    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _category];
//    
//    _imagePathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
//    kImages = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < [_imagePathArray count]; i++) {
//        NSString *path = [NSString stringWithFormat:@"%@/%@", [self currentPath], [_imagePathArray objectAtIndex:i]];
//        UIImageView *subview = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
//        [subview setContentMode:UIViewContentModeScaleAspectFit];
//        //        subview.tag = i + 1;
//        
//        UIImage *img = [UIImage imageWithContentsOfFile:path];
//        NSLog(@"Ori:%d", img.imageOrientation);
//        
//        
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:subview, @"imageView", path, @"path", nil];
//        
//        NSLog(@"Path:%@", [dic valueForKey:@"path"]);
//        [kImages addObject:dic];
//        [self.scrollView addSubview:[[kImages objectAtIndex:i] valueForKey:@"imageView"]];
//        [subview release];
//    }

}


- (void)viewWillAppear:(BOOL)animated {
	DEBUG_LOG_VALUE(animated, %d);
    
    [self.navigationItem setTitle:_category];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
	self.view.frame = self.view.superview.bounds;
	self.currentPage = 0;
	
	viewControllers_ = [[NSMutableArray alloc] init];
	for (int i=0; i<[imageNames_ count]; i++) {
		[viewControllers_ addObject:[NSNull null]];
	}
	
	scrollView_ = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	scrollView_.contentSize = CGSizeMake(self.view.bounds.size.width * [viewControllers_ count], self.view.bounds.size.height);
    scrollView_.showsHorizontalScrollIndicator = YES;
    scrollView_.showsVerticalScrollIndicator = YES;
    scrollView_.scrollsToTop = NO;
    scrollView_.delegate = self;
	scrollView_.pagingEnabled = YES;	
	scrollView_.autoresizesSubviews = YES;
	scrollView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//	scrollView_.backgroundColor = [UIColor blackColor];
	[self loadScrollViewWithPage:self.page-1];
	[self loadScrollViewWithPage:self.page];
	[self loadScrollViewWithPage:self.page+1];
	
	[self.scrollView setContentOffset:CGPointMake(self.page*self.scrollView.frame.size.width, 0) animated:NO];
	[self.view addSubview:scrollView_];
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ToolView" owner:self options:nil];
    _toolView = [array objectAtIndex:0];
    _toolView.center = CGPointMake(160, 400);
    _toolView.delegate = self;
    [self.view addSubview:_toolView];
}

- (void)viewDidAppear:(BOOL)animated {
	DEBUG_LOG_VALUE(animated, %d);
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	DEBUG_LOG_NULL;
	return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	DEBUG_LOG_VALUE(self.view.superview, %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.view.superview.frame), %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.view.superview.bounds), %@);
	DEBUG_LOG_VALUE(NSStringFromCGPoint(self.view.superview.center), %@);
	
	DEBUG_LOG_VALUE(self.view, %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.view.frame), %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.view.bounds), %@);
	DEBUG_LOG_VALUE(NSStringFromCGPoint(self.view.center), %@);
	
	DEBUG_LOG_VALUE(self.scrollView, %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.scrollView.frame), %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.scrollView.bounds), %@);
	DEBUG_LOG_VALUE(NSStringFromCGPoint(self.scrollView.center), %@);
	DEBUG_LOG_VALUE(NSStringFromCGSize(self.scrollView.contentSize), %@);
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [_category release];
    [super dealloc];
}

- (void)hideNavbar {
    BOOL isHide = self.navigationController.navigationBarHidden;
//    BOOL isTabbarHide = self.tabBarController.tabBar.hidden;
    [self.navigationController setNavigationBarHidden:!isHide animated:YES];
    _toolView.hidden = !_toolView.hidden;
//    self.tabBarController.tabBar.hidden = !isTabbarHide;
    if (isEditing == YES) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:.3f];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        CGPoint point = _toolView.center;
        point.y += 250;
        _toolView.center = point;
        [UIView commitAnimations];
        [_toolView.textView resignFirstResponder];
        isEditing = NO;
    }
}

//把第page页的视图添加到self.scrollView的合适位置。
- (void)loadScrollViewWithPage:(int)page
{
	//DEBUG_LOG_VALUE(page, %d);
    if (page < 0)
        return;
    if (page >= [viewControllers_ count])
        return;

    // replace the placeholder if necessary
    ImageOperController *controller = [viewControllers_ objectAtIndex:page];
	
    if ((NSNull *)controller == [NSNull null])
    {
		NSString *imageName = [imageNames_ objectAtIndex:page];		
		CGRect frame = scrollView_.frame;
		frame.origin.x = frame.size.width * page;
		frame.origin.y = 0;
		
        controller = [[ImageOperController alloc] initWithImageName:imageName frame:frame];
		[viewControllers_ replaceObjectAtIndex:page withObject:controller];
		[controller release];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    { 
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNavbar)];
        [controller.view addGestureRecognizer:tap];
        [tap release];
        [scrollView_ addSubview:controller.view];
    }
	
	[controller setInitialStatus];
    if (!kControllers) {
        kControllers = [[NSMutableArray alloc] init];
    }
    [kControllers addObject:controller];
}


//UIScrollViewDelegate
// any offset changes
// 只要scrollview的bounds变化了，就会产生该动作。
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	//DEBUG_LOG_VALUE(scrollView, %@); 
	DEBUG_LOG_VALUE(NSStringFromCGRect(scrollView.bounds), %@); 
	
	//当前页
	CGFloat pageWidth = scrollView.frame.size.width;
//	int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    int page = [self currentPage];
	[self loadScrollViewWithPage:page - 1];
	[self loadScrollViewWithPage:page];
	[self loadScrollViewWithPage:page + 1];
	
	self.currentPage = page;
}


// called on start of dragging (may require some time and or distance to move)\
//拖拉动作都是从这个事件开始的。（不一定细微的拖拉会形成拖拉事件，可能需要点事件或者拖拉距离才会产生该事件），随后一般会产生大量的scrollViewDidScroll事件
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	DEBUG_LOG_NULL;
}

// called on finger up if user dragged. decelerate is true if it will continue moving afterwards
// 拖拉动作结束，产生该事件。根据拖拉的行为（是否是擦抹手势），决定是否继续使用减速动作。
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	DEBUG_LOG_NULL;
}

// called on finger up as we are moving
//开始减速动作
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
	DEBUG_LOG_NULL;
}

// called when scroll view grinds to a halt
//结束减速动作
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	DEBUG_LOG_NULL;
}


/* 放大缩小代理方法 */
// any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
	DEBUG_LOG_NULL;
}


// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	DEBUG_LOG_NULL;
}

// return a view that will be scaled. if delegate returns nil, nothing happens
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	DEBUG_LOG_NULL;
	return nil;
}

// called before the scroll view begins zooming its content
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view  {
	DEBUG_LOG_NULL;
}

// scale between minimum and maximum. called after any 'bounce' animations
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	DEBUG_LOG_NULL;
}


// return a yes if you want to scroll to the top. if not defined, assumes YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
	return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	DEBUG_LOG_NULL;
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		self.browser.isCurrentPortrait = YES;
	} else {
		self.browser.isCurrentPortrait = NO;
	}
	
	//当前的页面controller的准备工作。(大小，位置还原，pan手势控制权处理)
	[[viewControllers_ objectAtIndex:currentPage_] willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	//[[viewControllers_ objectAtIndex:currentPage_] didReceiveMemoryWarning];

	
	//这个时候还不知道旋转之后实际的contentsize大小。所以临时放大contentsize的宽度。防止scrollview自动调用setContentOffset。
	//系统旋的转方法中，scrollview会根据contentsize自动调整内容。所以要保持旋转后的scrollview的bounds不要超出这个contentsize
	//下面是具体的方法调用栈的一部分：
	// ...
	// -[BVScrollPageController scrollViewDidScroll:] + 277
	// -[UIScrollView setContentOffset:] + 521
	// -[UIScrollView(Static) _adjustContentOffsetIfNecessary] + 2841
	// -[UIScrollView setFrame:] + 525
	//...
	scrollView_.contentSize = CGSizeMake(scrollView_.contentSize.width+[viewControllers_ count]*480, scrollView_.contentSize.height);
	

	//设置旋转后的scrollview的显示内容。
	//设置scrollview的bounds的起点到正确位置。（旋转之后的大小形状已经改变，bounds的起点位置不会自动改变）
	//简单起见，只支持横竖屏的情况下。scrollview的bounds宽度智能是320或者是480的情况。其他大小程序将不能正常工作。
	CGRect bounds = scrollView_.bounds;
	float width =  self.browser.isCurrentPortrait ? 320 : 480;
	bounds.origin.x = width * currentPage_;
	scrollView_.bounds = bounds;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	DEBUG_LOG_NULL;
	//设置新的初始值
	[[viewControllers_ objectAtIndex:currentPage_] didRotateFromInterfaceOrientation:fromInterfaceOrientation];

	//设置新的contentsize
	scrollView_.contentSize = CGSizeMake(self.view.bounds.size.width * [viewControllers_ count], self.view.bounds.size.height);
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
- (NSInteger)currentPage {
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
    
    
    [picker addAttachmentData:UIImagePNGRepresentation([self currentImage]) mimeType:@"png" fileName:@"SharePicture"];
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
    [_toolView.textView resignFirstResponder];
    [self sendMail:nil];
}

- (void)deletePicture {
    if ([imageNames_ count] == 0) {
        return;
    }
    //    NSString *str = [NSString stringWithFormat:@"%@/%d.png", [self currentPath], [self currentPage]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除图片" message:@"确认要删除这张图片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
    
}

- (void)beginEditing {
    isEditing = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    CGPoint point = _toolView.center;
    point.y -= 250;
    _toolView.center = point;
    [UIView commitAnimations];
}

//- (void)endEditingWithString:(NSString *)string {
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:.3f];
//    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
//    CGPoint point = _toolView.center;
//    point.y += 250;
//    _toolView.center = point;
//    [UIView commitAnimations];
//}

#pragma mark - Alert Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationDuration:.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        
        NSString *str = [imageNames_ objectAtIndex:[self currentPage]];
        NSLog(@"PATH:%@", str);
        
        [[NSFileManager defaultManager] removeItemAtPath:str error:nil];
        
//        ImageOperController *controller = [viewControllers_ objectAtIndex:[self currentPage]];
//        
//        [controller.view removeFromSuperview];
        
        /*
        
        //如果不是最后一张图片
        if ([viewControllers_ count] != ([self currentPage] + 1)) {
            for (int i = [self currentPage] + 1; i < [viewControllers_ count]; i++) {
//                UIImageView *imgV = [[kImages objectAtIndex:i] valueForKey:@"imageView"];
                ImageOperController *imgC = [viewControllers_ objectAtIndex:i];
                CGRect rect = imgC.imageView.frame;
                rect.origin.x -= 320;
                imgC.imageView.frame = rect;
            }
            
            CGSize size = self.scrollView.contentSize;
            size.width -= 320;
            self.scrollView.contentSize = size;
        }
        //如果只有一张图片
        else if ([viewControllers_ count] == 1) {
            CGSize size = CGSizeMake(320, 480);
            self.scrollView.contentSize = size;
        }
        //如果是排在最后的一张图片
        else {
            CGSize size = self.scrollView.contentSize;
            size.width -= 320;
            [self.scrollView scrollRectToVisible:CGRectMake(size.width, 0, 320, 480) animated:YES];
            self.scrollView.contentSize = size;
        }
        
         */
        //当前页
        CGFloat pageWidth = scrollView_.frame.size.width;
        int page = floor((scrollView_.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        CGSize size = self.scrollView.contentSize;
        size.width -= 320;
        self.scrollView.contentSize = size;
        
        [[[viewControllers_ objectAtIndex:page] view] removeFromSuperview];
//        [kImages removeObjectAtIndex:page];
        [viewControllers_ removeObjectAtIndex:page];
        [imageNames_ removeObjectAtIndex:page];
//        if (page == 0) {
//            [self loadScrollViewWithPage:page];
//            [self loadScrollViewWithPage:page + 1];
//        }
//        else if (page == [viewControllers_ count]) {
//            [self loadScrollViewWithPage:page - 1];
//            [self loadScrollViewWithPage:page];
//
//        }
//        else {
//            [self loadScrollViewWithPage:page - 1];
//            [self loadScrollViewWithPage:page];
//            [self loadScrollViewWithPage:page + 1];
//        }
        NSLog(@"Page:%d, VC:%d", [self currentPage], [viewControllers_ count]);
        if ([viewControllers_ count] != 0) {
            [viewControllers_ removeAllObjects];
        }
        for (int i=0; i<[imageNames_ count]; i++) {
            [viewControllers_ addObject:[NSNull null]];
        }
        [self loadScrollViewWithPage:[self currentPage]];
        [self.scrollView reloadInputViews];
        [UIView commitAnimations];
        
    }
}



@end
