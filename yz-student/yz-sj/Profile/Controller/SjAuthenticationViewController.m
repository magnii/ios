//
//  SjAuthenticationViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/2.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjAuthenticationViewController.h"
#import "SjProfileAuthenticationView.h"
#import "StuConfig.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "SjUserDoc.h"
#import "UIImageView+WebCache.h"
#import "SjCardIdPath.h"

#define sjAuthScrollViewH 700

extern NSString *sjGlobalSessionId;

typedef enum
{
    FirstIdCardBtn = 0,
    SecondIdCardBtn,
    BussinessLicenseBtn
} SelectUploadBtn;

@interface SjAuthenticationViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, assign) SelectUploadBtn selectBtnType;
@property(nonatomic, strong) SjProfileAuthenticationView *uploadView;
@property(nonatomic, copy) NSString *identityDocId;
@property(nonatomic, copy) NSString *identityDocId2;
@property(nonatomic, copy) NSString *bussinessDocId;
@property(nonatomic, strong) UIScrollView *sjAuthScrollView;
@property(nonatomic, strong)SjUserDoc *userDoc;

@end

@implementation SjAuthenticationViewController

- (SjUserDoc *)userDoc
{
    if (_userDoc == nil) {
        _userDoc = [[SjUserDoc alloc]init];
    }
    return _userDoc;
}

- (UIScrollView *)sjAuthScrollView
{
    if (_sjAuthScrollView == nil) {
        _sjAuthScrollView = [[UIScrollView alloc]init];
    }
    return _sjAuthScrollView;
}

- (SjProfileAuthenticationView *)uploadView
{
    if (_uploadView == nil) {
        _uploadView = [SjProfileAuthenticationView viewFromNib];
        [_uploadView.idCardFrontBtn setTitle:@"上传身份证(正反面)" forState:UIControlStateNormal];
        [_uploadView.idCardBackBtn setTitle:@"上传身份证(正反面)" forState:UIControlStateNormal];
        [_uploadView.bussinesLicenseBtn setTitle:@"上传营业执照" forState:UIControlStateNormal];
    }
    
    return _uploadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家认证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.selectBtnType = 0;
    
    self.sjAuthScrollView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height);
    self.sjAuthScrollView.contentSize = CGSizeMake(screenFrame.size.width, sjAuthScrollViewH);
    [self.view addSubview:self.sjAuthScrollView];
    
    self.uploadView.frame = CGRectMake(0, 0, screenFrame.size.width, sjAuthScrollViewH);
    [self.sjAuthScrollView addSubview:self.uploadView];
    
    [self.uploadView.idCardFrontBtn addTarget:self action:@selector(chooseCameraOrAlbum:) forControlEvents:UIControlEventTouchDown];
    [self.uploadView.idCardBackBtn addTarget:self action:@selector(chooseCameraOrAlbum:) forControlEvents:UIControlEventTouchDown];
    [self.uploadView.bussinesLicenseBtn addTarget:self action:@selector(chooseCameraOrAlbum:) forControlEvents:UIControlEventTouchDown];
    
    [self.uploadView.idCardFrontBtn setTitle:@"点击上传身份证(正反面)" forState:UIControlStateNormal];
    [self.uploadView.idCardFrontBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.uploadView.idCardFrontBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    [self.uploadView.idCardBackBtn setTitle:@"点击上传身份证(正反面)" forState:UIControlStateNormal];
    [self.uploadView.idCardBackBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.uploadView.idCardBackBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    [self.uploadView.bussinesLicenseBtn setTitle:@"点击上传营业执照" forState:UIControlStateNormal];
    [self.uploadView.bussinesLicenseBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.uploadView.bussinesLicenseBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    [self.uploadView.idCardUploadBtn addTarget:self action:@selector(idCardUploadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.uploadView.bussinesLicenseUploadBtn addTarget:self action:@selector(bussinesLicenseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.uploadView.commitBtn addTarget:self action:@selector(commitPhotosBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadOldAuthenImage];
}

- (void)loadOldAuthenImage
{
    self.userDoc = [SjUserDoc sjUserDocWithSessionId:sjGlobalSessionId];
    if (self.userDoc.cardOne.cardImagePath != nil && self.userDoc.cardOne.cardImagePath.length !=0) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.userDoc.cardOne.cardImagePath] placeholderImage:[UIImage imageNamed:@"icon_empty"]];
        [self.uploadView.idCardFrontBtn setBackgroundImage:imgView.image forState:UIControlStateNormal];
        [self.uploadView.idCardFrontBtn setTitle:@"点击更改身份证照片" forState:UIControlStateNormal];
        
        self.identityDocId = self.userDoc.cardOne.cardImageDocId;
    }
    if (self.userDoc.cardTwo.cardImagePath != nil && self.userDoc.cardTwo.cardImagePath.length !=0) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.userDoc.cardTwo.cardImagePath] placeholderImage:[UIImage imageNamed:@"icon_empty"]];
        [self.uploadView.idCardFrontBtn setBackgroundImage:imgView.image forState:UIControlStateNormal];
        [self.uploadView.idCardFrontBtn setTitle:@"点击更改身份证照片" forState:UIControlStateNormal];
        
        self.identityDocId2 = self.userDoc.cardOne.cardImageDocId;
    }
    if (self.userDoc.licenseImage != nil && self.userDoc.licenseImage.length !=0) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.userDoc.licenseImage] placeholderImage:[UIImage imageNamed:@"icon_empty"]];
        [self.uploadView.bussinesLicenseBtn setBackgroundImage:imgView.image forState:UIControlStateNormal];
        [self.uploadView.bussinesLicenseBtn setTitle:@"点击更改营业执照照片" forState:UIControlStateNormal];
        
        self.bussinessDocId = self.userDoc.cardOne.cardImageDocId;
    }
}

