//
//  ImageImporterController.m
//  almondz
//
//  Created by 卞中杰 on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageImporterController.h"
#import "Hash.h"

@implementation ImageImporterController
@synthesize dialogView = _dialogView;
@synthesize imageNumber = _imageNumber;
@synthesize selectedImages = _selectedImages;
//显示导入对话框
- (void)showDialogView {
//    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DialogView" owner:self options:nil];
//    _dialogView = [array objectAtIndex:0];
//    CGPoint point = CGPointMake(160, 200);
//    _dialogView.center = point;
//    [self.view addSubview:_dialogView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.5f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_dialogView cache:YES];
    _dialogView.alpha = 1.f;
    [UIView commitAnimations];
}

- (id)init {
    if ((self = [super init])) {
        _selectedImages = [[NSMutableArray alloc] init];
        
        UIToolbar *toolBar = [[UIToolbar alloc] init];
        toolBar.barStyle = UIBarStyleBlackTranslucent;
        toolBar.frame = CGRectMake(0, 436, 320, 44);
        [self.view addSubview:toolBar];
        UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"导入" style:UIBarButtonItemStyleDone target:self action:@selector(showDialogView)];
        
        _imageNumber = 0;

        
        NSString *info = [NSString stringWithFormat:@"您选择了%d张照片", _imageNumber];
        _imageSelectedInfo = [[UIButton alloc] initWithFrame:CGRectMake(12, 7, 149, 31)];
        [_imageSelectedInfo setTitle:info forState:UIControlStateNormal];
        _imageSelectedInfo.userInteractionEnabled = NO;
        UIBarButtonItem *imageInfo = [[UIBarButtonItem alloc] initWithCustomView:_imageSelectedInfo];

        
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [toolBar setItems:[NSArray arrayWithObjects:imageInfo, flex, okButton, nil] animated:YES];
        [toolBar release];
        
        [flex release];
        [imageInfo release];
        [okButton release];
        
        //DialogView
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DialogView" owner:self options:nil];
        _dialogView = [array objectAtIndex:0];
        _dialogView.delegate = self;
        _dialogView.alpha = 0.f;
        CGPoint point = CGPointMake(160, 200);
        _dialogView.center = point;
        [self.view addSubview:_dialogView];
//        [_dialogView release];

    }
    return self;
}

- (void)updateToolBarInfo {
    NSString *info = [NSString stringWithFormat:@"您选择了%d张照片", [_selectedImages count]];
    [_imageSelectedInfo setTitle:info forState:UIControlStateNormal];
}



- (void)dealloc {
    [_selectedImages release];
    [super dealloc];
}



#pragma mark - DialogView Delegate

- (void)importImageswithCategory:(NSString *)categoryName {
    if ([categoryName isEqualToString:@""]) {
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), categoryName];
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    int sum = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil] count];
    
    for (int i = 0; i < [_selectedImages count]; i++) {
        UIImage *image = [_selectedImages objectAtIndex:i];
        NSString *date = [NSString stringWithFormat:@"%@%d", [[NSDate date] description], i];
        NSString *name = [Hash md5:date];
        NSData *imgData = UIImagePNGRepresentation(image);
        [imgData writeToFile:[NSString stringWithFormat:@"%@/%@.png", path, name] atomically:YES];
        sum++;
    }
}


@end
