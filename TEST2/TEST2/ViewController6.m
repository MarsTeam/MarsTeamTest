//
//  ViewController6.m
//  TEST2
//
//  Created by Mars on 13-6-30.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import "ViewController6.h"

@interface ViewController6 ()
{

    UIImageView *jurenImageViewOne;
    UIImageView *jurenImageViewTwo;
    UIView *firstView;
    UIView *secondView;
    UIView *threeUiview;
    UIView *blackgroundView;
    
    UIButton *leftButton;
    UIButton *rightButton;
    
    CGRect viewFrame;
}
@end

@implementation ViewController6

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //滚动View 追加的View frame
    viewFrame =  CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(onBack)];
    
    
    //设置背景层view循环在背景层上
    blackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height)];

    jurenImageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height)];
    jurenImageViewOne.image = [UIImage imageNamed:@"juren.jpg"];
    
    
    jurenImageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height)];
    jurenImageViewTwo.image = [UIImage imageNamed:@"juren.jpg"];
    
    
    //滚动的第一个视图
    firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [firstView addSubview:jurenImageViewOne];
    [blackgroundView addSubview:firstView];
    [self.view addSubview:blackgroundView];
    
    
    leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftButton.frame = CGRectMake(20, 150,120 ,120);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_button.jpg"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(moveButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    
    rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.frame = CGRectMake(180, 150,120 ,120);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_button.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(moveButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    

    
    float interval = .1;
    [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(ifOver) userInfo:nil repeats:YES];
    
}


- (void)moveButton
{
    [UIView animateWithDuration:0.5 animations:^{
        int newPointX = leftButton.center.x-20;
        int newPointY = leftButton.center.y;
        leftButton.center = CGPointMake(newPointX, newPointY);
        
        
        newPointX = rightButton.center.x+20;
        newPointY = rightButton.center.y;
        rightButton.center = CGPointMake(newPointX, newPointY);
        
        leftButton.alpha = 0;
        rightButton.alpha = 0;
        
    } completion:^(BOOL finished) {}];
    

}


//判断是否加载后续View
- (void)ifOver
{
    if(firstView.center.y == self.view.frame.size.height/2)
    {
        NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++加载第Second view");
        secondView = nil;
        secondView = [[UIView alloc] initWithFrame:viewFrame];
        [secondView addSubview:jurenImageViewTwo];
        [blackgroundView addSubview:secondView];
        
    }else if(secondView.center.y == self.view.frame.size.height/2){
        NSLog(@"------------------------------------------------加载第First view");
        firstView = nil;
        firstView = [[UIView alloc] initWithFrame:viewFrame];
        [firstView addSubview:jurenImageViewOne];
        [blackgroundView addSubview:firstView];
        

    }
    
    //执行难一次VIEW 移动动画
    [self runView];
}


- (void)runView
{
        [UIView animateWithDuration:0.0001 animations:^{
            int newPointX = firstView.center.x;
            int newPointY = firstView.center.y-2;
            firstView.center = CGPointMake(newPointX, newPointY);
            newPointX = secondView.center.x;
            newPointY = secondView.center.y-2;
            secondView.center = CGPointMake(newPointX, newPointY);
        } completion:^(BOOL finished) {

        }];
}

//点击屏幕的时候判断 leftButton rightButton 是否已经隐藏 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏变为显示
    if (leftButton.alpha == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            int newPointX = leftButton.center.x+20;
            int newPointY = leftButton.center.y;
            leftButton.center = CGPointMake(newPointX, newPointY);
            
            
            newPointX = rightButton.center.x-20;
            newPointY = rightButton.center.y;
            rightButton.center = CGPointMake(newPointX, newPointY);
            
            leftButton.alpha = 1;
            rightButton.alpha = 1;
            
        } completion:^(BOOL finished) {}];
    }
}



-(void)onBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
