//
//  StuSystemInfoTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/14.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuSystemInfoTableViewController.h"
#import "StuSystemInfo.h"
#import "StuSystemInfoTableViewCell.h"
#import "StuConfig.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface StuSystemInfoTableViewController ()

@property(nonatomic, strong)NSArray *systemInfoArray;

@end

@implementation StuSystemInfoTableViewController

- (NSArray *)systemInfoArray
{
    if (_systemInfoArray == nil) {
        _systemInfoArray = [NSArray array];
    }
    return _systemInfoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.systemInfoArray = [StuSystemInfo getSystemInfoWithInfoType:@"isSys=1"];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor clearColor];
            self.tableView.tableFooterView = view;
            [self.tableView reloadData];
        });
    });
    
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
    return self.systemInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuSystemInfo *systemInfo = self.systemInfoArray[indexPath.row];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:12];
    CGFloat cellH = [systemInfo.content boundingRectWithSize:CGSizeMake(screenFrame.size.width-48, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    return cellH+4*3+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StuSystemInfoTableViewCell *cell = [StuSystemInfoTableViewCell cellFromNibWithTableView:tableView];
    //cell.cellContentL.adjustsFontSizeToFitWidth = YES;
    StuSystemInfo *systemInfo = self.systemInfoArray[indexPath.row];
    
    cell.cellContentL.text = systemInfo.content;
    cell.cellTimeL.text = systemInfo.createTime;
    if ([systemInfo.isRead isEqualToString:@"1"]) {
        [cell.cellBtn setSelected:YES];
        cell.cellReadL.text = @"已读";
        cell.cellReadL.font = [UIFont systemFontOfSize:12];
        cell.cellTimeL.font = [UIFont systemFontOfSize:12];
    }
    else
    {
        [cell.cellBtn setSelected:NO];
        cell.cellReadL.text = @"未读";
        cell.cellReadL.font = [UIFont boldSystemFontOfSize:12];
        cell.cellTimeL.font = [UIFont boldSystemFontOfSize:12];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuSystemInfo *systemInfo = self.systemInfoArray[indexPath.row];
    if (systemInfo.isRead == nil || [systemInfo.isRead isEqualToString:@"0"]) {
        systemInfo.isRead = @"1";
        [tableView reloadData];
        
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 2.拼接请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = systemInfo.infoId;
        [mgr POST:[NSString stringWithFormat:@"%@/weChat/notice/updateRead", serverIp] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
