//
//  ViewController.h
//  TEST2
//
//  Created by 张 炜超 on 13-4-28.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *goButoon;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@end
