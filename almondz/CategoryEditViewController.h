//
//  CategoryEditViewController.h
//  almondz
//
//  Created by 卞中杰 on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CategoryEditViewController : UIViewController  {
    BOOL isRename;  //新建还是修改
    NSString *_oldCategory;
    UITextField *_categoryTextField;
}
@property (nonatomic, retain) IBOutlet UITextField *categoryTextField;
@property (nonatomic, retain) NSString *oldCategory;
@property (nonatomic, assign) BOOL isRename;
- (IBAction)okButtonPressed:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
@end
