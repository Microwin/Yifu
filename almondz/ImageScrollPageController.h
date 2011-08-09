//
//  BVScrollPageController.h
//  Study
//
//  Created by hjlin on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolView.h"
#import <MessageUI/MFMailComposeViewController.h>

@class ImageBrowseController;

@interface ImageScrollPageController : UIViewController<UIScrollViewDelegate, ToolViewDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate> {
	
	NSMutableArray *imageNames_;    //图片完整路径和名字
	NSInteger page_;

	NSMutableArray *viewControllers_;  //array of pages
	UIScrollView *scrollView_;
	NSInteger currentPage_;
	
	ImageBrowseController *browser_;
    
    ToolView *_toolView;
    
    NSString *_category;    //分类
    
    NSArray *_imagePathArray;
    
    NSMutableArray *_detailArray;  //图片的详细信息
    BOOL isEditing;
    
    NSMutableArray *_theNamesArray; //纯图片名
    
    NSOperationQueue *_generateImageQueue;
}

@property (nonatomic, retain) NSMutableArray *imageNames;

@property (nonatomic, retain) NSString *category;
@property (nonatomic, copy) NSMutableArray *viewControllers;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) 	ImageBrowseController *browser;


- (id)initWithImageNames:(NSMutableArray *)imageNames page:(int)page;
- (void)loadScrollViewWithPage:(int)page;
- (NSString *)currentPath;

@end
