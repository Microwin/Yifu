//
//  CategoryTableCell.m
//  almondz
//
//  Created by 卞中杰 on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryTableCell.h"


@implementation CategoryTableCell
@synthesize delegate;
@synthesize categoryLabel = _categoryLabel;

@synthesize indexPath = _indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)dealloc
{
    [_categoryLabel release];

    [_indexPath release];
    [super dealloc];
}

- (IBAction)deleteButtonPressed:(id)sender {
    [delegate deleteCategoryWithIndexPath:_indexPath];
}

- (IBAction)renameButtonPressed:(id)sender {
    [delegate renameCategoryWithIndexPath:_indexPath];
}

@end
