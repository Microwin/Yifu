//
//  ELCImagePickerController.m
//  ELCImagePickerDemo
//
//  Created by Collin Ruffenach on 9/9/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import "ELCImagePickerController.h"
#import "ELCAsset.h"
#import "ELCAssetCell.h"
#import "ELCAssetTablePicker.h"
#import "ELCAlbumPickerController.h"

@implementation ELCImagePickerController

@synthesize delegate;

-(void)cancelImagePicker {

	if([delegate respondsToSelector:@selector(elcImagePickerControllerDidCancel:)]) {
		[delegate performSelector:@selector(elcImagePickerControllerDidCancel:) withObject:self];
	}
}

-(void)selectedAssets:(NSArray*)_assets {

	NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
	
	for(ALAsset *asset in _assets) {
		NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
		[workingDictionary setObject:[asset valueForProperty:ALAssetPropertyType] forKey:@"UIImagePickerControllerMediaType"];
        
        //这里原本是fullScreenImage
		[workingDictionary setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:1.0 orientation:[[asset valueForProperty:@"ALAssetPropertyOrientation"] intValue]] forKey:@"UIImagePickerControllerOriginalImage"];
        
        
        
//        [workingDictionary setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:UIImageOrientationUp] forKey:@"UIImagePickerControllerOriginalImage"];
//        UIImage *tI = [workingDictionary objectForKey:@"UIImagePickerControllerOriginalImage"];
//        NSData *tD = UIImagePNGRepresentation(tI);
//        [tD writeToFile:[NSString stringWithFormat:@"%@/Documents/test.png", NSHomeDirectory()] atomically:YES];
        
        
        
        
        
		[workingDictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:@"UIImagePickerControllerReferenceURL"];
		
		[returnArray addObject:workingDictionary];
		
		[workingDictionary release];	
	}
	    
	if([delegate respondsToSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:)]) {
		[delegate performSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:) withObject:self withObject:[NSArray arrayWithArray:returnArray]];
	}
    [self popViewControllerAnimated: YES];
//    [self popToRootViewControllerAnimated:NO];
//    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {    
    NSLog(@"ELC Image Picker received memory warning!!!");
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    NSLog(@"deallocing ELCImagePickerController");
    [super dealloc];
}

@end
