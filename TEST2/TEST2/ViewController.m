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
    
    //NSString *aurl = @"http://localhost/host/upload_file.php";
    //[self loadImage:aurl];
    
    [self uploadImage];
    
	// Do any additional setup after loading the view, typically from a nib.
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


-(void)loadImage:(NSString*)aurl
{
    NSData              *imageData;
    NSMutableData       *postBody;
    NSString            *stringBoundary, *contentType;
    NSURL *url = [NSURL URLWithString:aurl];  //将字符串转换为NSURL格式
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"mars.jpeg"];
    
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
    
    NSString *imageFileName = [NSString stringWithFormat:@"mars.jpeg"];
    
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


- (IBAction)uploadImage {
    /*
     turning the image into a NSData object
     getting the image back out of the UIImageView
     setting the quality to 90
     */
//    UIImage *myImage = [UIImage imageNamed:@"mars.jpg"];
//    
//    NSData *imageData = UIImageJPEGRepresentation(myImage, 1.0);
    
    
    //UIImage *m_imgFore=[UIImage imageNamed:@"mars.jpg"];;
    //png格式
    //NSData *imageData=UIImagePNGRepresentation(m_imgFore);
    //JEPG格式
    //NSData *imageData=UIImageJPEGRepresentation(m_imgFore,1.0);
    
    UIImage *image = [UIImage imageNamed:@"mars.jpg"];
    
    NSData *imageData= UIImageJPEGRepresentation(image, 0.5);
    
    
//    UIImage *img = [UIImage imageNamed:@"some.png"];
//    NSData *dataObj = UIImageJPEGRepresentation(img, 1.0);
    
    
    // setting up the URL to post to
    //NSString *urlString = @"http://www.ccbase.net/test-upload.php";
    NSString *urlString = @"http://localhost/host/upload_file.php";
    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    /*
     add some header info now
     we always need a boundary when we post a file
     also we need to set the content type
     
     You might want to generate a random boundary.. this is just the same
     as my output from wireshark on a valid html post
     */
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"rn--%@rn",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\"rn" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-streamrnrn" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"rn--%@--rn",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnString:%@",returnString);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

