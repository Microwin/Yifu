//
//  TestViewController.m
//  Test
//
//  Created by hjlin on 9/20/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "ImageOperController.h"


@implementation ImageOperController

@synthesize imageView = imageView_;
@synthesize imageName = imageName_;
@synthesize imageFrame = imageFrame_;


@synthesize pinchGesture = pinchGesture_;
@synthesize panGesture = panGesture_;
@synthesize tapGestrue = tapGestrue_;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (id)initWithImageName:(NSString *)imageName frame:(CGRect)frame {
	self = [super init];
	if (self) {
		self.imageName = imageName;
		//you must set self.imageFrame first before you use self.view.frame or self.view.bounds
		self.imageFrame = frame;
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//这里一定要设置UIViewAutoresizingFlexibleLeftMargin，UIViewAutoresizingFlexibleRightMargin，否则旋转后的位置不对了。
	self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	self.view.backgroundColor = [UIColor blackColor];
	self.view.frame = self.imageFrame;

	UIImage *image = [[UIImage alloc] initWithContentsOfFile:self.imageName];
	imageView_  = [[UIImageView alloc] initWithFrame:self.view.bounds];
	imageView_.userInteractionEnabled = YES;
	imageView_.contentMode = UIViewContentModeScaleAspectFit;
	imageView_.image = image;
	imageView_.clipsToBounds = YES;	
	imageView_.autoresizesSubviews = YES;
	imageView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[self.view addSubview:imageView_];
	
	[self createGestureRecognizers];
	[self setInitialStatus];
    

}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	//DEBUG_LOG_NULL;
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	DEBUG_LOG_NULL;
	//将view的大小还原
	self.view.transform = CGAffineTransformMakeScale(1, 1);
	currentScale_ = 1;
	
	//位置还原。
	self.view.frame = initialFrame_;
	
	//自动决定pan手势的处理者（scale等于1的话就交给上层的scrollview，否则自己处理）
	[self autoJudgePanGesture];

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	DEBUG_LOG_NULL;
	[self setInitialStatus];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	//DEBUG_LOG_VALUE([[UIApplication sharedApplication] keyWindow], %@);
	
	DEBUG_LOG_VALUE(self.view.superview, %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.view.superview.frame), %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.view.superview.bounds), %@);
	DEBUG_LOG_VALUE(NSStringFromCGPoint(self.view.superview.center), %@);
	
	
	DEBUG_LOG_VALUE(self.view, %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.view.frame), %@);
	DEBUG_LOG_VALUE(NSStringFromCGRect(self.view.bounds), %@);
	DEBUG_LOG_VALUE(NSStringFromCGPoint(self.view.center), %@);
	

	//DEBUG_LOG_VALUE(self.imageView, %@);
	//DEBUG_LOG_VALUE(NSStringFromCGRect(self.imageView.frame), %@);
	//DEBUG_LOG_VALUE(NSStringFromCGRect(self.imageView.bounds), %@);
	//DEBUG_LOG_VALUE(NSStringFromCGPoint(self.imageView.center), %@);
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	DEBUG_LOG_NULL;
}

- (void)viewWillAppear:(BOOL)animated {
	DEBUG_LOG_NULL;
}

- (void)viewDidAppear:(BOOL)animated {
	DEBUG_LOG_NULL;
}

- (void)dealloc {
    [super dealloc];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	DEBUG_LOG_NULL;
//	DEBUG_LOG(@"touches = %@", [touches anyObject]);
//	DEBUG_LOG(@"event = %@", event);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	DEBUG_LOG_NULL;

//	DEBUG_LOG(@"touches = %@", [touches anyObject]);
//	DEBUG_LOG(@"event = %@", event);
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	DEBUG_LOG_NULL;

//	DEBUG_LOG(@"touches = %@", [touches anyObject]);
//	DEBUG_LOG(@"event = %@", event);
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	DEBUG_LOG_NULL;

//	DEBUG_LOG(@"touches = %@", [touches anyObject]);
//	DEBUG_LOG(@"event = %@", event);
}


