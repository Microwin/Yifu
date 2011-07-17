//
//  ImageImporterController.h
//  almondz
//
//  Created by 卞中杰 on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DialogView.h"
@interface ImageImporterController : UIImagePickerController <DialogViewDelegate, UIActionSheetDelegate> {
    DialogView *_dialogView;
    NSInteger _imageNumber;
    UIButton *_imageSelectedInfo;
    NSMutableArray *_selectedImages;
    NSOperationQueue *_saveQueue;
}
@property (nonatomic, retain) DialogView *dialogView;
@property (nonatomic, assign) NSInteger imageNumber;
@property (nonatomic, retain) NSMutableArray *selectedImages;
- (void)updateToolBarInfo;
@end
