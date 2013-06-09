//
//  DuduCell.h
//  TEST2
//
//  Created by Mars on 13-6-7.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DuduCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *titleLable;
    UILabel *DetailLable;

}
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *DetailLable;

@end
