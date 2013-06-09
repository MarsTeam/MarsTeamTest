//
//  ViewController3.m
//  TEST2
//
//  Created by Mars on 13-6-9.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()
{
    UIScrollView *scrollview;
    UIView *viewTop;
    UIView *viewBlack;
}

@end

@implementation ViewController3

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
    
    
    
    
    scrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,500)];
    scrollview.contentSize=CGSizeMake(320,900);
    scrollview.backgroundColor=[UIColor whiteColor];
    //scrollview.pagingEnabled=YES;//是否自己动适应
    
    UIImageView *viewImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    viewImg.image = [UIImage imageNamed:@"photo_bac@2x.png"];
    [scrollview addSubview:viewImg];
    
    
    viewBlack = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 320, 60)];
    UIImageView *BlackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    BlackImg.image = [UIImage imageNamed:@"left_white@2x.png"];
    [viewBlack addSubview:BlackImg];
    [scrollview addSubview:viewBlack];
    
    
    [self.view addSubview:scrollview];
    scrollview.maximumZoomScale=2.0;
    scrollview.minimumZoomScale=0.5;
    //    scrollview.decelerationRate=1;
    scrollview.delegate=self;
    //canCancelContentTouches:YES-移动手指足够长度触发滚动事件,NO-scrollView发送 tracking events 后，就算用户移动手指，scrollView也不会滚动。
    scrollview.canCancelContentTouches=NO;
    
    //当值是 YES的时候，用户触碰开始.要延迟一会，看看是否用户有意图滚动。假如滚动了，那么捕捉 touch-down事件，否则就不捕捉。假如值是NO，当用户触碰， scroll view会立即触发
    scrollview.delaysContentTouches=YES;
    
    // Do any additional setup after loading the view from its nib.
    
    
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    UIImageView *TopImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    TopImg.image = [UIImage imageNamed:@"left_white@2x.png"];
    [viewTop addSubview:TopImg];
    viewTop.hidden = YES;
    [self.view addSubview:viewTop];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
   //NSLog(@"y:%f",scrollView.contentOffset.y);

    if (scrollView.contentOffset.y>200) {
        
        viewTop.hidden = NO;
        NSLog(@"出来了");
        //self.barUiew2.frame = CGRectMake(0,126,320,52);
    }else{
        viewTop.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
