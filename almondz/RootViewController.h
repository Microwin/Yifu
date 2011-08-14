//
//  RootViewController.h
//  almondz
//
//  Created by Wu Jianjun on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

enum ImporterType {
    ImporterTypeNone,
    ImporterTypeLibrary,
    ImporterTypeCamera,
};

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    UITableView *tableView;
    
    NSMutableArray *_selectedImage;
    
@private
    enum ImporterType imprterType;
}


@property (nonatomic, retain) NSMutableArray *selectedImage;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
- (IBAction)mangeButtonPressed:(id)sender;
- (IBAction)photoButtonPressed:(id)sender;
- (IBAction)inputButtonPressed:(id)sender;

@end
