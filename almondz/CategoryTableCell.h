//
//  CategoryTableCell.h
//  almondz
//
//  Created by 卞中杰 on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryTableCellDelegate <NSObject>

- (void)deleteCategoryWithIndexPath:(NSIndexPath *)indexPath;
- (void)renameCategoryWithIndexPath:(NSIndexPath *)indexPath;
@end

@interface CategoryTableCell : UITableViewCell {
    UILabel *_categoryLabel;

    NSIndexPath *_indexPath;
    id <CategoryTableCellDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel;

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) id <CategoryTableCellDelegate> delegate;
- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)renameButtonPressed:(id)sender;
@end