-(void)chooseCameraOrAlbum:(UIButton*)btn
{
    if ([btn isEqual:self.uploadView.idCardFrontBtn]) {
        self.selectBtnType = FirstIdCardBtn;
    }
    else if ([btn isEqual:self.uploadView.idCardBackBtn])
    {
        self.selectBtnType = SecondIdCardBtn;
    }
    else
    {
        self.selectBtnType = BussinessLicenseBtn;
    }
    
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    [sheet showInView:self.view];
}

#pragma actionSheetDelegate

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSUInteger sourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        switch (buttonIndex) {
            case 0:
                // 取消
                return;
            case 1:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
                
            case 2:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
    }
    else {
        if (buttonIndex == 0) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    //imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}

#pragma imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (self.selectBtnType == FirstIdCardBtn) {
        [self.uploadView.idCardFrontBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else if(self.selectBtnType == SecondIdCardBtn)
    {
        [self.uploadView.idCardBackBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else
    {
        [self.uploadView.bussinesLicenseBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma upload picture

-(void)idCardUploadBtnClick
{
    
    if ([self.uploadView.idCardFrontBtn.currentBackgroundImage isEqual:[UIImage imageNamed:@"icon_empty"]] || [self.uploadView.idCardBackBtn.currentBackgroundImage isEqual:[UIImage imageNamed:@"icon_empty"]]) {
        [MBProgressHUD showError:@"请选择身份证正反面图片"];
        return;
    }
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *cardUuid = [[NSUUID UUID] UUIDString];
    params[@"docId"] = cardUuid;
    
    NSString *url = [NSString stringWithFormat:@"%@/web/fileDoc/upload", sjIp];
    
    // 3.发送请求，上传身份证
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [[UIImage alloc]init];
        image = self.uploadView.idCardFrontBtn.currentBackgroundImage;

        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        self.identityDocId = responseObject[@"id"];
//        NSArray *responseArry = (NSArray*)responseObject;
//        if (responseArry.count == 1) {
//            NSDictionary *dict = responseArry.firstObject;
//            self.identityDocId = dict[@"id"];
//        }
//        else if(responseArry.count == 2)
//        {
//            NSDictionary *dict1 = responseArry.firstObject;
//            self.identityDocId = dict1[@"id"];
//            NSDictionary *dict2 = responseArry.lastObject;
//            self.identityDocId2 = dict2[@"id"];
//        }
        [MBProgressHUD showSuccess:@"上传身份证成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"上传身份证失败"];
        
    }];
    // 4.上传第二张身份证
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [[UIImage alloc]init];
        image = self.uploadView.idCardBackBtn.currentBackgroundImage;
        
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        self.identityDocId2 = responseObject[@"id"];
//        NSArray *responseArry = (NSArray*)responseObject;
//        if (responseArry.count == 1) {
//            NSDictionary *dict = responseArry.firstObject;
//            self.identityDocId2 = dict[@"id"];
//        }
//        else if(responseArry.count == 2)
//        {
//            NSDictionary *dict1 = responseArry.firstObject;
//            self.identityDocId = dict1[@"id"];
//            NSDictionary *dict2 = responseArry.lastObject;
//            self.identityDocId2 = dict2[@"id"];
//        }
        
        [MBProgressHUD showSuccess:@"上传身份证成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"上传身份证失败"];
        
    }];
}
-(void)bussinesLicenseBtnClick
{
    
    if ([self.uploadView.bussinesLicenseBtn.currentBackgroundImage isEqual:[UIImage imageNamed:@"icon_empty"]]) {
        [MBProgressHUD showError:@"请选择公司营业执照"];
        return;
    }
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *bussinessUuid = [[NSUUID UUID] UUIDString];
    params[@"docId"] = bussinessUuid;
    
    NSString *url = [NSString stringWithFormat:@"%@/web/fileDoc/upload", sjIp];
    
    // 3.发送请求，上传身份证
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [[UIImage alloc]init];
        image = self.uploadView.bussinesLicenseBtn.currentBackgroundImage;
        
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        NSArray *responseArry = (NSArray*)responseObject;
//        if (responseArry.count != 0) {
//            NSDictionary *dict = responseArry.firstObject;
//            self.bussinessDocId = dict[@"id"];
//        }
        self.bussinessDocId = responseObject[@"id"];
        [MBProgressHUD showSuccess:@"上传营业执照成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"上传营业执照失败"];
    }];
}


- (void)commitPhotosBtnClick
{
    NSString *url = @"/web/enterprise/updateAuthenInfo";
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", sjIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    if(self.identityDocId == nil || self.identityDocId.length == 0 || self.identityDocId2 == nil || self.identityDocId2.length == 0)
    {
        [MBProgressHUD showError:@"请先上传身份证的正反面"];
        return;
    }
    
    if (self.bussinessDocId == nil || self.bussinessDocId.length == 0) {
        [MBProgressHUD showError:@"请先上传营业执照"];
        return;
    }
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:self.identityDocId];
    [strM appendString:@","];
    [strM appendString:self.identityDocId2];
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"id=%@&cardFileIds=%@&licenseFileId=%@",sjGlobalSessionId, strM, self.bussinessDocId];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqual:@"\"success\""]) {
        [MBProgressHUD showSuccess:@"提交申请成功"];
        [MBProgressHUD showSuccess:@"请到我的预支中查看详情"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if([str isEqual:@"\"\""])
    {
        [MBProgressHUD showSuccess:@"提交超时"];
    }
    else
    {
        [MBProgressHUD showSuccess:@"提交申请失败"];
    }

}
@end
