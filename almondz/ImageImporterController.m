//
//  ImageImporterController.m
//  almondz
//
//  Created by 卞中杰 on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageImporterController.h"
#import "Hash.h"
#import "DialogView.h"

@implementation ImageImporterController
@synthesize dialogView = _dialogView;


//显示导入对话框
- (void)showDialogView {
//    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DialogView" owner:self options:nil];
//    _dialogView = [array objectAtIndex:0];
//    CGPoint point = CGPointMake(160, 200);
//    _dialogView.center = point;
//    [self.view addSubview:_dialogView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_dialogView cache:YES];
    _dialogView.alpha = 1.f;
    [UIView commitAnimations];
}

- (id)init {
    if ((self = [super init])) {
        UIToolbar *toolBar = [[UIToolbar alloc] init];
        toolBar.barStyle = UIBarStyleBlackTranslucent;
        toolBar.frame = CGRectMake(0, 436, 320, 44);
        [self.view addSubview:toolBar];
        UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"导入" style:UIBarButtonItemStyleDone target:self action:@selector(showDialogView)];
        [toolBar setItems:[NSArray arrayWithObject:okButton] animated:YES];
        [toolBar release];
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DialogView" owner:self options:nil];
        _dialogView = [array objectAtIndex:0];
        _dialogView.alpha = 0.f;
        CGPoint point = CGPointMake(160, 200);
        _dialogView.center = point;
        [self.view addSubview:_dialogView];

    }
    return self;
}

-(void)storeSelectedImage:(NSArray *)imageArray withCategory: (NSString *)category {
    if ([category isEqualToString:@""]) {
        return;
    }
    NSLog(@"CAT:%@", category);
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), category];
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    int sum = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil] count];
    
    
    //    for (UIImage *image in imageArray) {
    //        NSString *date = [[NSDate date] description];
    //        NSString *name = [Hash md5:date];
    ////        NSString *name = [NSString stringWithFormat:@"%d.png", sum];
    //        NSData *imgData = UIImagePNGRepresentation(image);
    //        [imgData writeToFile:[NSString stringWithFormat:@"%@/%@.png", path, name] atomically:YES];
    //        sum++;
    //    }
    for (int i = 0; i < [imageArray count]; i++) {
        UIImage *image = [imageArray objectAtIndex:i];
        NSString *date = [NSString stringWithFormat:@"%@%d", [[NSDate date] description], i];
        NSString *name = [Hash md5:date];
        NSData *imgData = UIImagePNGRepresentation(image);
        [imgData writeToFile:[NSString stringWithFormat:@"%@/%@.png", path, name] atomically:YES];
        sum++;
    }

}

- (void)dealloc {
    [_dialogView release];
    [super dealloc];
}

#pragma mark - DialogView Delegate
- (void)importImageswithCategory:(NSString *)categoryName {
    
}
@end
