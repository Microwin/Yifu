//
//  ToolView.m
//  almondz
//
//  Created by 卞中杰 on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ToolView.h"
#import <QuartzCore/QuartzCore.h>


@implementation ToolView

@synthesize delegate;
@synthesize topButton = _topButton;
@synthesize textView = _textView;
@synthesize bottomView = _bottomView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor lightGrayColor];
//        self.alpha = .3f;
//        _baseView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 200, 70)];
//        _baseView.backgroundColor = [UIColor darkGrayColor];
//        _baseView.alpha = .5f;
//        [self addSubview:_baseView];
//        
//        UIButton *deleteBtn = [UIButton alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)awakeFromNib {
    _topButton.layer.cornerRadius = 5;
    _textView.layer.cornerRadius = 5;
    _textView.alpha = 0.f;
    _bottomView.layer.cornerRadius = 5;
    _topButton.center = CGPointMake(110, 103);
}

- (void)dealloc
{
    [_topButton release];
    [_textView release];
    [_bottomView release];
    [super dealloc];
}


- (IBAction)topButtonPressed:(id)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
    if (_textView.alpha == 0.f) {
        _topButton.center = CGPointMake(110, 10);
        _textView.alpha = 0.7f;
    }
    else {
        _topButton.center = CGPointMake(110, 103);
        _textView.alpha = 0.f;
    }
    [UIView commitAnimations];
}
@end
