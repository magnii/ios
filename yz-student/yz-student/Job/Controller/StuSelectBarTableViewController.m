//
//  StuSelectBarTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/13.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuSelectBarTableViewController.h"
#define cellH 30

@interface StuSelectBarTableViewController ()

@end

@implementation StuSelectBarTableViewController

- (NSString *)selectItem
{
    if (_selectItem == nil) {
        _selectItem = [NSString string];
    }
    return _selectItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"StuSelectBarTableViewCell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.textLabel.text = self.itemsArray[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    
    cell.backgroundColor = [UIColor colorWithRed:51/255.0 green:179/255.0 blue:226/255.0 alpha:0.8];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.view.hidden = YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectItem = self.itemsArray[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(loadNewJobsWithSelectedItem:)]) {
        [self.delegate loadNewJobsWithSelectedItem:self.selectItem];
    }
}

@end
