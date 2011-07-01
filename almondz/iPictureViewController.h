//
//  iPictureViewController.h
//  almondw
//
//  Created by Wu Jianjun on 11-5-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ToolView.h"

@interface iPictureViewController : UIViewController <UIScrollViewDelegate ,MFMailComposeViewControllerDelegate, ToolViewDelegate, UIAlertViewDelegate> {
    UIScrollView *scrollView;
    NSArray *_plistData;
    NSString *_category;
    
    ToolView *_toolView;
//    NSArray *_nameArray;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *plistData;
@property (nonatomic, retain) NSString *category;

- (IBAction)hideNav:(id)sender;
@end
