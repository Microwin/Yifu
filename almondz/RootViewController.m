//
//  RootViewController.m
//  almondz
//
//  Created by Wu Jianjun on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "RootCell.h"
#import "CategoryTableViewController.h"
#import "Hash.h"
#import "ImageImporterController.h"

@implementation RootViewController
@synthesize tableView;
@synthesize selectedImage = _selectedImage;
static NSString *kCategory = nil;

#pragma mark storeFilefromselectedimage

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [tableView release];
    [_selectedImage release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


//显示分类设置控制器
- (IBAction)mangeButtonPressed:(id)sender {
    CategoryTableViewController *categoryTableViewController = [[CategoryTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:categoryTableViewController animated:YES];
    [categoryTableViewController release];
}

- (void)updateCategory:(NSNotification *)info{
    kCategory = [[info userInfo] valueForKey:@"category"];
}



//打开UIImagePickerController
- (IBAction)inputButtonPressed:(id)sender {	
    ImageImporterController *pickerController = [[ImageImporterController alloc] initWithCamera:NO];
    //kPicker = pickerController;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    pickerController.isUsingCamera = NO;
    [self presentModalViewController:pickerController animated:YES];
    [pickerController release];
}

- (IBAction)photoButtonPressed:(id)sender {
    //    ImageImporterController *cameraController = [[ImageImporterController alloc] init];
    //    cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    cameraController.delegate = self;
    //    [self presentModalViewController:cameraController animated:YES];
    //    [cameraController release];
    if ([ImageImporterController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ImageImporterController *picker = [[ImageImporterController alloc] initWithCamera:YES];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.isUsingCamera = YES;
        [self presentModalViewController:picker animated:YES];
        [picker release];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的设备不支持照相机" message:nil delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(ImageImporterController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker.selectedImages addObject:img];
    
    
    if (!picker.isUsingCamera) {
        [picker updateToolBarInfo];
    }
    else {
        [picker showDialogView];
    }
    
}

- (void)imagePickerControllerDidCancel:(ImageImporterController *)picker {
    //    kPicker = nil;
    //    if (_selectedImage && [_selectedImage count]) {
    //        [_selectedImage removeAllObjects];
    //    }
    [picker dismissModalViewControllerAnimated:YES];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RootCell *cell = (RootCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"RootCell" owner:self options:nil];
        cell = [array objectAtIndex:0];

    }
    
    return cell;
}



@end
