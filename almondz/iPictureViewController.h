//
//  iPictureViewController.h
//  almondw
//
//  Created by Wu Jianjun on 11-5-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToolView;
@interface iPictureViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    NSArray *_plistData;
    NSString *_category;
    
    ToolView *_toolView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *plistData;
@property (nonatomic, retain) NSString *category;

- (IBAction)hideNav:(id)sender;
@end
