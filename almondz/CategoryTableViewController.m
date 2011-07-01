//
//  CategoryTableViewController.m
//  almondz
//
//  Created by 卞中杰 on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "CategoryEditViewController.h"
@interface CategoryTableViewController ()
- (void)addButtonPressed;
@end
@implementation CategoryTableViewController

static NSIndexPath *indexPathToDelete = nil;    //用于删除的行

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _categoryArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()] error:nil] retain];
//        _categoryArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_categoryArray release];
    [super dealloc];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *plusBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
     self.navigationItem.rightBarButtonItem = plusBtn;
    [plusBtn release];
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
    [self.navigationItem setTitle:@"分类管理"];
    if ([_categoryArray count] > 0) {
        [_categoryArray removeAllObjects];
        _categoryArray = nil;
        [_categoryArray release];
        _categoryArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()] error:nil] retain];
        [self.tableView reloadData];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    
    CategoryTableCell *cell = (CategoryTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableCell" owner:self options:nil];
        CategoryTableCell *temp = [array objectAtIndex:0];
        if ([temp isKindOfClass:[CategoryTableCell class]]) {
            cell = temp;
            cell.delegate = self;
        }
    }

    NSLog(@"Row:%d, Section:%d", indexPath.row, indexPath.section);
    // Configure the cell...
    cell.indexPath = indexPath;
    cell.categoryLabel.text = [_categoryArray objectAtIndex:indexPath.row];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
}

- (void)addButtonPressed {
    CategoryEditViewController *editView = [[CategoryEditViewController alloc] initWithNibName:@"CategoryEditViewController" bundle:[NSBundle mainBundle]];
    editView.isRename = NO;
    [self.navigationController pushViewController:editView animated:YES];
    [editView release];
}

#pragma mark - Category Table Cell Delegate

- (void)deleteCategoryWithIndexPath:(NSIndexPath *)indexPath {
    indexPathToDelete = indexPath;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除分类" message:@"确认要删除这个分类吗？\n此分类下的照片也将一并被删除。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];

    
}

- (void)renameCategoryWithIndexPath:(NSIndexPath *)indexPath {
    CategoryEditViewController *editView = [[CategoryEditViewController alloc] initWithNibName:@"CategoryEditViewController" bundle:[NSBundle mainBundle]];
    editView.isRename = YES;
    editView.oldCategory = ((CategoryTableCell *)[self.tableView cellForRowAtIndexPath:indexPath]).categoryLabel.text;
    [self.navigationController pushViewController:editView animated:YES];
    [editView release];
    
}

#pragma mark - Alert Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //确认删除，执行删除操作
    if (buttonIndex == 1) {
        NSString *name = ((CategoryTableCell *)[self.tableView cellForRowAtIndexPath:indexPathToDelete]).categoryLabel.text;
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), name] error:nil];
        [_categoryArray removeObjectAtIndex:indexPathToDelete.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathToDelete] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
    indexPathToDelete = nil;
}

@end
