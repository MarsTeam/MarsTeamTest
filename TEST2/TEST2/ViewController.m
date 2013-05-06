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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

