//
//  iPictureSettingController.h
//  almondz
//
//  Created by Wu Jianjun on 11-6-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"

@interface iPictureSettingController : UIViewController <ELCImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSMutableArray *_selectedImage;
}

@property (nonatomic, retain) NSMutableArray *selectedImage;


-(void)storeSelectedImage:(NSArray *)imageArray withCategory: (NSString *)category;
- (IBAction)launchImagerImporter:(id)sender;
- (IBAction)categorySetting:(id)sender;
@end