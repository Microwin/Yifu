//
//  iPictureRootViewController.m
//  almondz
//
//  Created by Wu Jianjun on 11-6-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "iPictureRootViewController.h"
#import "iPictureViewController.h"
#import "iPictureSettingController.h"
#import "CategoryRootCell.h"
#import "ImageBrowseController.h"
@implementation iPictureRootViewController

@synthesize categoryArray = _categoryArray;
//@synthesize plistKey = _plistKey;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_categoryArray release];
//    [_plistKey release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) settingInput {
    
    iPictureSettingController *settingViewController = [[iPictureSettingController alloc] initWithNibName:@"iPictureSettingController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:settingViewController animated:YES]; 
    [settingViewController release];
    return;

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _categoryArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()] error:nil] retain];
    
    
    self.tableView.rowHeight = 60;  //根据类别数量配置行高
//    self.tableView.scrollEnabled = NO; //不允许滚动
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //增加导入图片按钮
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"设置", @"设置") style:UIBarButtonItemStyleDone target:self action:@selector(settingInput)];
    self.navigationItem.rightBarButtonItem = settingButton;
    [settingButton release];
    
    self.tableView.backgroundColor = [UIColor blackColor];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSString *path = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
//    _categoryArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil] copy];
    
    if (!_categoryArray) {
        _categoryArray = [[NSMutableArray alloc] init];
    }
    else
        [_categoryArray removeAllObjects];
    
    [_categoryArray addObjectsFromArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()] error:nil]];
    
//    if ([_categoryArray count] > 0) {
//        [_categoryArray removeAllObjects];
//        _categoryArray = nil;
//        [_categoryArray release];
//        _categoryArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()] error:nil];
//        [self.tableView reloadData];
//    }
//    else {
//        _categoryArray = nil;
//        [_categoryArray release];
//        _categoryArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()] error:nil];
//        [self.tableView reloadData];
//    }
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    return [_categoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CategoryRootCell *cell = (CategoryRootCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        cell.indentationLevel = 1;
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CategoryRootCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        
    }
    
    
//    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row % 2 == 0) ? @"DarkBackground" : @"LightBackground" ofType:@"png"];
//    UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
//    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
//    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    cell.backgroundView.frame = cell.bounds;
    
    // Configure the cell...
    cell.theLabel.text = [_categoryArray objectAtIndex:indexPath.row];
    //    UIFont *font = [UIFont systemFontOfSize:14];
    //    cell.detailTextLabel.font = font;
    //    cell.textLabel.font = font;
//    UIImage *icon = [UIImage imageNamed:[dic valueForKey:@"icon"]];
//    cell.iconImageView.image = icon;                 
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), [_categoryArray objectAtIndex:indexPath.row]];
    NSArray *nameArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSString *str in nameArray) {
        NSLog(@"Path::%@", str);

        if ([str rangeOfString:@".thumbnail"].length > 0) {
            continue;
        }
        if ([str isEqualToString:@"Details.plist"]) {
            continue;
        }
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@", path, str];
        [array addObject:fullPath];
    }
    ImageBrowseController *imgBrower = [[ImageBrowseController alloc] initWithImageNames:array];
    imgBrower.category = [_categoryArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:imgBrower animated:YES];
    [array release];
    [imgBrower release];
    
}

@end
