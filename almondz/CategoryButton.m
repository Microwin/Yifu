//
//  CategoryButton.m
//  almondz
//
//  Created by 中杰 卞 on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryButton.h"

@implementation CategoryButton
@synthesize categoryName = _categoryName;
@synthesize categoryPath = _categoryPath;
@synthesize icon = _icon;
@synthesize imageNamesArray = _imageNamesArray;
@synthesize delegate;

- (void)categoryButtonPressed:(id)sender {
    [delegate categoryButtonPressed:_categoryName imageNamesArray:_imageNamesArray];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

    }
    return self;

}

- (void)getImageNamesArray {
    if (!_imageNamesArray) {
        _imageNamesArray = [[NSMutableArray alloc] init];
    }
    else
        [_imageNamesArray removeAllObjects];
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _categoryName];
    NSArray *nameArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    //NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSString *str in nameArray) {
        NSLog(@"Path::%@", str);
        
        if ([str rangeOfString:@".thumbnail"].length > 0) {
            continue;
        }
        if ([str isEqualToString:@"Details.plist"]) {
            continue;
        }
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@", path, str];
        [_imageNamesArray addObject:fullPath];
    }
    [self addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealloc {
    [_categoryName release];
    [_categoryPath release];
    [_icon release];
    [_imageNamesArray release];
    [super dealloc];
}
@end
