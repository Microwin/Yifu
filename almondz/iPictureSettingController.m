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
#import "CategoryTableViewController.h"
#import "Hash.h"
#import "ImageImporterController.h"

@implementation iPictureSettingController

@synthesize selectedImage = _selectedImage;

static NSString *kCategory = nil;   //通知传过来的category
//static ImageImporterController *kPicker = nil;

//- (IBAction)launchImagerImporter:(id)sender {	
//    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName:@"ELCAlbumPickerController" bundle:[NSBundle mainBundle]];  
//    
//	ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
//    
//    [albumController setParent:elcPicker];
//    
//	[elcPicker setDelegate:self];
//    
//	[self presentModalViewController:elcPicker animated:YES];
//    [elcPicker release];
//    [albumController release];
//}

//显示导入对话框
//- (void)showDialogView {
//    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DialogView" owner:self options:nil];
//    DialogView *dialogView = [array objectAtIndex:0];
//    dialogView.delegate = self;
//    CGPoint point = CGPointMake(160, 200);
//    dialogView.center = point;
//    [kPicker.view addSubview:dialogView];
//}

//打开UIImagePickerController
- (IBAction)launchImagerImporter:(id)sender {	
    ImageImporterController *pickerController = [[ImageImporterController alloc] init];
    //kPicker = pickerController;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    [self presentModalViewController:pickerController animated:YES];
    [pickerController release];
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(ImageImporterController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"ORITATION:%d", [img imageOrientation]);
    [picker.selectedImages addObject:img];
    [picker updateToolBarInfo];
    
}

- (void)imagePickerControllerDidCancel:(ImageImporterController *)picker {
//    kPicker = nil;
//    if (_selectedImage && [_selectedImage count]) {
//        [_selectedImage removeAllObjects];
//    }
    [picker dismissModalViewControllerAnimated:YES];
}

//显示分类设置控制器
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

- (void)storeMethod {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [pool release];
}

/*
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
        [NSThread detachNewThreadSelector:@selector(storeMethod) toTarget:self withObject:nil];

    }


}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    
	[self dismissModalViewControllerAnimated:YES];
}
*/
#pragma mark storeFilefromselectedimage

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/*
-(void)storeSelectedImage:(NSArray *)imageArray withCategory: (NSString *)category {
    if ([category isEqualToString:@""]) {
        return;
    }

    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), category];
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    int sum = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil] count];
 
    for (int i = 0; i < [imageArray count]; i++) {
        UIImage *image = [imageArray objectAtIndex:i];
        NSString *date = [NSString stringWithFormat:@"%@%d", [[NSDate date] description], i];
        NSString *name = [Hash md5:date];
        NSData *imgData = UIImagePNGRepresentation(image);
        [imgData writeToFile:[NSString stringWithFormat:@"%@/%@.png", path, name] atomically:YES];
        sum++;
    }
    kCategory = nil;
}

#pragma mark - DialogView Delegate
- (void)importImageswithCategory:(NSString *)categoryName {
    [self storeSelectedImage:_selectedImage withCategory:categoryName];
}
*/

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