- (void)createGestureRecognizers {
	//双击手势
    tapGestrue_ = [[UITapGestureRecognizer alloc]
					initWithTarget:self 
					action:@selector(handleSingleDoubleTap:)];
    tapGestrue_.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGestrue_];
	
	//拖拉手势
    panGesture_ = [[UIPanGestureRecognizer alloc]
				  initWithTarget:self
				  action:@selector(handlePanGesture:)];
    //[self.view addGestureRecognizer:panGesture_];
	
	//放大缩小手势
    pinchGesture_ = [[UIPinchGestureRecognizer alloc]
					  initWithTarget:self 
					  action:@selector(handlePinchGesture:)];
    [self.view addGestureRecognizer:pinchGesture_];
}



- (void)setInitialStatus {
	currentScale_ = 1;
	currentFrame_ = self.view.frame;
	initialFrame_ = self.view.frame;
	initialTopLeftPoint_     = self.view.frame.origin;
	initialBottomRightPoint_ = CGPointMake(initialTopLeftPoint_.x+self.view.frame.size.width, initialTopLeftPoint_.y+self.view.frame.size.height);
}


//捏合放大缩小手势
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender {
	DEBUG_LOG_NULL;
	static CGFloat maxScale = 2;
	static CGFloat minScale = 1;
    CGFloat factor = [sender scale];
	
	DEBUG_LOG_VALUE(sender.view, %@);
	//DEBUG_LOG_VALUE(factor, %f);
	
	if (sender.state == UIGestureRecognizerStateBegan) {
		//每次pinch手势开始的时候都会使用设置scale属性为_initialTouchScale（不可以访问）。
		//为了恢复上次的比例，需要再pinch手势开始的时候将scale属性设置为保存的比例。
		factor = currentScale_;		
		[sender setScale:factor];
		return;
	} else if (sender.state == UIGestureRecognizerStateEnded) {
		//保存数据
		currentScale_ = factor;
		currentFrame_ = self.view.frame;
		[self autoJudgePanGesture];
		return;
	}
	//最大缩放的scale
	if (factor >= maxScale) {
		factor = maxScale;
		[(UIPinchGestureRecognizer *)sender setScale:maxScale];
	} 
	//最小缩放的scale
	if (factor <= minScale) {
		factor = minScale;
		[(UIPinchGestureRecognizer *)sender setScale:minScale];
	} 
	
	self.view.transform = CGAffineTransformMakeScale(factor, factor);
	
	DEBUG_LOG_VALUE(sender.view, %@);

	//防止view偏离出原始frame。
	BOOL needBounceToEdge = NO;
	CGRect newFrame = self.view.frame;
	CGPoint topLeftPoint_     = self.view.frame.origin;
	CGPoint bottomRightPoint_ = CGPointMake(topLeftPoint_.x+self.view.frame.size.width, topLeftPoint_.y+self.view.frame.size.height);
	
	if (topLeftPoint_.x > initialTopLeftPoint_.x) {  
		DEBUG_LOG(@"left exceeds!");
		newFrame.origin.x = initialTopLeftPoint_.x;
		needBounceToEdge = YES;
	} 
	if (topLeftPoint_.y > initialTopLeftPoint_.y) {
		DEBUG_LOG(@"top exceeds!"); 
		newFrame.origin.y = initialTopLeftPoint_.y;
		needBounceToEdge = YES;
	} 
	if (bottomRightPoint_.x < initialBottomRightPoint_.x) {
		DEBUG_LOG(@"right exceeds!");
		newFrame.origin.x = initialBottomRightPoint_.x - newFrame.size.width;
		needBounceToEdge = YES;
	}
	if (bottomRightPoint_.y < initialBottomRightPoint_.y) {
		DEBUG_LOG(@"bottom exceeds!");
		newFrame.origin.y = initialBottomRightPoint_.y - newFrame.size.height;
		needBounceToEdge = YES;
	} 
	
	if (needBounceToEdge == YES) {
		sender.view.frame = newFrame;
	}
	return;
}


