//
//  DialogView.h
//  almondz
//
//  Created by Wu Jianjun on 11-6-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialogView : UIControl <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> {
    UITextField *_textField; //输入分类
    UITextField *_detailTextField; //输入描述
    UIButton *_okButton;
    UIButton *_cacelButton;
    UIPickerView *_pickerView;
    NSArray *_categoryArray;

}
@property (nonatomic, retain) IBOutlet UIButton *okButton;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UITextField *detailTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

- (IBAction)showPickerView:(id)sender;
- (IBAction)closeWindows:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
@end
