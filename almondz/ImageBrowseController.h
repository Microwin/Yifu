//
//  VCCustomTableViewViewController.h
//  Study
//
//  Created by hjlin on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageImporterController.h"

@interface ImageBrowseController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

	NSMutableArray *imageNames_;
	BOOL isCurrentPortrait_;
    NSString *_category;
    
    NSOperationQueue *_dealImageQueue;
}

@property (nonatomic, retain) NSMutableArray *imageNames;
@property (nonatomic, assign) BOOL isCurrentPortrait;
@property (nonatomic, retain) NSString *category;

- (id)initWithImageNames:(NSMutableArray *)imageNames;

@end
