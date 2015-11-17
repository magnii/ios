//
//  StuProfileMyPreSalaryViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/8.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileMyPreSalaryViewController.h"
#import "StuPreSalaryInfo.h"
#import "StuPreSalaryContentTableViewCell.h"
#import "StuPreSalaryHeadView.h"
#import "StuConfig.h"

extern NSString *globalSessionId;

@interface StuProfileMyPreSalaryViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *preSalaryTableView;
@property(nonatomic, strong)NSArray *preSalaryArry;

@end

@implementation StuProfileMyPreSalaryViewController

- (NSArray *)preSalaryArry
{
    if (_preSalaryArry == nil) {
        _preSalaryArry = [NSArray array];
    }
    return _preSalaryArry;
}

- (UITableView *)preSalaryTableView
{
    if (_preSalaryTableView == nil) {
        _preSalaryTableView = [[UITableView alloc]init];
    }
    return _preSalaryTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预支";
    
    self.preSalaryArry = [StuPreSalaryInfo preSalaryInfoWithSessionId:globalSessionId];
    [self setHeadView];
}

- (void)setHeadView
{
    StuPreSalaryHeadView *headView = [StuPreSalaryHeadView headViewFromNib];
    headView.frame = CGRectMake(0, 64, screenFrame.size.width, 30);
    [self.view addSubview:headView];
    
    self.preSalaryTableView.frame = CGRectMake(0, CGRectGetMaxY(headView.frame), screenFrame.size.width, screenFrame.size.height - headView.frame.size.height);
    self.preSalaryTableView.delegate = self;
    self.preSalaryTableView.dataSource = self;
    [self.view addSubview:self.preSalaryTableView];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.preSalaryTableView setTableFooterView:view];
}

#pragma tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.preSalaryArry.count;
}

- (UITableViewCell*)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    StuPreSalaryInfo *info = self.preSalaryArry[indexPath.row];
    StuPreSalaryContentTableViewCell *cell = [StuPreSalaryContentTableViewCell cellWithTableView:tableView];
    
    cell.dateL.text = [info.date substringToIndex:10];
    cell.moneyL.text = [NSString stringWithFormat:@"%d", (int)info.money];
    cell.stateL.text = [info.status isEqualToString:@"0"] ?@"申请中":@"成功";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
