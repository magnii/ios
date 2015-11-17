//
//  StuProfileMyBBDetailDetailDetailTableCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/21.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileMyBBDetailDetailDetailTableCell.h"
#import "StuConfig.h"

#define myFontSize 14
#define myFontLitSize 12
#define cellH 80
#define cellPaddingH 5
#define cellBtnH 20
#define myBlueColor [UIColor colorWithRed:28/255.0 green:141/255.0 blue:213/255.0 alpha:1.0]

@implementation StuProfileMyBBDetailDetailDetailTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
//    static NSString *ID = @"StuProfileMyBBDetailDetailDetailTableCell";
//    StuProfileMyBBDetailDetailDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
        StuProfileMyBBDetailDetailDetailTableCell *cell = [[StuProfileMyBBDetailDetailDetailTableCell alloc]init];
        CGFloat labelW = screenFrame.size.width/4.0;
        UILabel *peopleL = [[UILabel alloc]init];
        [peopleL setFont:[UIFont systemFontOfSize:myFontLitSize]];
        peopleL.frame = CGRectMake(0, 0, labelW, cellH);
        peopleL.textAlignment = NSTextAlignmentCenter;
//        peopleL.text = one.oneOne.name;
        cell.peopleL = peopleL;
        [cell addSubview:peopleL];
        
        UILabel *telephoneL = [[UILabel alloc]init];
        [telephoneL setFont:[UIFont systemFontOfSize:myFontLitSize]];
        telephoneL.frame = CGRectMake(labelW, 0, labelW, cellH);
        telephoneL.textAlignment = NSTextAlignmentCenter;
//        telephoneL.text = one.oneOne.telephone;
        cell.telephoneL = telephoneL;
        [cell addSubview:telephoneL];
        
        UILabel *signUpDateL = [[UILabel alloc]init];
        [signUpDateL setFont:[UIFont systemFontOfSize:myFontLitSize]];
        signUpDateL.frame = CGRectMake(labelW*2, 0, labelW, cellH);
        signUpDateL.textAlignment = NSTextAlignmentCenter;
//        signUpDateL.text = one.oneOne.createDate;
        cell.signUpDateL = signUpDateL;
        [cell addSubview:signUpDateL];
        
        UIButton *hiredBtn = [[UIButton alloc]init];
        hiredBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [hiredBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:myFontLitSize]];
        [hiredBtn setTitle:@"录取" forState:UIControlStateNormal];
        [hiredBtn setTitle:@"取消" forState:UIControlStateSelected];
        [hiredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [hiredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [hiredBtn setBackgroundColor:myBlueColor];
        hiredBtn.frame = CGRectMake(labelW*3, cellPaddingH*2, labelW-cellPaddingH*2, cellBtnH);
        cell.hiredBtn = hiredBtn;
        [cell addSubview:hiredBtn];
        
        UIButton *checkSignUpBtn = [[UIButton alloc]init];
        checkSignUpBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [checkSignUpBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:myFontLitSize]];
        [checkSignUpBtn setTitle:@"查看签到" forState:UIControlStateNormal];
        [checkSignUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [checkSignUpBtn setBackgroundColor:myBlueColor];
        checkSignUpBtn.frame = CGRectMake(labelW*3, CGRectGetMaxY(hiredBtn.frame) + cellBtnH, labelW-cellPaddingH*2, cellBtnH);
        cell.checkSignUpBtn = checkSignUpBtn;
        [cell addSubview:checkSignUpBtn];
//    }
    return cell;
}
@end
