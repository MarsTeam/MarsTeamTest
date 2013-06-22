//
//  ViewController2.m
//  TEST2
//
//  Created by Mars on 13-6-5.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import "ViewController2.h"
#import "MarsCell.h"
#import "DuduCell.h"

@interface ViewController2 ()
{
    NSDictionary *countLitsDic;
    NSDictionary *nameDic;
    NSArray *keys;
    UIImageView *img;
}
//-(void)Onback;
@end

@implementation ViewController2

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
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(Onback)];
    
    
    
    
    NSArray *accountArray = [NSArray arrayWithObjects:@"abc",nil];
    NSArray *shareArray = [NSArray arrayWithObjects:@"a",nil];
//    NSArray *shareArray = [NSArray arrayWithObjects:@"a",@"b", @"c",@"d",@"e",@"f",@"g", @"h",@"i",@"j",@"h",@"i",@"j",@"h",@"i",@"j",nil];
    //NSArray *aboutArray = [NSArray arrayWithObjects:@"a",@"b", @"c",@"d",@"e",@"f",@"g",nil];
    

    countLitsDic = [NSDictionary dictionaryWithObjectsAndKeys:accountArray,@"0", shareArray,@"1",nil];
    
    keys = [[countLitsDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    
    nameDic = [NSDictionary dictionaryWithObjectsAndKeys:@"账号设置",@"0",@"其他",@"1",nil];
    
    UITableView  *listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 120) style:UITableViewStylePlain];
    
    listTable.backgroundColor = [UIColor whiteColor];
    listTable.dataSource = self;
    listTable.delegate = self;
    listTable.backgroundView = nil;
    [listTable setBackgroundColor:[UIColor clearColor]];
    //[listTable setSeparatorColor:[UIColor clearColor]];
    [listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:listTable];
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [keys count];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [countLitsDic objectForKey:key];
    return  [nameSection count];
}




//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    NSUInteger section = [indexPath section];
//    NSUInteger row = [indexPath row];
//    
//   
//
//    NSString *key = [keys objectAtIndex:section];
//    NSArray *nameSection = [countLitsDic objectForKey:key];
//    
//    
//    static NSString *sectionsTableIdentifier = @"sectionsTableIdentifier";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier];
//
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionsTableIdentifier];
//            if ([[nameSection objectAtIndex:row] isEqualToString:@"abc"]) {
//
//                cell.imageView.image = [UIImage imageNamed:@"photo_bac@2x.png"];
//            }
//    }
//    
//    NSLog(@"section:%d:%d",indexPath.section,indexPath.row);
//    
////    if ([[nameSection objectAtIndex:row] isEqualToString:@"abc"]) {
//////        img = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,100)];
//////        img.image = [UIImage imageNamed:@"photo_bac@2x.png"];
////        cell.imageView.image = [UIImage imageNamed:@"photo_bac@2x.png"];
////    }else{
////        cell.textLabel.text = [nameSection objectAtIndex:row];
////    }
//
//    
//
//    cell.textLabel.text = [nameSection objectAtIndex:row];
//
//    //cell.imageView.image = [UIImage imageNamed:@"photo_bac@2x.png"];
//    
//    return cell;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"CustomCellIdentifier";
        MarsCell *cell = (MarsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MarsCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            
        }
        return cell;
    }else{
        NSUInteger section = [indexPath section];
        NSUInteger row = [indexPath row];
        
        NSString *key = [keys objectAtIndex:section];
        NSArray *nameSection = [countLitsDic objectForKey:key];        

        static NSString *DuduCellIdentifier = @"DuduCellIdentifier";
        DuduCell *cell = (DuduCell *)[tableView dequeueReusableCellWithIdentifier:DuduCellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DuduCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            
        }
        cell.titleLable.text = [nameSection objectAtIndex:row];
        cell.DetailLable.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
        return cell;
        
    }
    

	//[[MarsCell lable] setText:@"你好"];
	//[[cell imageView] setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:indexPath.row]]];
	//[[cell nameLabel] setText:[nameArray objectAtIndex:indexPath.row]];
	//return cell;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//    NSString *key = [keys objectAtIndex:section];
//    NSLog(@"header!!a!");
//    return key;
//}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 50;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *key = [keys objectAtIndex:section];
    
//    NSString *bb  = [nameDic objectForKey:key];
//    
//    if (section == 0) {
//        return @"";
//    }
    
    //return key;
    
    if (section == 0) {
        return 0;
    }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];//创建一个视图
        
        UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        
        UIImage *image = [UIImage imageNamed:@"left_white@2x.png"];
        
        [headerImageView setImage:image];
        
        [headerView addSubview:headerImageView];
        
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, 150, 20)];
        
        headerLabel.backgroundColor = [UIColor clearColor];
        
        headerLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        headerLabel.textColor = [UIColor whiteColor];
        
        headerLabel.text = @"我关注的微博";
        [headerView addSubview:headerLabel];
        //headerView.hidden = YES;
        return headerView;
    }
 
}

//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return keys;
//
//}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    NSUInteger section = [indexPath section];
//    NSUInteger row = [indexPath row];
//    
//    NSString *key = [keys objectAtIndex:section];
//    NSArray *nameSection = [countLitsDic objectForKey:key];
//
//    // 這裏返回需要的高度
//    if ([[nameSection objectAtIndex:row] isEqualToString:@"abc"]) {
//        return 100;
//    }
//    return 50;
    
    if (indexPath.section == 0) {
        return 130;
    }else{
        return 530;
    }
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    NSLog(@"didScroll");
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    NSLog(@"DidEndDragging");

}

@end
