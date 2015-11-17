//
//  StuManualSelLocationTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/4.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuManualSelLocationTableViewController.h"

@interface StuManualSelLocationTableViewController ()

@property(nonatomic, strong)NSDictionary *citys;
@property(nonatomic, strong)NSArray *keys;

@end

@implementation StuManualSelLocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"城市选择";
    //self.navigationItem.leftBarButtonItem = nil;
    //[self.navigationItem setHidesBackButton:YES];
    self.navigationItem.rightBarButtonItem = nil;
}

- (NSDictionary *)citys
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    _citys = [[NSDictionary alloc]
                   initWithContentsOfFile:path];
    return _citys;
}

- (NSArray *)keys
{
    _keys = [[self.citys allKeys] sortedArrayUsingSelector:
                 @selector(compare:)];
    return _keys;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *key = [self.keys objectAtIndex:section];
    NSArray *citySection = [self.citys objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CityTableViewCell";
    
    NSString *KeysName = [self.keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = [[self.citys objectForKey:KeysName] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.keys objectAtIndex:section];
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    return 12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *KeysName = [self.keys objectAtIndex:indexPath.section];
    NSString *city = [[self.citys objectForKey:KeysName] objectAtIndex:indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(setLocationCity:)]) {
        [self.delegate setLocationCity:city];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
