//
//  AbstractScrollView.h
//  almondz
//
//  Created by 中杰 卞 on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractScrollView : UIScrollView {
    NSMutableArray *_contentArray;
    id parentController;
}
@property (nonatomic, retain) NSMutableArray *contentArray;
@property (nonatomic, assign) id parentController;

- (void)LoadContents;
@end
