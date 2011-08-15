//
//  CategoryButton.h
//  almondz
//
//  Created by 中杰 卞 on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryButtonDelegate <NSObject>

- (void)categoryButtonPressed:(NSString *)categoryName imageNamesArray:(NSMutableArray *)imageNamesArray;

@end
@interface CategoryButton : UIButton {
    NSString *_categoryName;
    NSString *_categoryPath;
    NSMutableArray *_imageNamesArray;
    UIImage *_icon;
    id <CategoryButtonDelegate> delegate;
}
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *categoryPath;
@property (nonatomic, retain) UIImage *icon;
@property (nonatomic, retain) NSMutableArray *imageNamesArray;
@property (nonatomic, assign) id <CategoryButtonDelegate> delegate;
- (void)getImageNamesArray;
@end
