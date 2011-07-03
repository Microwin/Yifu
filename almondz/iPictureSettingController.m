//
//  iPictureSettingController.m
//  almondz
//
//  Created by Wu Jianjun on 11-6-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "iPictureSettingController.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "DialogView.h"
#import "CategoryTableViewController.h"
#import "Hash.h"

@implementation iPictureSettingController

@synthesize selectedImage = _selectedImage;

static NSString *kCategory = nil;   //通知传过来的category

- (IBAction)launchImagerImporter:(id)sender {	
    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName:@"ELCAlbumPickerController" bundle:[NSBundle mainBundle]];  
    
	ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    
    [albumController setParent:elcPicker];
    
	[elcPicker setDelegate:self];
    
	[self presentModalViewController:elcPicker animated:YES];
    [elcPicker release];
    [albumController release];
}

- (IBAction)categorySetting:(id)sender {
    CategoryTableViewController *categoryTableViewController = [[CategoryTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:categoryTableViewController animated:YES];
    [categoryTableViewController release];
}

- (void)updateCategory:(NSNotification *)info{
    kCategory = [[info userInfo] valueForKey:@"category"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //注册为通知观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCategory:) name:@"CategoryTyped" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [_selectedImage release];
    [super dealloc];
}

#pragma mark ELCImagePickerControllerDelegate Methods
- (void)presentDialog {

    
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
	
	if (_selectedImage) {
        [_selectedImage removeAllObjects];
    }
    else
        _selectedImage = [[NSMutableArray alloc] init];
	
    for(NSDictionary *dict in info) {
        
		UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [_selectedImage addObject: image];
	}
    
    
    //弹出一个对话框输入选择的照片的分类或者文字说明
    NSLog(@"Pics:%d", [_selectedImage count]);
    if (kCategory) {
        NSLog(@"Category:%@", kCategory);
        [self storeSelectedImage:_selectedImage withCategory:kCategory];

    }


}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark storeFilefromselectedimage

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
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
        NSLog(@"OriSave:%d", image.imageOrientation);

        NSString *date = [NSString stringWithFormat:@"%@%d", [[NSDate date] description], i];
        NSString *name = [Hash md5:date];
        //        NSString *name = [NSString stringWithFormat:@"%d.png", sum];
        NSData *imgData = UIImagePNGRepresentation(image);
        [imgData writeToFile:[NSString stringWithFormat:@"%@/%@.png", path, name] atomically:YES];
        sum++;
    }
    kCategory = nil;
    
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //注册为通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCategory:) name:@"CategoryTyped" object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
