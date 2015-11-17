//
//  StuProfileWalletView.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/16.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ShowTypeIncome=0,
    ShowTypePay,
    ShowTypeRedPackage
} ShowType;

@protocol ProfileWalletDelegate <NSObject>

- (void)showTypeBtnDidClicked;

@end

@interface StuProfileWalletView : UIView
@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (weak, nonatomic) IBOutlet UILabel *pointsL;
@property (weak, nonatomic) IBOutlet UITextField *aliplyTextField;
@property (weak, nonatomic) IBOutlet UIButton *aliplyBtn;
- (IBAction)aliplyBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *txTextField;
- (IBAction)txBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *exchangePointTextField;
@property (weak, nonatomic) IBOutlet UIButton *exchangePointBtnClick;


- (IBAction)incomeBtnClick:(UIButton *)sender;
- (IBAction)payBtnClick:(UIButton *)sender;
- (IBAction)redPacketBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIButton *redPacketBtn;

@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;

@property(nonatomic, strong)NSArray *walletArray;
@property(nonatomic, assign)ShowType showType;

@property(nonatomic, weak)id<ProfileWalletDelegate>delegate;


+(instancetype)walletHeadFromNib;

@end
