//
//  ViewController3.m
//  TEST2
//
//  Created by Mars on 13-6-9.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import "ViewController3.h"
#import "tableSectionBar.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController3 ()
{
    UIScrollView *scrollview;
    UIView *viewTop;
    UIView *viewBlack;
    tableSectionBar *tableBar;
    
    
    NSArray *firstArray;
    NSArray *secondArray;
    NSArray *thirdArray;
    
    UITableView *tableViewFirst;
    UITableView *tableViewSecond;
    UITableView *tableViewThird;
    
    UIButton *leftButton;
    UIButton *centerButton;
    UIButton *rightButton;
    
    
    UIView *marsView;
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(Onback)];
    
    
    self.view.layer.cornerRadius = 20.0;
    self.view.layer.backgroundColor = [UIColor purpleColor].CGColor;
    
    firstArray = [NSArray arrayWithObjects:@"a",@"b", @"c",@"d",@"e",@"f",@"g", @"h",@"i",@"j",@"h",@"i",@"j",@"h",@"i",@"j",nil];
    secondArray = [NSArray arrayWithObjects:@"1",@"2", @"3",@"4",@"5",@"6",@"7",@"8",@"9", @"10",@"11",@"12",nil];
    thirdArray = [NSArray arrayWithObjects:@"a1",@"b2", @"c3",@"d4",@"e5", @"f3",nil];
    float aa = self.view.frame.size.height;
    NSLog(@"aa:%f",aa);
    
    scrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,418)];
    scrollview.contentSize=CGSizeMake(320,1000);
    scrollview.backgroundColor=[UIColor whiteColor];
    //scrollview.pagingEnabled=YES;//是否自己动适应
    
    
//    UIImageView *viewImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
//    viewImg.image = [UIImage imageNamed:@"photo_bac@2x.png"];
//    viewImg.layer.borderWidth = 3;
//    viewImg.layer.borderColor = [[UIColor blackColor] CGColor];
//    viewImg.layer.cornerRadius = 20;
//    [scrollview addSubview:viewImg];
    
    
    CALayer *imagerLaye = [CALayer layer];
    imagerLaye.frame = CGRectMake(0, 0, 320, 200);
    imagerLaye.backgroundColor = [[UIColor blackColor] CGColor];
    //imagerLaye.cornerRadius = 20.0;
    imagerLaye.contents = (id)[UIImage imageNamed:@"photo_bac@2x.png"].CGImage;
    imagerLaye.masksToBounds = YES;
    [scrollview.layer addSublayer:imagerLaye];
    
    
    
   
    
    
    tableBar = [[tableSectionBar alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    tableBar.delegate = self;
    
    
    viewBlack = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 320, 60)];
    [viewBlack addSubview:tableBar];
    [scrollview addSubview:viewBlack];
    
    
    

    
    
    
    tableViewFirst = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, 320, 1000)];
    tableViewFirst.delegate = self;
    tableViewFirst.dataSource = self;
    tableViewFirst.scrollEnabled = NO;
    tableViewFirst.hidden = NO;
    [scrollview addSubview:tableViewFirst];
    
    
    tableViewSecond = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, 320, 1000)];
    tableViewSecond.delegate = self;
    tableViewSecond.dataSource = self;
    tableViewSecond.scrollEnabled = NO;
    tableViewSecond.hidden = YES;
    [scrollview addSubview:tableViewSecond];
    
    
    tableViewThird = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, 320, 1000)];
    tableViewThird.delegate = self;
    tableViewThird.dataSource = self;
    tableViewThird.scrollEnabled = NO;
    tableViewThird.hidden = YES;
    [scrollview addSubview:tableViewThird];
    

    scrollview.layer.backgroundColor = [UIColor blackColor].CGColor;
    scrollview.layer.cornerRadius = 20.0;
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
    
    
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    viewTop.hidden = YES;
    [self.view addSubview:viewTop];


    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView2
{
    
   //NSLog(@"y:%f",scrollView.contentOffset.y);

    if (scrollView2.contentOffset.y>200) {
        
        [viewTop removeFromSuperview];
        //viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        [viewTop addSubview:tableBar];
        viewTop.hidden = NO;
        [self.view addSubview:viewTop];

        //self.barUiew2.frame = CGRectMake(0,126,320,52);
    }else{
        
        [viewBlack removeFromSuperview];
        //viewBlack = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 320, 60)];
        [viewBlack addSubview:tableBar];
        viewTop.hidden = YES;
        [scrollview addSubview:viewBlack];
    }
}
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (tableView == tableViewFirst) {
        return [firstArray count];
    }else if(tableView == tableViewSecond){
        return [secondArray count];
    
    }else if(tableView == tableViewThird){
        return [thirdArray count];
    }else{
        return 0;
    }
    
    
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//  
//    
//    if (tableView == tableViewFirst) {
//        return [firstArray count];
//    }else if(tableView == tableViewSecond){
//        return [secondArray count];
//        
//    }else if(tableView == tableViewThird){
//        return [thirdArray count];
//    }else{
//        return 0;
//    }
//    
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    NSInteger row = [indexPath row];
    if (tableView == tableViewFirst) {
        static NSString *FirstTableIdentifier = @"FirstTableIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstTableIdentifier];
        }
        cell.textLabel.text = [firstArray objectAtIndex:row];
        return cell;
        
    }else if(tableView == tableViewSecond){
        static NSString *SecondTableIdentifier = @"SecondTableIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SecondTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SecondTableIdentifier];
        }
        cell.textLabel.text = [secondArray objectAtIndex:row];
        return cell;
        
    }else if(tableView == tableViewThird){
        static NSString *ThirdTableIdentifier = @"ThirdTableIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThirdTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ThirdTableIdentifier];
        }
        cell.textLabel.text = [thirdArray objectAtIndex:row];
        return cell;
    }
    
}


-(void)ButtonInAction:(id)sender
{
    UIButton *button = sender;
    switch (button.tag) {
        case 0:

            
            tableViewFirst.hidden = NO;
            tableViewSecond.hidden = YES;
            tableViewThird.hidden = YES;
            break;
        case 1:
            

            
            tableViewFirst.hidden = YES;
            tableViewSecond.hidden = NO;
            tableViewThird.hidden = YES;
            break;
        case 2:
            
            
            tableViewFirst.hidden = YES;
            tableViewSecond.hidden = YES;
            tableViewThird.hidden = NO;
            break;
        default:
            break;
    }
    
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
