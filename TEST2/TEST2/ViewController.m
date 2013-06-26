//
//  ViewController.m
//  TEST2
//
//  Created by 张 炜超 on 13-4-28.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"

@interface ViewController ()
{
    int     j;
    int     countFun;
    NSTimer *times;
    NSArray *column1;
    NSArray *column2;
    NSArray *column3;
    
    UIImageView *snakeImageView;
    
    CGPoint beginPoint;
}
@end

@implementation ViewController


- (void)loadView
{

    [super loadView];

    
    
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btn2 setTitle:@"发送Photo消息给微信" forState:UIControlStateNormal];
//    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn2 setFrame:CGRectMake(165, 25, 145, 40)];
//    [btn2 addTarget:self action:@selector(sendImageContent) forControlEvents:UIControlEventTouchUpInside];
//    [footView addSubview:btn2];
    
    
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"plisttext" ofType:@"plist"];
    
    NSLog(@"path:%@",plistPath);
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"dataMars:%@",data);
    
    [data setObject:@"wocharu dd" forKey:@"Dudu"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"plisttext.plist"];
    
    [data writeToFile:filename atomically:YES];
    
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"data1:%@", data1);
    
    
    
    
    
    
    //GCD 多线程
    
    UInt32 loopCount = 1000;
    UInt32 loopCountFirst = 10000000;
    
    void (^taskFirst)(void) = ^{
        NSLog(@"taskFirst 任务开始执行\r\n");
        
        //延长taskFirst的运行时间
        for (UInt32 i = 0; i < loopCountFirst; i++) {
            
        }
        NSLog(@"taskFirst 任务结束\r\n");
    };
    
    void (^taskSecond)(void) = ^{
        NSLog(@"taskSecond任务开始执行\r\n");
        for (UInt32 i = 0; i < loopCount; i ++) {
            
        }
        NSLog(@"taskSecond 任务结束\r\n");
    };
    dispatch_queue_t serialQueue;
    serialQueue = dispatch_queue_create("serialDemo", NULL);
    //创建第二个队列
    dispatch_queue_t serialQueueSecond = dispatch_queue_create("serialSecondDemo", NULL);
    dispatch_async(serialQueue, taskFirst);
    NSLog(@"taskfirst 已经加入队列\r\n");
    dispatch_async(serialQueueSecond, taskSecond);
    NSLog(@"tasksecond 已经加入队列\r\n");
    
  
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t qroup = dispatch_group_create();

    
    dispatch_async(concurrentQueue, taskFirst);
    NSLog(@"taskfirst 已经加入队列\r\n");
    dispatch_async(concurrentQueue, taskSecond);
    NSLog(@"tasksecond 已经加入队列\r\n");
    
    dispatch_group_async(qroup, concurrentQueue,taskFirst);
    dispatch_group_async(qroup, concurrentQueue, taskSecond);
    //等待上面两个执行后才执行
    dispatch_group_notify(qroup, concurrentQueue, taskSecond);
    
    
    
    
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(10, 250, 60, 50);
    button1.tag = 1;
    [button1 setTitle:@"VIEW2" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(goView2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(90, 250, 60, 50);
    button2.tag = 2;
    [button2 setTitle:@"VIEW3" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(goView3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame = CGRectMake(170, 250, 60, 50);
    button3.tag = 3;
    [button3 setTitle:@"VIEW4" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(goView4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    
    
    NSString *contents = @"您有一条TEST2未读的新消息";
    [self localNotification:contents];
    
    UIImage *image = [UIImage imageNamed:@"mars.jpg"];
    [self imageUpload:image];

    
//    int (^maxBlock)(int, int) = ^(int x, int y)
//    {
//        return x+y;
//    };
//    
//    int aa = maxBlock(10,50);
//    
//    NSLog(@"%d",aa);
    
    j = 0;
    CGRect pickerFrame = CGRectMake(0, 0, 120, 80);
    self.picker.frame = pickerFrame;
    
    UIImage *happy=[UIImage imageNamed:@"China@2x.png"];
    UIImage *gold=[UIImage imageNamed:@"England@2x.png"];
    UIImage *santa=[UIImage imageNamed:@"France@2x.png"];
    UIImage *tsitter=[UIImage imageNamed:@"Germany@2x.png"];
    UIImage *monkey=[UIImage imageNamed:@"Italy@2x.png"];
    

    
    for(int i=1;i<=3;i++)
    {
        UIImageView *happyview=[[UIImageView alloc] initWithImage:happy];
        UIImageView *goldview=[[UIImageView alloc] initWithImage:gold];
        UIImageView *santaView=[[UIImageView alloc] initWithImage:santa];
        UIImageView *tsitterview=[[UIImageView alloc] initWithImage:tsitter];
        UIImageView *monkeyview=[[UIImageView alloc] initWithImage:monkey];

        
        NSArray *imgViewArray=[[NSArray alloc] initWithObjects:happyview,goldview,santaView,tsitterview,monkeyview, nil];
        
        
        //NSLog(@"imgViewArray:%@",imgViewArray);
        
        NSString *columnname=[[NSString alloc] initWithFormat:@"column%d",i];
        [self setValue:imgViewArray forKey:columnname];
    }
    srandom(time(NULL));
    
    
    
    snakeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"China@2x.png"]];
    snakeImageView.frame = CGRectMake(0, 0, 80, 150);
    snakeImageView.center = CGPointMake(280, 50);
    [self.view addSubview:snakeImageView];
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    
    beginPoint = [touch locationInView:snakeImageView];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    if (self.goButoon.enabled == YES) {
        UITouch *touch = [touches anyObject];
        
        CGPoint nowPoint = [touch locationInView:snakeImageView];
        
        //float offsetX = nowPoint.x - beginPoint.x;
        float offsetY = nowPoint.y - beginPoint.y;
        
        if(snakeImageView.center.y + offsetY <150)
        {
            snakeImageView.center = CGPointMake(280, snakeImageView.center.y + offsetY);
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"hahahah");
    snakeImageView.center = CGPointMake(280, 50);
    if (self.goButoon.enabled == YES) {
        [self spin];
    }
}


- (void)localNotification:(NSString *)contents{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:5];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1;
        notification.alertBody=contents;
        notification.alertAction = @"打开";
        NSLog(@"heh:%@",contents);
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //发送通知
    //    UILocalNotification *notification=[[UILocalNotification alloc] init];
    //    if (notification!=nil) {
    //        NSDate *now=[NSDate new];
    //        notification.fireDate=[now dateByAddingTimeInterval:1];//10秒后通知
    //        notification.repeatInterval=5;//循环次数，kCFCalendarUnitWeekday一周一次
    //        notification.timeZone=[NSTimeZone defaultTimeZone];
    //        notification.applicationIconBadgeNumber=1; //应用的红色数字
    //        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
    //        //去掉下面2行就不会弹出提示框
    //        notification.alertBody=@"通知内容";//提示信息 弹出提示框
    //        notification.alertAction = @"打开";  //提示框按钮
    //        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
    //
    //        // NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    //        //notification.userInfo = infoDict; //添加额外的信息
    //
    //        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    }
    //[notification release];
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
}

//上传图片方法
- (void) imageUpload:(UIImage *) image{
    //把图片转换成imageDate格式
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    //传送路径
    NSString *urlString = @"http://localhost/host/upload_file.php";
    //建立请求对象
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    //设置请求路径
    [request setURL:[NSURL URLWithString:urlString]];
    //请求方式
    [request setHTTPMethod:@"POST"];
    //一连串上传头标签
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary]dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"vim_go.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary]dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    //上传文件开始
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //获得返回值
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",returnString);
}


-(IBAction)spin
{
        countFun = 100000;
        times=[NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(function) userInfo:nil repeats:YES];
}


-(IBAction)stop
{
    countFun = 50;
}


-(void)function
{
    j++;
    if(j%countFun==0)
    {
        [times invalidate];
        times=nil;
        int firstvalue=random()%1000;
        [self.picker selectRow:firstvalue inComponent:0 animated:YES];       //得出结果
        [self.picker reloadComponent:0];
        int secondvalue=random()%1000;
        [self.picker selectRow:secondvalue inComponent:1 animated:YES];
        [self.picker reloadComponent:1];
        int thirdvalue=random()%1000;
        [self.picker selectRow:thirdvalue inComponent:2 animated:YES];
        [self.picker reloadComponent:2];
        NSLog(@"%d",firstvalue%5);
        if (firstvalue%5==secondvalue%5&&firstvalue%5==thirdvalue%5) 
        {
            [self alertMess:@"3个一样，恭喜！！"];
        }
        else if(firstvalue%5==secondvalue%5||firstvalue%5==thirdvalue%5||secondvalue%5==thirdvalue%5)
        {
            [self alertMess:@"2个一样，继续加油"];
        }
        /*
         for (int i=0; i<3; i++) {
         int newValue=random()%1000;
         if (newValue%5==lastval%5) {
         numInRow++;
         }
         else numInRow=1;
         lastval=newValue;
         [picker selectRow:newValue inComponent:i animated:YES];
         [picker reloadComponent:i];
         if (numInRow==2) {
         money=money+2*zhu;
         }
         else if(numInRow==3)
         {
         money=money+20*zhu;
         }
         }
         
         if (win) {
         [display setText:@"win!"];
         }
         else [display setText:@"lose!"];
         NSLog(@"%d",j);
         */
        j=0;
        self.goButoon.enabled=YES;
        
    }
    else
        {for (int i=0; i<3; i++) {
            [self.picker selectRow:j inComponent:i animated:YES];
            [self.picker reloadComponent:i];
            self.goButoon.enabled=NO;
        }
    }
}



-(void)alertMess:(NSString *)mess
{
    NSLog(@"3个一样");
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                  message:mess
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    [alert show];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 1000;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    NSString *arrayName=[[NSString alloc] initWithFormat:@"column%d",component+1];
    NSArray *array=[self valueForKey:arrayName];
    return [array objectAtIndex:row%5];
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSMutableArray *strings = [NSMutableArray arrayWithCapacity:5];
    [strings addObject:@"Zero"];
    [strings addObject:@"One"];
    [strings addObject:@"Two"];
    [strings addObject:@"Three"];
    [strings addObject:@"Four"];
    return [strings objectAtIndex:(row%5)];
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 128;
    //return 60;
}

- (void)goView2
{
    ViewController2* viewController = [[ViewController2 alloc] init];
    UINavigationController *navigatitonController = [[UINavigationController alloc]initWithRootViewController:viewController];
    //	[self presentModalViewController:navigatitonController animated:YES];
    [self presentViewController:navigatitonController animated:YES completion:^{}];
}

- (void)goView3
{
    ViewController3* viewController = [[ViewController3 alloc] init];
    UINavigationController *navigatitonController = [[UINavigationController alloc]initWithRootViewController:viewController];
//	[self presentModalViewController:navigatitonController animated:YES];
    [self presentViewController:navigatitonController animated:YES completion:^{}];
}

- (void)goView4
{
    ViewController4* viewController = [[ViewController4 alloc] init];
    UINavigationController *navigatitonController = [[UINavigationController alloc]initWithRootViewController:viewController];
    //	[self presentModalViewController:navigatitonController animated:YES];
    [self presentViewController:navigatitonController animated:YES completion:^{}];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

