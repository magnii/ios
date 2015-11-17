//
//  StuPreSalaryUpLoadIDViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/7.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuPreSalaryUpLoadIDViewController.h"
#import "StuUploadIDCard.h"
#import "StuConfig.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "StuJobDateObj.h"

extern NSMutableArray *preDateIdArray;
extern NSString *globalSessionId;

typedef enum
{
    CameraBtn = 0,
    AlbumBtn
} SelectCameraAlbum;


@interface StuPreSalaryUpLoadIDViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, assign) SelectCameraAlbum selectBtnType;
@property(nonatomic, strong) StuUploadIDCard *uploadView;
@property(nonatomic, strong) NSString *identityDocId;
@property(nonatomic, strong) NSString *studentDocId;
@property(nonatomic, strong) UIScrollView *preSalaryScrollView;

@end

@implementation StuPreSalaryUpLoadIDViewController

- (UIScrollView *)preSalaryScrollView
{
    if (_preSalaryScrollView == nil) {
        _preSalaryScrollView = [[UIScrollView alloc]init];
    }
    return _preSalaryScrollView;
}

-(NSString *)identityDocId
{
    if (_identityDocId == nil) {
        _identityDocId = [NSString string];
    }
    return _identityDocId;
}

-(NSString *)studentDocId
{
    if (_studentDocId == nil) {
        _studentDocId = [NSString string];
    }
    return _studentDocId;
}

- (StuUploadIDCard *)uploadView
{
    if (_uploadView == nil) {
        _uploadView = [StuUploadIDCard viewFromNib];
    }
    return _uploadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传凭证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.selectBtnType = 0;
    
    self.preSalaryScrollView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height+100);
    self.preSalaryScrollView.contentSize = CGSizeMake(screenFrame.size.width, screenFrame.size.height+100);
    [self.view addSubview:self.preSalaryScrollView];
    
    self.uploadView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height);
    [self.preSalaryScrollView addSubview:self.uploadView];
    
    [self.uploadView.certificateBtn addTarget:self action:@selector(chooseCameraOrAlbum:) forControlEvents:UIControlEventTouchDown];
    [self.uploadView.stuCertificateBtn addTarget:self action:@selector(chooseCameraOrAlbum:) forControlEvents:UIControlEventTouchDown];
    
    [self.uploadView.certificateBtn setTitle:@"点击上传身份证" forState:UIControlStateNormal];
    [self.uploadView.certificateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.uploadView.certificateBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    [self.uploadView.stuCertificateBtn setTitle:@"点击上传学生证" forState:UIControlStateNormal];
    [self.uploadView.stuCertificateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.uploadView.stuCertificateBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    [self.uploadView.uploadCertificateBtn addTarget:self action:@selector(uploadCertificateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.uploadView.uploadStuCertificateBtn addTarget:self action:@selector(uploadStuCertificateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.uploadView.commitBtn addTarget:self action:@selector(commitPhotosBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)chooseCameraOrAlbum:(UIButton*)btn
{
    if ([btn isEqual:self.uploadView.stuCertificateBtn]) {
        self.selectBtnType = AlbumBtn;
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
    
    if (self.selectBtnType == CameraBtn) {
        [self.uploadView.certificateBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else
    {
        [self.uploadView.stuCertificateBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma upload picture

-(void)uploadCertificateBtnClick
{
    
    if ([self.uploadView.certificateBtn.currentBackgroundImage isEqual:[UIImage imageNamed:@"aaab1.jpg"]]) {
        [MBProgressHUD showError:@"请选择身份证图片"];
        return;
    }
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:@"%@/weChat/fileDoc/upload", serverIp];
    
    // 3.发送请求，上传身份证
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [[UIImage alloc]init];
        if (self.selectBtnType == AlbumBtn)
        {
            image = self.uploadView.stuCertificateBtn.currentBackgroundImage;
        }
        else
        {
            image = self.uploadView.certificateBtn.currentBackgroundImage;
        }
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        self.identityDocId = responseObject[@"docId"];
        [MBProgressHUD showSuccess:@"上传身份证成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"上传身份证失败"];
        
    }];
}
-(void)uploadStuCertificateBtnClick
{
    
    if ([self.uploadView.stuCertificateBtn.currentBackgroundImage isEqual:[UIImage imageNamed:@"aaab1.jpg"]]) {
        [MBProgressHUD showError:@"请选择学生证图片"];
        return;
    }
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:@"%@/weChat/fileDoc/upload", serverIp];
    
    // 3.发送请求，上传身份证
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [[UIImage alloc]init];
        if (self.selectBtnType == AlbumBtn)
        {
            image = self.uploadView.stuCertificateBtn.currentBackgroundImage;
        }
        else
        {
            image = self.uploadView.certificateBtn.currentBackgroundImage;
        }
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        self.studentDocId = responseObject[@"docId"];
        [MBProgressHUD showSuccess:@"上传学生证成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"上传学生证失败"];
    }];
}


- (void)commitPhotosBtnClick
{
    NSMutableString *strM = [NSMutableString string];
    int index = 0;
    for (StuJobDateObj *obj in preDateIdArray) {
        
        if (index != preDateIdArray.count-1) {
            [strM appendString:[NSString stringWithFormat:@"%@,", obj.jobDateId]];
        }
        else
        {
            [strM appendString:obj.jobDateId];
        }
        index++;
    }
    
    if ([strM isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择兼职"];
        return;
    }
    if (self.studentDocId.length == 0) {
        [MBProgressHUD showError:@"请上传学生证"];
        return;
    }
    if (self.identityDocId.length == 0) {
        [MBProgressHUD showError:@"请上传身份证"];
        return;
    }
    
    NSString *url = @"/weChat/advance/save";
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"money=%@&memberId=%@&reason=%@&dateIds=%@&identityDocId=%@&studentDocId=%@",self.money, globalSessionId, self.execuse, strM, self.identityDocId, self.studentDocId];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqual:@"\"success\""]) {
        [MBProgressHUD showSuccess:@"提交申请成功"];
        [MBProgressHUD showSuccess:@"请到我的预支中查看详情"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [MBProgressHUD showSuccess:@"提交申请失败"];
    }
    
}

@end
