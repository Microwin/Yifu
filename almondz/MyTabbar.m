//
//  MyTabbar.m
//  almondz
//
//  Created by Wu Jianjun on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyTabbar.h"
#import "iPictureViewController.h"
#import "iPictureSettingController.h"

@implementation MyTabbar

- (id)init
{
    self = [super init];
    if (self) {
        iPictureViewController *iPicture1 = [[[iPictureViewController alloc] init] autorelease];
        iPictureViewController *iPicture2 = [[[iPictureViewController alloc] init] autorelease];
        iPictureViewController *iPicture3 = [[[iPictureViewController alloc] init] autorelease];
        iPictureViewController *iPicture4 = [[[iPictureViewController alloc] init] autorelease];
        iPictureSettingController *iPicture5 = [[[iPictureSettingController alloc] init] autorelease];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"RefData" ofType:@"plist"];
        NSDictionary *_listKey1 = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSArray *array = [_listKey1 valueForKey:@"RefDataArray"];
        NSMutableArray *_listData1 = [[NSMutableArray alloc] initWithCapacity:20];
        for (NSDictionary *dic in array) {
            NSString *str = [dic valueForKey:@"image"];
            [_listData1 addObject:str];
        }
        
        iPicture1.plistData = [NSArray arrayWithArray:_listData1];
        
        iPicture1.tabBarItem.title = @"Business";
        iPicture2.tabBarItem.title = @"Party";
        iPicture3.tabBarItem.title = @"Relax";
        iPicture4.tabBarItem.title = @"Sport";
        iPicture5.tabBarItem.title = @"Setting";
        
        
        NSArray *array0 = [NSArray arrayWithObjects:iPicture1, iPicture2, iPicture3, iPicture4, iPicture5, nil];
        
        self.viewControllers = array0;
        
        [_listData1 release];
        [_listKey1 release];

    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end
