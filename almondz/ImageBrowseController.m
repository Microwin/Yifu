//
//  VCCustomTableViewViewController.m
//  Study
//
//  Created by hjlin on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageBrowseController.h"
#import "ImageScrollPageController.h"
#import "GenerateThumbnailOperation.h"
@implementation ImageBrowseController

@synthesize imageNames = imageNames_;
@synthesize isCurrentPortrait = isCurrentPortrait_;
@synthesize category = _category;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/

- (id)initWithImageNames:(NSMutableArray *)imageNames {
	if ((self = [super init])) {
        _dealImageQueue = [[NSOperationQueue alloc] init];
	}
	self.imageNames  = imageNames;
//    imageNames_ = [[NSMutableArray alloc] init];
	self.isCurrentPortrait = YES;
	return self;
}

- (id)init {
    if ((self = [super init])) {

    }
    return self;
}

- (void)launchImageImporter {
    ImageImporterController *importer = [[ImageImporterController alloc] init];
    importer.delegate = self;
    importer.dialogView.textField.text = _category;
    importer.dialogView.textField.userInteractionEnabled = NO;
    
    [self presentModalViewController:importer animated:YES];
    [importer release];
    
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(ImageImporterController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info valueForKey:UIImagePickerControllerOriginalImage];
    [picker.selectedImages addObject:img];
    [picker updateToolBarInfo];
    
}

- (void)imagePickerControllerDidCancel:(ImageImporterController *)picker {

    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.title = @"图片浏览";

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(launchImageImporter)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
	self.tableView.separatorColor = [UIColor whiteColor];
    
}


- (void)refreshImages {
    if (imageNames_) {
        imageNames_ = nil;
        [imageNames_ release];
    }
    if (imageNames_ && [imageNames_ count] != 0) {
        [imageNames_ removeAllObjects];
    }
    
    imageNames_ = [[NSMutableArray alloc] init];
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _category] error:nil];
    for (NSString *path in array) {
        if ([path isEqualToString:@"Details.plist"]) {
            continue;
        }
        if ([path rangeOfString:@".thumbnail"].length > 0) {
            continue;
        }
        NSString *pathf = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), _category, path];
        [imageNames_ addObject:pathf];
        NSLog(@"path:%@\n", pathf);
    }
    DEBUG_LOG_NULL;
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self performSelectorInBackground:@selector(refreshImages) withObject:nil];
//    if (imageNames_) {
//        imageNames_ = nil;
//        [imageNames_ release];
//    }
//    if (imageNames_ && [imageNames_ count] != 0) {
//        [imageNames_ removeAllObjects];
//    }
//
//    imageNames_ = [[NSMutableArray alloc] init];
//    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _category] error:nil];
//    for (NSString *path in array) {
//        NSString *pathf = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), _category, path];
//        [imageNames_ addObject:pathf];
//    }
//    NSLog(@"COUNT!!!!!:%d", [imageNames_ count]);
//    DEBUG_LOG_NULL;
//	[self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	DEBUG_LOG_NULL;
	return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	DEBUG_LOG_NULL;

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	DEBUG_LOG_NULL;
	int itemsNumPerRow = self.isCurrentPortrait ? 4 : 6;

    return [imageNames_ count] / itemsNumPerRow + 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *cellIndentifier = [NSString stringWithFormat:@"%d", indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
		DEBUG_LOG_NULL;
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}

    // Configure the cell...
	int i;
	int itemsNumPerRow = self.isCurrentPortrait ? 4 : 6;
	
	if (1/*itemsNumPerRow != cell.subviews.count*/) {
		DEBUG_LOG_VALUE(indexPath, %@);

        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
        for (i=0; i<itemsNumPerRow; i++) {
            if (indexPath.row*itemsNumPerRow+i >= [imageNames_ count]) break;
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80*i, 0, 80, 80)];
            
            NSString *imagePath = [imageNames_ objectAtIndex:indexPath.row*itemsNumPerRow+i];
            //DEBUG_LOG_VALUE(imagePath, %@);
//            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            
            NSString *thumbnailPath = [NSString stringWithFormat:@"%@.thumbnail", imagePath];
            UIImage *thumbnailImage = [UIImage imageWithContentsOfFile:thumbnailPath];

            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            if (thumbnailImage) {
                imageView.image = thumbnailImage;
            }
            else {
                GenerateThumbnailOperation *generate = [[[GenerateThumbnailOperation alloc] initWithImagePath:imagePath thumbnailPath:thumbnailPath] autorelease];
                generate.parent = self.tableView;
                [_dealImageQueue addOperation:generate];
            }
//            imageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, 80, 80))];
//            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleAspectFit;

            
            [button addSubview:imageView];
            button.tag = indexPath.row*itemsNumPerRow+i;
            
            [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
        }
    }
	
    return cell;
}

- (void)didClickButton:(id)sender {
	DEBUG_LOG(@"tag = %d", [sender tag]);
	
	ImageScrollPageController *scrollController = [[ImageScrollPageController alloc] initWithImageNames:self.imageNames page:[sender  tag]];
	scrollController.browser = self;
    scrollController.category = _category;
//	[[[[UIApplication sharedApplication] delegate] navigationController] pushViewController:scrollController animated:YES];
    [self.navigationController pushViewController:scrollController animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [_category release];
    [_dealImageQueue release];
    [super dealloc];
}



- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		self.isCurrentPortrait = YES;
	} else {
		self.isCurrentPortrait = NO;
	}
	[self.tableView reloadData];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	DEBUG_LOG_NULL;
}


//- (void)viewWillAppear:(BOOL)animated {
//	DEBUG_LOG_NULL;
//	[self.tableView reloadData];
//}

- (void)viewDidAppear:(BOOL)animated {
	DEBUG_LOG_NULL;

}


@end

