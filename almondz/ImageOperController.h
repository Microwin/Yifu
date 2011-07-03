//
//  TestViewController.h
//  Test
//
//  Created by hjlin on 9/20/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageOperController : UIViewController  {
	UIImageView *imageView_;  
	NSString *imageName_;           
	CGRect imageFrame_;      
	
	CGFloat currentScale_;     //当前view的缩放比例
	CGRect currentFrame_;      //当前view的frame
	
	CGRect initialFrame_;       //view初始化的frame
	CGPoint initialTopLeftPoint_;  //view初始化的坐上角点坐标
	CGPoint initialBottomRightPoint_; //view初始化的右下角点坐标
	
	UIPinchGestureRecognizer *pinchGesture_;
	UIPanGestureRecognizer *panGesture_;
	UITapGestureRecognizer *tapGestrue_;
    
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, retain) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, retain) UIPanGestureRecognizer *panGesture;
@property (nonatomic, retain) UITapGestureRecognizer *tapGestrue;


//添加手势识别动作到 self.view
- (void)createGestureRecognizers;

//初始化属性值
- (void)setInitialStatus;

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender;
- (void)handlePanGesture:(UIPanGestureRecognizer *)sender;
- (void)handleSingleDoubleTap:(UITapGestureRecognizer *)sender;

// The designated initializer
- (id)initWithImageName:(NSString *)imageName frame:(CGRect)frame; 

//自动禁止、启用拖拉手势。scale大于1启用，否则禁用。
- (void)autoJudgePanGesture;

@end

