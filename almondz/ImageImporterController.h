//
//  ImageImporterController.h
//  almondz
//
//  Created by 卞中杰 on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DialogView;
@interface ImageImporterController : UIImagePickerController  {
    DialogView *_dialogView;
}
@property (nonatomic, retain) DialogView *dialogView;
@end
