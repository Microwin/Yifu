//
//  iPictureRootViewController.h
//  almondz
//
//  Created by Wu Jianjun on 11-6-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iPictureRootViewController : UITableViewController {
    
    NSMutableArray *_categoryArray;
    NSDictionary *_plistKey;
}

//@property (nonatomic, retain) NSArray *categoryArray;
@property (nonatomic, retain) NSDictionary *plistKey;


@end
