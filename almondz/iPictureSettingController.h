//
//  iPictureSettingController.h
//  almondz
//
//  Created by Wu Jianjun on 11-6-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
//#import "ELCImagePickerController.h"

enum ImporterType {
    ImporterTypeNone,
    ImporterTypeLibrary,
    ImporterTypeCamera,
};

@interface iPictureSettingController : UIViewController </*ELCImagePickerControllerDelegate,*/ UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    NSMutableArray *_selectedImage;
    
    @private
    enum ImporterType imprterType;
}

@property (nonatomic, retain) NSMutableArray *selectedImage;


//-(void)storeSelectedImage:(NSArray *)imageArray withCategory: (NSString *)category;
- (IBAction)launchImagerImporter:(id)sender;
- (IBAction)categorySetting:(id)sender;
- (IBAction)launchCameraImporter:(id)sender;
@end