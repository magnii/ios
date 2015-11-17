//
//  StuProfileMyInfoTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/18.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyInfoTableViewController.h"
#import "StuProfileMyInfo.h"
#import "StuProfileMyInfoTableViewCell.h"
#import "StuConfig.h"

#define cellH 145
#define textFontSize 14

extern NSString *globalSessionId;

@interface StuProfileMyInfoTableViewController ()

@property(nonatomic, strong)NSArray *myInfoArray;

@end

@implementation StuProfileMyInfoTableViewController

- (NSArray *)myInfoArray
{
    if (_myInfoArray == nil) {
        _myInfoArray = [NSArray array];
    }
    return _myInfoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的消息";
    
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.myInfoArray = [StuProfileMyInfo myInfoWithSessionId:globalSessionId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuProfileMyInfo *info = self.myInfoArray[indexPath.row];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:textFontSize];
    CGFloat contentH = [info.content boundingRectWithSize:CGSizeMake(screenFrame.size.width-125, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    
    return contentH+17*2+25+25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StuProfileMyInfoTableViewCell *cell = [StuProfileMyInfoTableViewCell cellFromNibWithTableView:tableView];
    
    StuProfileMyInfo *info = self.myInfoArray[indexPath.row];
    if ([info.isRead isEqualToString:@"1"]) {
        [cell.infoLeftBtn setSelected:YES];
        [cell.infoMidBtn setSelected:YES];
        cell.infoRightTextView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
        cell.infoRightTextView.textColor = [UIColor blackColor];
    }
    else
    {
        [cell.infoLeftBtn setSelected:NO];
        [cell.infoMidBtn setSelected:NO];
        cell.infoRightTextView.backgroundColor = [UIColor colorWithRed:248/255.0 green:88/255.0 blue:12/255.0 alpha:1];
    }
    
    cell.infoRightTextView.text = [NSString stringWithFormat:@"%@\n%@", info.createTime, info.content];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StuProfileMyInfoTableViewCell *cell = (StuProfileMyInfoTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.infoLeftBtn setSelected:YES];
    [cell.infoMidBtn setSelected:YES];
    cell.infoRightTextView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    cell.infoRightTextView.textColor = [UIColor blackColor];
}

@end
