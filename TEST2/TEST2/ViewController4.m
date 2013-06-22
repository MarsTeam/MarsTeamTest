//
//  ViewController4.m
//  TEST2
//
//  Created by Mars on 13-6-14.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController4.h"

@interface ViewController4 ()
{
    NSTimer     *times;
    UIView *arrowView;
    UIImageView *myView;
    
    UIImageView      *superView;
    UIButton    *button;
}
@end

@implementation ViewController4

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(Onback)];
    // Do any additional setup after loading the view from its nib.
    
    
    superView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 200, 200)];
    superView.hidden = NO;
    NSString * imageName = @"mars.jpg";
    superView.image = [UIImage imageNamed:imageName];
    //[self.view addSubview:superView];
    
    myView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 200, 200)];
    myView.image = [UIImage imageNamed:@"photo_bac@2x.png"];
    
    arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(10,150, 200, 200)];
    arrowView.hidden = NO;
    [arrowView addSubview:superView];
    [self.view addSubview:arrowView];
    
    
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [button setTitle:@"反转" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.tag = 0;
    [button addTarget:self action:@selector(spin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(60, 0, 50, 50)];
    [button2 setTitle:@"Path" forState:UIControlStateNormal];
    button2.tag = 1;
    button2.backgroundColor = [UIColor blackColor];
    [button2 addTarget:self action:@selector(tranAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(130, 0, 50, 50)];
    [button3 setTitle:@"旋转" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor blackColor];
    button3.tag =2;
    [button3 addTarget:self action:@selector(RightRotateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 120, 50)];
    [button4 setTitle:@"放大缩小" forState:UIControlStateNormal];
    button4.backgroundColor = [UIColor blackColor];
    button4.tag =3;
    [button4 addTarget:self action:@selector(bigsmill) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    
    UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, 50, 50)];
    [button5 setTitle:@"Y轴" forState:UIControlStateNormal];
    button5.backgroundColor = [UIColor blackColor];
    button5.tag =3;
    [button5 addTarget:self action:@selector(animationOption) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    
    UIButton *button6 = [[UIButton alloc] initWithFrame:CGRectMake(70, 60, 50, 50)];
    [button6 setTitle:@"翻页" forState:UIControlStateNormal];
    button6.backgroundColor = [UIColor blackColor];
    button6.tag =3;
    [button6 addTarget:self action:@selector(startPag) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    
    

}

- (IBAction)tranAction:(id)sender {
    CGPoint fromPoint = arrowView.center;
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(300, 460);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //旋转变化
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x，y轴缩小到0.1,Z 轴不变
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //关键帧，旋转，透明度组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim,opacityAnim, nil];
    animGroup.duration = 2;
    [arrowView.layer addAnimation:animGroup forKey:nil];
}


- (IBAction)RightRotateAction:(id)sender {
    CGPoint fromPoint = arrowView.center;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(fromPoint.x +100 , fromPoint.y ) ;
    [movePath addLineToPoint:toPoint];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //沿Z轴旋转
    TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,0,1)];
    
    //沿Y轴旋转
    //   scaleAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,1.0,0)];
    
    //沿X轴旋转
    //     TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,1.0,0,0)];
    TransformAnim.cumulative = YES;
    TransformAnim.duration =3;
    //旋转2遍，360度
    TransformAnim.repeatCount =2;
    arrowView.center = toPoint;
    TransformAnim.removedOnCompletion = YES;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, TransformAnim, nil];
    animGroup.duration = 6;
    
    [arrowView.layer addAnimation:animGroup forKey:nil];
}


-(void)animationOption
{
    
    [UIView animateWithDuration:.5 delay:.5 options:UIViewAnimationOptionAutoreverse animations:^{
            arrowView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.5 animations:^{
            
                    arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 0);
            } completion:^(BOOL finished) {
                
            }];
            
    }];
}


-(void)startPag
{
    
    [UIView transitionWithView:arrowView
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{ [superView removeFromSuperview]; [arrowView addSubview:myView]; }
                    completion:NULL];
}




-(void)bigsmill
{
    
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    
        arrowView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            arrowView.layer.transform = CATransform3DMakeScale(2, 2, 0);
        } completion:^(BOOL finished) {
            arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 0);
        }];
    }];
}


-(void)action:(id)sender
{
    UIButton *buton = sender;
//    switch (buton.tag) {
//        case 0:
//            arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
//           
//            break;
//        case 1:
//            arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
//            break;
//        case 2:
//            arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//            break;
//            
//        default:
//            break;
//    }
    
//    [UIView animateWithDuration:5
//                     animations:^{
//                         @autoreleasepool {
//                             arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 0);
//                         }
//                     }
//     ];
    button.enabled = NO;
    [UIView animateWithDuration:.1
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction //设置动画类型
                     animations:^{
                         //开始动画
                         arrowView.layer.transform = CATransform3DMakeRotation(0.4, 0.0, 0.0, 1.0);
                         //arrowView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0);
                     }
                     completion:^(BOOL finished){
                         // 动画结束时的处理
                         [UIView animateWithDuration:.1 animations:^{
                         
                             arrowView.layer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 0.0);
                         }completion:^(BOOL finished) {
                             [UIView animateWithDuration:.1 animations:^{
                                                              
                                 arrowView.layer.transform = CATransform3DMakeRotation(6.0, 0.0, 0.0, 1.0);
                             }completion:^(BOOL finished) {
                                 [UIView animateWithDuration:.1 animations:^{
                                     arrowView.layer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 0.0);
                                 }];
                             }];
                         }];
                     }];

}

-(IBAction)spin
{
    
    float interval = .4;
    times = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(action:) userInfo:nil repeats:YES];
    
    //[NSThread  sleepForTimeInterval:1.8];
    
    //arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0.0, 0.0, 0);
    
    //后台线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread  sleepForTimeInterval:1.2]; //等待60秒
        dispatch_async(dispatch_get_main_queue (), ^{
            //主线程
//            [self actioned];
            [times invalidate];
            button.enabled = YES;
        });
    });
    
    
}


-(void)actioned{
    arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);

}


-(void)Onback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
