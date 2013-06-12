//
//  tableSectionBar.h
//  TEST2
//
//  Created by Mars on 13-6-12.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SectionBarDelegate <NSObject>

-(void)ButtonInAction:(id)sender;

@end


@interface tableSectionBar : UIView

@property (nonatomic, assign) id delegate;

-(void)Action:(id)sender;


+(tableSectionBar *)shareTableSectionBar;
@end
