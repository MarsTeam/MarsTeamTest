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


@interface ViewController ()
{
    int j;
    NSTimer *times;
    NSArray *column1;
    NSArray *column2;
    NSArray *column3;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"羊你改成你的名字");
    NSString *contents = @"您有一条未读的新消息";
    [self localNotification:contents];
    
    UIImage *image = [UIImage imageNamed:@"mars.jpg"];
    [self imageUpload:image];
    
    
    j = 0;
    CGRect pickerFrame = CGRectMake(0, 0, 260, 80);
    self.picker.frame = pickerFrame;
    
    UIImage *happy=[UIImage imageNamed:@"happy.png"];
    UIImage *gold=[UIImage imageNamed:@"redhat_games.png"];
    UIImage *santa=[UIImage imageNamed:@"sleeping_santaclaus.png"];
    UIImage *tsitter=[UIImage imageNamed:@"tsitter_square_sleeping.png"];
    UIImage *monkey=[UIImage imageNamed:@"face_monkey.png"];
    

    
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
    
    times=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(function) userInfo:nil repeats:YES];
    
    
    
}


-(void)function
{
    j++;
    if(j%100==0)
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
            NSLog(@"3个一样");
        }
        else if(firstvalue%5==secondvalue%5||firstvalue%5==thirdvalue%5||secondvalue%5==thirdvalue%5)
        {
            NSLog(@"2个一样");
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
    //return 128;
    return 50;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

