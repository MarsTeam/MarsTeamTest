//
//  tableSectionBar.m
//  TEST2
//
//  Created by Mars on 13-6-12.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import "tableSectionBar.h"

@interface tableSectionBar ()
{
    
    UIButton *leftButton;
    UIButton *centerButton;
    UIButton *rightButton;
    
}
@end


@implementation tableSectionBar
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UIView *viewBlack = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 320, 50)];
        
        leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 106.5, 50)];
        [leftButton setImage:[UIImage imageNamed:@"tab1_off@2x.png"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"tab1_on@2x.png"] forState:UIControlStateSelected];
        leftButton.tag = 0;
        leftButton.selected = YES;
        [leftButton setTitle:@"leftButton" forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        
        
        centerButton = [[UIButton alloc] initWithFrame:CGRectMake(106.5, 0, 106.5, 50)];
        [centerButton setImage:[UIImage imageNamed:@"tab2_off@2x.png"] forState:UIControlStateNormal];
        [centerButton setImage:[UIImage imageNamed:@"tab2_on@2x.png"] forState:UIControlStateSelected];
        centerButton.tag = 1;
        [centerButton setTitle:@"centerButton" forState:UIControlStateNormal];
        [centerButton addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        
        rightButton = [[UIButton alloc] initWithFrame:CGRectMake(213, 0, 106.5, 50)];
        [rightButton setImage:[UIImage imageNamed:@"tab3_off@2x.png"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"tab3_on@2x.png"] forState:UIControlStateSelected];
        rightButton.tag = 2;
        [rightButton setTitle:@"rightButton" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self addSubview:leftButton];
        [self addSubview:centerButton];
        [self addSubview:rightButton];
    }
    return self;
}


-(void)Action:(id)sender
{
    UIButton *button = sender;
    switch (button.tag) {
        case 0:
            leftButton.selected = YES;
            centerButton.selected = NO;
            rightButton.selected = NO;
            
            [_delegate ButtonInAction:sender];
            break;
        case 1:
            
            leftButton.selected = NO;
            centerButton.selected = YES;
            rightButton.selected = NO;
            
            [_delegate ButtonInAction:sender];
            break;
        case 2:
            leftButton.selected = NO;
            centerButton.selected = NO;
            rightButton.selected = YES;
            
            
            [_delegate ButtonInAction:sender];
            break;
        default:
            break;
    }
    
}


+(tableSectionBar *)shareTableSectionBar
{
    static tableSectionBar *_shared = nil;
    static dispatch_once_t onceToken;
    
    
    dispatch_once(&onceToken, ^{
        _shared = [[tableSectionBar alloc] init];
    });
    
    return _shared;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
