//
//  RootCell.m
//  almondz
//
//  Created by Wu Jianjun on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RootCell.h"


@implementation RootCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithRed:0.882 green:0.882 blue:0.882 alpha:1]; 
}

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

- (void)dealloc
{
    [super dealloc];
}

@end
