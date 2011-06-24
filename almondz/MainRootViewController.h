//
//  RootViewController.h
//  iFashion
//
//  Created by Wu Jianjun on 11-5-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainRootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    UILabel *_lable;
    UIImageView *_image;
    NSArray *_listData;
//    NSArray *_listData1;
//    NSDictionary *_listKey1;
//    NSArray *_listKey2;
//    NSArray *_plistTabbaritem;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UILabel *lable;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) NSArray *listData;
//@property (nonatomic, retain) NSArray *listData1;
//@property (nonatomic, retain) NSDictionary *listKey1;
//@property (nonatomic, retain) NSArray *listKey2;
//@property (nonatomic, retain) NSArray *plistTabbaritem;

@end
