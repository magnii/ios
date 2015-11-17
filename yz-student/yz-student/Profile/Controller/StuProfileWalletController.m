//
//  testViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/16.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileWalletController.h"
#import "StuProfileWalletView.h"
#import "StuWalletInfo.h"
#import "StuConfig.h"
#import "StuIncomeInfo.h"
#import "StuIncomePayTableViewCell.h"
#import "StuRedPacketTableViewCell.h"
#import "StuRedPackageInfo.h"

#define cellH 34
#define walletHeadH 260

extern NSString *globalSessionId;

@interface StuProfileWalletController ()<UITableViewDataSource, UITableViewDelegate, ProfileWalletDelegate>

@property(nonatomic, strong)StuProfileWalletView *walletHeadView;
@property(nonatomic, strong)UITableView *walletTableView;

@end

@implementation StuProfileWalletController

- (UITableView *)walletTableView
{
    if (_walletTableView == nil) {
        _walletTableView = [[UITableView alloc]init];
    }
    return _walletTableView;
}

- (StuProfileWalletView *)walletHeadView
{
    if (_walletHeadView == nil) {
        _walletHeadView = [StuProfileWalletView walletHeadFromNib];
    }
    return _walletHeadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    
    StuWalletInfo *walletInfo = [StuWalletInfo remainMoneyWithSessionId:globalSessionId];
    if (walletInfo.money == nil || [walletInfo.money isEqualToString:@""]) {
        self.walletHeadView.moneyL.text = @"0.00";
    }
    else
    {
        self.walletHeadView.moneyL.text = walletInfo.money;
    }
    
    self.walletHeadView.pointsL.text = [NSString stringWithFormat:@"%ld", walletInfo.points];
    self.walletHeadView.aliplyTextField.text = walletInfo.alipayNum;
    self.walletHeadView.aliplyTextField.enabled = NO;
    if (walletInfo.alipayNum == nil || [walletInfo.alipayNum isEqualToString:@""]) {
        [self.walletHeadView.aliplyBtn setTitle:@"点击添加" forState:UIControlStateNormal];
    }
    else
    {
        [self.walletHeadView.aliplyBtn setTitle:@"点击修改" forState:UIControlStateNormal];
    }
    
    [self.view addSubview:self.walletHeadView];
    self.walletHeadView.frame = CGRectMake(0, 64, screenFrame.size.width, walletHeadH);
    self.walletHeadView.delegate = self;
    [self.walletHeadView incomeBtnClick:self.walletHeadView.incomeBtn];
    
    //去掉没有数据的表格的分割线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.walletTableView setTableFooterView:view];
    
    self.walletTableView.delegate = self;
    self.walletTableView.dataSource = self;
    
    self.walletTableView.frame = CGRectMake(0, CGRectGetMaxY(self.walletHeadView.frame), screenFrame.size.width, screenFrame.size.height-walletHeadH-64);
    [self.view addSubview:self.walletTableView];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(commentsTextViewDismissKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
}


- (void)commentsTextViewDismissKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.walletHeadView.walletArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.walletHeadView.showType == ShowTypeRedPackage) {
        return 120;
    }
    else
    {
        return cellH;
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.walletHeadView.showType == ShowTypeIncome || self.walletHeadView.showType == ShowTypePay) {
        StuIncomePayTableViewCell *cell = [StuIncomePayTableViewCell cellFromNibWithTableView:tableView];
        
        StuIncomeInfo *incomeInfo = self.walletHeadView.walletArray[indexPath.row];
        cell.moneyL.text = incomeInfo.amount;
        if (self.walletHeadView.showType == ShowTypeIncome) {
            [cell.moneyL setTextColor:[UIColor colorWithRed:51/255.0 green:153/255.0 blue:0.0 alpha:1]];
        }
        else
        {
            [cell.moneyL setTextColor:[UIColor redColor]];
        }
        
        cell.createTimeL.text = incomeInfo.createTime;
        cell.dealTypeL.text = incomeInfo.dealType;
        
//        if (indexPath.row > self.walletHeadView.walletArray.count) {
//            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 10000000)];
//        }
        
        return cell;
    }
    else
    {
        StuRedPacketTableViewCell *cell = [StuRedPacketTableViewCell cellFromNibWithTableView:tableView];
        StuRedPackageInfo *packageInfo = self.walletHeadView.walletArray[indexPath.row];
        
        cell.timeL.text = packageInfo.createTime;
        cell.contentL.text = packageInfo.desc;
        cell.redPackageId = packageInfo.redPackageId;
        if ([packageInfo.received isEqualToString:@"0"]) {
            [cell.gotBtn setTitle:@"领取红包" forState:UIControlStateNormal];
        }
        else
        {
            [cell.gotBtn setTitle:@"已领取" forState:UIControlStateNormal];
            cell.gotBtn.enabled = NO;
        }
        [cell.redPackageBtn setTitle:[NSString stringWithFormat:@"%d", packageInfo.money] forState:UIControlStateNormal];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma ProfileShowTypeDelegate
- (void)showTypeBtnDidClicked
{
    [self.walletTableView reloadData];
}

@end
