//
//  DuduCell.m
//  TEST2
//
//  Created by Mars on 13-6-7.
//  Copyright (c) 2013年 张 炜超. All rights reserved.
//

#import "DuduCell.h"

@interface DuduCell()
{

    NSArray *array;
    UITableView  *listTable;
}

@end

@implementation DuduCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

    }
    
    NSLog(@"HEHE jinlail ma ");
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (!listTable) {
        array = [[NSArray alloc] initWithObjects:@"Sleepu",@"Bashful",@"DOC",@"Sleepu",@"Bashful",@"DOC",@"Sleepu",@"Bashful",@"DOC",@"Sleepu",@"Bashful",@"DOC",@"Sleepu",@"Bashful",@"DOC",@"Sleepu",@"Bashful",@"DOC",@"Sleepu",@"Bashful",@"DOC",@"Sleepu",@"Bashful",@"DOC", nil];
        // Initialization code
        listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 500) style:UITableViewStylePlain];
        
        listTable.backgroundColor = [UIColor whiteColor];
        listTable.dataSource = self;
        listTable.delegate = self;
        listTable.backgroundView = nil;
        listTable.scrollEnabled = NO;
        [listTable setBackgroundColor:[UIColor whiteColor]];
        //[listTable setSeparatorColor:[UIColor clearColor]];
        [listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self addSubview:listTable];
    }

    NSLog(@"HEHE xuanzhong ne ");
    // Configure the view for the selected state
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *Simpltable = @"Simpltable";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Simpltable];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Simpltable];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [array objectAtIndex:row];
    return cell;
}


@end
