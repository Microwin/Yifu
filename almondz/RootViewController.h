//
//  RootViewController.h
//  almondz
//
//  Created by Wu Jianjun on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractScrollView.h"
#import "ImageBrowseController.h"
#import "CategoryButton.h"

enum ImporterType {
    ImporterTypeNone,
    ImporterTypeLibrary,
    ImporterTypeCamera,
};

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CategoryButtonDelegate>{
    
    UITableView *tableView;
    
    NSMutableArray *_selectedImage;
    AbstractScrollView *_categoryScrollView;
    ImageBrowseController *_imageBrowseController;
    
@private
    enum ImporterType imprterType;
}


@property (nonatomic, retain) NSMutableArray *selectedImage;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet AbstractScrollView *categoryScrollView;
@property (nonatomic, retain) ImageBrowseController *imageBrowseController;
- (IBAction)mangeButtonPressed:(id)sender;
- (IBAction)photoButtonPressed:(id)sender;
- (IBAction)inputButtonPressed:(id)sender;

@end
