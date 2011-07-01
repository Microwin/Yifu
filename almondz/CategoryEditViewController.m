//
//  CategoryEditViewController.m
//  almondz
//
//  Created by 卞中杰 on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryEditViewController.h"


@implementation CategoryEditViewController
@synthesize categoryTextField = _categoryTextField;
@synthesize oldCategory = _oldCategory;
@synthesize isRename;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _oldCategory = @"";
    }
    return self;
}

- (void)dealloc
{
    [_categoryTextField release];
    [_oldCategory release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"修改分类名"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (isRename) {
        _categoryTextField.text = _oldCategory;
    }
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

- (IBAction)okButtonPressed:(id)sender {
    if (![_categoryTextField.text isEqualToString:@""]) {
        if (isRename) {
            NSString *name = _categoryTextField.text;
            NSString *path = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
            [[NSFileManager defaultManager] moveItemAtPath:[NSString stringWithFormat:@"%@/%@", path, _oldCategory] toPath:[NSString stringWithFormat:@"%@/%@", path, name] error:nil];
        }
        else {
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _categoryTextField.text] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (IBAction)closeKeyboard:(id)sender {
    [_categoryTextField resignFirstResponder];
}

//
//#pragma mark - TextField Delegate
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    
//}
@end
