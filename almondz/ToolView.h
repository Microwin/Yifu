//
//  ToolView.h
//  almondz
//
//  Created by 卞中杰 on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolViewDelegate <NSObject>
- (void)deletePicture;
- (void)sharePicture;
@end
@interface ToolView : UIView {
    id <ToolViewDelegate> delegate;
    UIButton *_topButton;
    UITextView *_textView;
    UIView *_bottomView;
}
@property (nonatomic, assign) id <ToolViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIButton *topButton;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIView *bottomView;

- (IBAction)topButtonPressed:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)shareButtonPressed:(id)sender;

@end
