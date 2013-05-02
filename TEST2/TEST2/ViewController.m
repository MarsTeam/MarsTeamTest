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
     NSLog(@"zhang1989sh !!!");
    NSLog(@"这次谁该 !!!");
    NSLog(@"家里air改一下 !!!");
    NSString *contents = @"marf";
    [self localNotification:contents];
    
    
    
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
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)localNotification:(NSString *)contents{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:1];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1;
        notification.alertBody=contents;
        notification.alertAction = @"打开";
        NSLog(@"heh:%@",contents);
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
}


-(void)loadImage:(NSString*)aurl
{
    NSData              *imageData;
    NSMutableData       *postBody;
    NSString            *stringBoundary, *contentType;
    NSURL *url = [NSURL URLWithString:aurl];  //将字符串转换为NSURL格式
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"1.jpg"];
    
    imageData = [[NSData alloc] initWithContentsOfFile:path];
    
    ASIFormDataRequest *aRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    
    //stringBoundary = [NSString stringWithString:@"0xKhTmLbOuNdArY"];
    stringBoundary = @"0xKhTmLbOuNdArY";
    
    contentType    = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    
    [aRequest addRequestHeader:@"Content-Type" value:contentType];
    
    postBody = [[NSMutableData alloc] init];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
//    [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[@"Content-Disposition: form-data; name=\"title\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
//    [postBody appendData:[[NSString stringWithString:@"lighttable"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[@"lighttable" dataUsingEncoding:NSUTF8StringEncoding]];
    // So Light Table show up as source in Twitter post
    
    NSString *imageFileName = [NSString stringWithFormat:@"photo.jpeg"];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"upload\"; filename=\"%@\"\r\n",imageFileName] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:imageData];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
//    [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[@"Content-Disposition: form-data; name=\"password\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [postBody appendData:[@"lighttablexxxxxxxx" dataUsingEncoding:NSUTF8StringEncoding]];
    
//    [postBody appendData:[[NSString stringWithString:@"lighttablexxxxxxxx"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [aRequest setDelegate:self];
    
    [aRequest appendPostData:postBody];
    
    [aRequest setRequestMethod:@"POST"];
    
    [aRequest startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

