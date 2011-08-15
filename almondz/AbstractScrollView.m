//
//  AbstractScrollView.m
//  almondz
//
//  Created by 中杰 卞 on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AbstractScrollView.h"
#import "CategoryButton.h"
#import "ImageBrowseController.h"
@implementation AbstractScrollView
@synthesize contentArray = _contentArray;
@synthesize parentController;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = YES;
    //[self LoadContents];
}

- (void)dealloc {
    [_contentArray release];
    [super dealloc];
}

- (void)showCatName:(id)sender {
    CategoryButton *btn = (CategoryButton *)sender;
    NSLog(@"CAT:%@", btn.categoryName);
    ImageBrowseController *bro = [[ImageBrowseController alloc] initWithImageNames:btn.imageNamesArray];
    bro.category = btn.categoryName;
    [parentController pushViewController:bro animated:YES];
    [bro release];
}

- (void)LoadContents {
    if (!_contentArray) {
        _contentArray = [[NSMutableArray alloc] init];
    }
    else
        [_contentArray removeAllObjects];
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    NSArray *categoryArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *name in categoryArray) {
        CategoryButton *btn = [[CategoryButton alloc] initWithFrame:CGRectMake(_contentArray.count * 66, 0, 66, 66)];
        btn.categoryName = name;
        [btn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [_contentArray addObject:btn];
        //[btn addTarget:self action:@selector(showCatName:) forControlEvents:UIControlEventTouchUpInside];
        [btn getImageNamesArray];
        btn.delegate = parentController;
        [self addSubview:btn];
        [btn release];
    }
    
}
@end
