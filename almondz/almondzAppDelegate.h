//
//  almondzAppDelegate.h
//  almondz
//
//  Created by Wu Jianjun on 11-5-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainRootViewController;

@interface almondzAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *_window;
    UINavigationController *_naviController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *naviController;

@end
