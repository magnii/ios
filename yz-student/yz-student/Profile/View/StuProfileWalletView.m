//
//  StuProfileWalletView.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/16.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileWalletView.h"
#import "StuWalletInfo.h"
#import "MBProgressHUD+MJ.h"
#import "StuIncomeInfo.h"
#import "StuRedPackageInfo.h"
#import "StuRedPacketTableViewCell.h"

extern NSString *globalSessionId;
extern NSString *globalAlipayNum;

@implementation StuProfileWalletView

- (NSArray *)walletArray
{
    if (_walletArray == nil) {
        _walletArray = [NSArray array];
    }
    return _walletArray;
}

- (IBAction)aliplyBtnClick:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"点击修改"]) {
        [sender setTitle:@"点击保存" forState:UIControlStateNormal];
        self.aliplyTextField.enabled = YES;
    }
    if ([sender.titleLabel.text isEqualToString:@"点击保存"]) {
        [sender setTitle:@"点击修改" forState:UIControlStateNormal];
        self.aliplyTextField.enabled = NO;
        //提交支付宝数据
        [StuWalletInfo bindAlipayWithSessionId:globalSessionId AlipyNum:self.aliplyTextField.text];
        globalAlipayNum = self.aliplyTextField.text;
    }
    if ([sender.titleLabel.text isEqualToString:@"点击添加"]) {
        [sender setTitle:@"点击保存" forState:UIControlStateNormal];
        self.aliplyTextField.enabled = YES;
    }
}

- (IBAction)txBtnClick:(UIButton *)sender {
    
    if (globalAlipayNum == nil || globalAlipayNum.length == 0) {
        [MBProgressHUD showError:@"请先绑定支付宝"];
        return;
    }
    
    if (self.moneyL.text.doubleValue >= self.txTextField.text.doubleValue && self.txTextField.text.doubleValue >= 66.0) {
        [StuWalletInfo toCashWithSessionId:globalSessionId DealType:@"2" Amount:self.txTextField.text TradeNum:nil];
        self.moneyL.text = [NSString stringWithFormat:@"%d", (int)(self.moneyL.text.doubleValue-self.txTextField.text.doubleValue)];
        self.txTextField.text = nil;
    }
    else if(self.txTextField.text.doubleValue < 66.0)
    {
        [MBProgressHUD showError:@"提现金额不能小于66元"];
    }
    else
    {
        [MBProgressHUD showError:@"您的余额不够"];
    }
    
}
- (IBAction)exchangePointsBtnClick:(UIButton *)sender {
    
    if (self.pointsL.text.doubleValue >= self.exchangePointTextField.text.doubleValue && self.exchangePointTextField.text.doubleValue >= 80) {
        [StuWalletInfo exchangePointWithSessionId:globalSessionId Points:self.exchangePointTextField.text];
        self.pointsL.text = [NSString stringWithFormat:@"%lld", self.pointsL.text.longLongValue - self.exchangePointTextField.text.longLongValue];
        self.moneyL.text = [NSString stringWithFormat:@"%d", (int)(self.moneyL.text.doubleValue+self.exchangePointTextField.text.doubleValue/10.0)];
        self.exchangePointTextField.text = nil;
    }
    else if(self.exchangePointTextField.text.doubleValue < 80)
    {
        [MBProgressHUD showError:@"您兑换的积分不能小于80个"];
    }
    else
    {
        [MBProgressHUD showError:@"您的积分不够"];
    }
}


- (IBAction)incomeBtnClick:(UIButton *)sender {
    if (sender.selected == NO) {
        self.showType = ShowTypeIncome;
        [sender setSelected:YES];
        [self.payBtn setSelected:NO];
        [self.redPacketBtn setSelected:NO];
        
        self.walletArray = [StuIncomeInfo incomeWithSessionId:globalSessionId DealType:@"3" CurrentPage:@"0" PageSize:@"20"];
        
        if ([self.delegate respondsToSelector:@selector(showTypeBtnDidClicked)]) {
            [self.delegate showTypeBtnDidClicked];
        }
    }
}

- (IBAction)payBtnClick:(UIButton *)sender {
    if (sender.selected == NO) {
        self.showType = ShowTypePay;
        [sender setSelected:YES];
        [self.incomeBtn setSelected:NO];
        [self.redPacketBtn setSelected:NO];
        self.walletArray = [StuIncomeInfo incomeWithSessionId:globalSessionId DealType:@"2" CurrentPage:@"0" PageSize:@"20"];
        
        if ([self.delegate respondsToSelector:@selector(showTypeBtnDidClicked)]) {
            [self.delegate showTypeBtnDidClicked];
        }
    }
}

- (IBAction)redPacketBtnClick:(UIButton *)sender {
    if (sender.selected == NO) {
        self.showType = ShowTypeRedPackage;
        [sender setSelected:YES];
        [self.payBtn setSelected:NO];
        [self.incomeBtn setSelected:NO];
        
        self.walletArray = [StuRedPackageInfo redPackageWithSessionId:globalSessionId CurrentPage:@"0" PageSize:@"20"];
        
        if ([self.delegate respondsToSelector:@selector(showTypeBtnDidClicked)]) {
            [self.delegate showTypeBtnDidClicked];
        }
    }
}

+ (instancetype)walletHeadFromNib
{
    StuProfileWalletView *profileView = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileWalletView" owner:nil options:nil]lastObject];
    return profileView;
}

@end
