//
//  SjProfileMyDocViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/30.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjProfileMyDocViewController.h"
#import "SjUserDoc.h"
#import "UIImageView+WebCache.h"
#import "SjCardIdPath.h"

extern NSString *sjGlobalSessionId;

@interface SjProfileMyDocViewController ()

@end

@implementation SjProfileMyDocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    
    SjUserDoc *doc = [SjUserDoc sjUserDocWithSessionId:sjGlobalSessionId];
    self.companyNameL.text = doc.name;
    self.companyContactP.text = doc.contactPerson;
    self.companyindustryL.text = doc.industry;
    self.companyPeoplesL.text = doc.scale;
    self.companyTypeL.text = doc.type;
    self.companyContactTL.text = doc.contactNumber;
    self.companyAddrL.text = doc.address;
    self.companyAttrL.text = doc.attribute;
    self.companyEmailL.text = doc.email;
    self.companyLicenseL.text = doc.licenseIdStatus;
    self.companyIDL.text = doc.cardIdStatus;
    self.companyInfoTextView.text = doc.brifIntrodution;
    [self.companyLicenseImg sd_setImageWithURL:[NSURL URLWithString:doc.licenseImage] placeholderImage:[UIImage imageNamed:@"icon_empty"]];
    [self.companyIDImgOne sd_setImageWithURL:[NSURL URLWithString:doc.cardOne.cardImagePath] placeholderImage:[UIImage imageNamed:@"icon_empty"]];
    [self.companyIDImgTwo sd_setImageWithURL:[NSURL URLWithString:doc.cardTwo.cardImagePath] placeholderImage:[UIImage imageNamed:@"icon_empty"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
