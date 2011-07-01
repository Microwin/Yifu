//
//  CategoryTableViewController.h
//  almondz
//
//  Created by 卞中杰 on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryTableCell.h"

@interface CategoryTableViewController : UITableViewController <CategoryTableCellDelegate, UIAlertViewDelegate> {
    NSMutableArray *_categoryArray;
}

@end