//拖拉移动手势
- (void)handlePanGesture:(UIPanGestureRecognizer *)sender {
	//DEBUG_LOG_VALUE(sender.view, %@);

	//保存的相对坐标。（在视图本地坐标系统中，把一次拖拉手势的起点坐标作为原点，相对于该原点的坐标）
	static CGPoint savedTranslate;	
	
	//拖拉手势开始，设置保存的相对坐标。
	if (sender.state == UIGestureRecognizerStateBegan)  {
		savedTranslate = CGPointMake(0, 0);
		return;
	}
	
	//缩放比例小于1的时候禁止拖拉
	if (currentScale_ <= 1) {
		return;
	}
	
	//pan手势开始的时候，根据触摸点保存了一个起点坐标（相对于screen坐标）
	//pan手势变化的时候，根据触摸点产生了一个当前坐标（相对于screen坐标）
	//通过translationInView方法，计算出当前坐标同起点坐标的相对坐标。（相对于view的本地坐标系统）
    CGPoint translate = [sender translationInView:self.view];
	DEBUG_LOG_VALUE(NSStringFromCGPoint(translate), %@);
	
	//当前的相对坐标和上次的相对坐标。就是这次事件触摸位置变化的差异。本地坐标系统通过transform转换为父视图的坐标系统。
    CGRect newFrame = currentFrame_;
    newFrame.origin.x += (translate.x - savedTranslate.x)*sender.view.transform.a;
    newFrame.origin.y += (translate.y - savedTranslate.y)*sender.view.transform.d;
	
	//保存当前的相对坐标。
	savedTranslate = translate;
	
	//设置新的frame，移动视图
	sender.view.frame = newFrame;
	
	//保存当前的frame
	currentFrame_ = newFrame;
	
	//防止view偏离出原始frame。
	if (sender.state == UIGestureRecognizerStateEnded) {
		BOOL needBounceToEdge = NO;
		CGPoint topLeftPoint_     = newFrame.origin;
		CGPoint bottomRightPoint_ = CGPointMake(topLeftPoint_.x+newFrame.size.width, topLeftPoint_.y+newFrame.size.height);
		
		if (topLeftPoint_.x > initialTopLeftPoint_.x) {  
			DEBUG_LOG(@"left exceeds!");
			newFrame.origin.x = initialTopLeftPoint_.x;
			needBounceToEdge = YES;
		} 
		if (topLeftPoint_.y > initialTopLeftPoint_.y) {
			DEBUG_LOG(@"top exceeds!"); 
			newFrame.origin.y = initialTopLeftPoint_.y;
			needBounceToEdge = YES;
		} 
		if (bottomRightPoint_.x < initialBottomRightPoint_.x) {
			DEBUG_LOG(@"right exceeds!");
			newFrame.origin.x = initialBottomRightPoint_.x - newFrame.size.width;
			needBounceToEdge = YES;
		}
		if (bottomRightPoint_.y < initialBottomRightPoint_.y) {
			DEBUG_LOG(@"bottom exceeds!");
			newFrame.origin.y = initialBottomRightPoint_.y - newFrame.size.height;
			needBounceToEdge = YES;
		} 
		
		if (needBounceToEdge) {
			DEBUG_LOG(@"bounce to edge");
			[UIView beginAnimations:nil context:NULL];
			sender.view.frame = newFrame;
			[UIView commitAnimations];
			//设置新的currentframe
			currentFrame_ = newFrame;
		}
	}
	return;
}


//双击放大缩小view。
//如果view的currentScale_为1就放大view到2。否则缩小view到1
- (void)handleSingleDoubleTap:(UITapGestureRecognizer *)sender {
	//DEBUG_LOG_VALUE(sender.view, %@);
	CGFloat factor = currentScale_ == 1 ? 2 : 1;

	[UIView beginAnimations:nil context:NULL];
	
	CGAffineTransform transform = CGAffineTransformMakeScale(factor, factor);
	self.view.transform = transform;

	//如果是缩小。防止view偏离出原始frame，需要重新设置view的frame。
	if (factor == 1) {
		self.view.frame = initialFrame_;
	}
		
	//DEBUG_LOG_VALUE(sender.view, %@);
	//设置新的当前frame，和当前scale
	currentFrame_ = self.view.frame;
	currentScale_ = factor;

	DEBUG_LOG_VALUE(NSStringFromCGRect(currentFrame_), %@);
	[UIView commitAnimations];
	
	[self autoJudgePanGesture];
}



- (void)autoJudgePanGesture {
	if (currentScale_ > 1) {
		DEBUG_LOG(@"add pan gesture");
		[self.view removeGestureRecognizer:panGesture_];
		[self.view addGestureRecognizer:panGesture_];
		[[self.view superview] setScrollEnabled:NO];
	} else {
		DEBUG_LOG(@"remove pan gesture");
		[self.view removeGestureRecognizer:panGesture_];
		[[self.view superview] setScrollEnabled:YES];
	}
}




@end



