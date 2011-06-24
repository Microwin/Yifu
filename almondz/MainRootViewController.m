//
//  RootViewController.m
//  iFashion
//
//  Created by Wu Jianjun on 11-5-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MainRootViewController.h"
#import "iPictureViewController.h"
#import "MyTabbar.h"
#import "iPictureRootViewController.h"
@implementation MainRootViewController
@synthesize tableView = _tableView;
@synthesize lable = _lable;
@synthesize image = _image;
@synthesize listData = _listData;
//@synthesize listKey1 = _listKey1;
//@synthesize listData1 = _listData1;
//@synthesize listKey2 = _listKey2;
//@synthesize plistTabbaritem = _plistTabbaritem;

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
    [_tableView release];
    [_image release];
    [_lable release];
    [_listData release];
//    [_listData1 release];
//    [_listKey1 release];
//    [_listKey2 release];
//    [_plistTabbaritem release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)showiPictureViewController:(id)sender {
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Tabbaritem" ofType:@"plist"];
//    NSArray *_listKey2 = [[NSArray alloc] initWithContentsOfFile:path];
//    _plistTabbaritem = [_listKey2 valueForKey:@"Tabbaritem"];
    
    
//    MyTabbar *tabBar = [[MyTabbar alloc] init];
//    [self.navigationController pushViewController:tabBar animated:YES];  
//    [tabBar release];
//    iPictureRootViewController *rootViewController = [[iPictureRootViewController alloc] init];
//    [self presentModalViewController:rootViewController animated:YES];
    
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.title = @"Home";
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad
{
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"", @"时装欣赏", @"衣服搭配", @"我的衣柜", nil];
    self.listData = array;
    [array release];
    self.tableView = _tableView;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
//    self.listData = nil;
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
    return [[self listData] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [_listData objectAtIndex:row];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    UIFont *font = [UIFont systemFontOfSize:14];
    cell.textLabel.font = font;
    UIColor *color = [UIColor whiteColor];
    cell.textLabel.textColor =  color;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (indexPath.row == 1) {
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
//        [self showiPictureViewController:nil];
        iPictureRootViewController *rootViewController = [[iPictureRootViewController alloc] init];
        [self.navigationController pushViewController:rootViewController animated:YES]; 
        [rootViewController release];
    }
}

@end
