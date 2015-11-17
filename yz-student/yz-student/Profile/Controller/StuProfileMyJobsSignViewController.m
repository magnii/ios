//
//  StuProfileMyJobsSignViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/23.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobsSignViewController.h"
#import "StuConfig.h"
#import "StuHomeLocalJob.h"
#import "StuProfileMySignInfo.h"
#import "StuProfileAllMySignInfo.h"
#import "StuProfileMySignCell.h"
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD+MJ.h"
#import "StuLocation.h"

#define myBlueColor [UIColor colorWithRed:28/255.0 green:140/255.0 blue:212/255.0 alpha:1.0]
#define myOrangeColor [UIColor colorWithRed:255/255.0 green:153/255.0 blue:0.0 alpha:1.0]
#define signBtnWidth 100
#define signBtnHeight  25
#define paddingH 20
#define cellH 200

extern NSString *globalSessionId;

@interface StuProfileMyJobsSignViewController ()<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property(nonatomic, strong)UILabel *signInL;
@property(nonatomic, strong)UIButton *signInBtn;
@property(nonatomic, strong)UIButton *signOutBtn;

@property(nonatomic, strong)NSArray *allMySignInfo;
@property(nonatomic, strong)UITableView *mySignInfoTableView;
@property(nonatomic, strong)StuProfileMySignInfo *mySignInfo;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, assign)float nowLatitude;
@property (nonatomic, assign)float nowLongitude;

@property (nonatomic, strong)NSString *signType;

@property (nonatomic, strong)UIView *headView;

@end

@implementation StuProfileMyJobsSignViewController

- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]init];
    }
    return _headView;
}

- (NSString *)signType
{
    if (_signType == nil) {
        _signType = [NSString string];
    }
    return _signType;
}

- (CLLocationManager *)locationManager
{
    
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        
    }
    
    return _locationManager;
}

- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (StuProfileMySignInfo *)mySignInfo
{
    if (_mySignInfo == nil) {
        _mySignInfo = [[StuProfileMySignInfo alloc]init];
    }
    return _mySignInfo;
}

- (UITableView *)mySignInfoTableView
{
    if (_mySignInfoTableView == nil) {
        _mySignInfoTableView = [[UITableView alloc]init];
    }
    return _mySignInfoTableView;
}

- (NSArray *)allMySignInfo
{
    if (_allMySignInfo == nil) {
        _allMySignInfo = [NSArray array];
    }
    return _allMySignInfo;
}

- (UILabel *)signInL
{
    if (_signInL == nil) {
        _signInL = [[UILabel alloc]init];
    }
    NSString *nowTime1 = [self getNowDate];
    
    if (nowTime1 != nil && ![nowTime1 isEqualToString:@"\"\""]) {
    NSMutableString *nowTime2 = [NSMutableString stringWithString:[nowTime1 substringWithRange:NSMakeRange(1, 10)]];
        //2015-04-30
        [nowTime2 replaceCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
        [nowTime2 replaceCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
        [nowTime2 appendString:@"日"];
        _signInL.text = nowTime2;
    }
    
    return _signInL;
}

- (UIButton *)signInBtn
{
    if (_signInBtn == nil) {
        _signInBtn = [[UIButton alloc]init];
    }
    return _signInBtn;
}

- (UIButton *)signOutBtn
{
    if (_signOutBtn == nil) {
        _signOutBtn = [[UIButton alloc]init];
    }
    return _signOutBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    
    [self loadSignViewHead];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self checkTodaySign];
        self.allMySignInfo = [StuProfileAllMySignInfo allMySignInfoWithSessionId:globalSessionId JobId:self.oneJob.jobId IsAgent:self.oneJob.isAgent];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mySignInfoTableView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), screenFrame.size.width, screenFrame.size.height - CGRectGetMaxY(self.headView.frame));
            self.mySignInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            self.mySignInfoTableView.delegate = self;
            self.mySignInfoTableView.dataSource = self;
            [self.view addSubview:self.mySignInfoTableView];
        });
    });
    
}

- (void)loadSignViewHead
{
    //背景view
    self.headView.backgroundColor = [UIColor colorWithRed:238/255.0 green:249/255.0 blue:255/255.0 alpha:1.0];
    self.headView.frame = CGRectMake(0, 64, screenFrame.size.width, 80+paddingH);
    [self.view addSubview:self.headView];
    
    //今天日期
    //self.signInL.text = @"2015年09月23日";
    self.signInL.frame = CGRectMake(0, 0, 160, 26);
    self.signInL.center = CGPointMake(screenFrame.size.width*0.5, 20);
    self.signInL.backgroundColor = [UIColor clearColor];
    [self.signInL setTextAlignment:NSTextAlignmentCenter];
    [self.signInL setTextColor: myOrangeColor];
    [self.headView addSubview:self.signInL];
    
    
    
    CGFloat signBtnX = (screenFrame.size.width - 2*signBtnWidth)/3.0;
    //签到
    [self.signInBtn setTitle:@"签到" forState:UIControlStateNormal];
    [self.signInBtn setTitle:@"已签到" forState:UIControlStateSelected];
    [self.signInBtn setBackgroundColor: myBlueColor];
    [self.signInBtn.titleLabel setTextColor:[UIColor whiteColor]];
    self.signInBtn.frame = CGRectMake(signBtnX, CGRectGetMaxY(self.signInL.frame)+paddingH, signBtnWidth, signBtnHeight);
    [self.signInBtn addTarget:self action:@selector(signInBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.signInBtn];
    
    //签退
    [self.signOutBtn setTitle:@"签退" forState:UIControlStateNormal];
    [self.signOutBtn setTitle:@"已签退" forState:UIControlStateSelected];
    [self.signOutBtn setBackgroundColor: myBlueColor];
    [self.signOutBtn.titleLabel setTextColor:[UIColor whiteColor]];
    self.signOutBtn.frame = CGRectMake(signBtnX*2+signBtnWidth, CGRectGetMaxY(self.signInL.frame)+paddingH, signBtnWidth, signBtnHeight);
    [self.signOutBtn addTarget:self action:@selector(signOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.signOutBtn];
}

- (void)signInBtnClick:(UIButton*)btn
{
    //启动定位
    self.signType = @"in";
    [self locationAuthorization];
}

- (void)signOutBtnClick:(UIButton*)btn
{
    self.signType = @"out";
    [self locationAuthorization];
}

- (NSString*)getNowDate
{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/weChat/member/getNoWTime", serverIp]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

- (void)checkTodaySign
{
    StuProfileMySignInfo *info = [StuProfileMySignInfo mySignInfoWithSessionId:globalSessionId JobId:self.oneJob.jobId IsAgent:self.oneJob.isAgent];
    self.mySignInfo = info;
    
    if ((info.date == nil || [info.date isEqualToString:@""])&& (info.dateId == nil || [info.dateId isEqualToString:@""])) {
        self.headView.hidden=YES;
        self.headView.frame = CGRectMake(0, 0, 0, 64);
    }
    
    if (info.signInTime != nil && info.signInTime.length !=0) {
        [self.signInBtn setSelected:YES];
        self.signInBtn.userInteractionEnabled=NO;
    }
    if (info.signOutTime != nil && info.signOutTime.length !=0) {
        [self.signOutBtn setSelected:YES];
        self.signOutBtn.userInteractionEnabled=NO;
    }
}

#pragma tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allMySignInfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuProfileMySignCell *cell = [StuProfileMySignCell cellFromNibWithTableView:tableView];
    
    StuProfileAllMySignInfo *info = self.allMySignInfo[indexPath.row];
    
    cell.nowL.text = [NSString stringWithFormat:@"        %@", info.date];
    cell.signInDateL.text = info.signInTime;
    cell.signInAddr.text = info.signInAddress;
    cell.signOutDateL.text = info.signOutTime;
    cell.sinOutAddrL.text = info.signOutAddress;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma 定位

- (void)locationAuthorization
{
    if (![CLLocationManager locationServicesEnabled]) {
        [MBProgressHUD showError:@"手机定位功能未打开，请在设置中打开"];
        //直接设置默认为背景
        return;
    }
    
    if (systemVer >= 8.0)
    {
        if ([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedAlways)
        {
            //[self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
        }
    }
    //设置代理
    self.locationManager.delegate=self;
    //设置定位精度
    self.locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
    //定位频率,每隔多少米定位一次
    CLLocationDistance distance=10.0;//10米定位一次
    self.locationManager.distanceFilter=distance;
    //启动跟踪定位
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
            
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    
    if (coordinate.latitude!=0.0 && coordinate.longitude!=0.0) {
        if ([self.signType isEqualToString:@"in"] || [self.signType isEqualToString:@"out"]) {
            [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
        }
        
        self.nowLatitude = coordinate.latitude;
        self.nowLongitude = coordinate.longitude;
        
        //停止定位
        //[self.locationManager stopUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([error code] == kCLErrorDenied)
    {
        [MBProgressHUD showError:@"请在设置中允许软件使用定位功能"];
        [MBProgressHUD performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5f];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        [MBProgressHUD showError:@"定位失败，请手动选择所在城市"];
    }
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        StuLocation *cityInfo = [[StuLocation alloc]init];
        cityInfo.cityName = placemark.addressDictionary[@"City"];;
        cityInfo.subCityName = placemark.addressDictionary[@"SubLocality"];
        cityInfo.provinceName = placemark.addressDictionary[@"State"];
        cityInfo.streatName = placemark.addressDictionary[@"Street"];
        cityInfo.latitude = [NSString stringWithFormat:@"%f", latitude];
        cityInfo.longitude = [NSString stringWithFormat:@"%f", longitude];
        
        if (cityInfo.cityName !=nil && ![cityInfo.cityName isEqualToString:@""]) {
            //已经将定位信息解析成功,在这里才停止定位,否则不要停止
            [self.locationManager stopUpdatingLocation];
            
            NSString *nowAddr = [NSString stringWithFormat:@"%@%@%@%@", cityInfo.provinceName, cityInfo.cityName, cityInfo.subCityName, cityInfo.streatName];
            
            [StuProfileAllMySignInfo signInOutWithSessionId:globalSessionId DateId:self.mySignInfo.dateId IsAgent:self.oneJob.isAgent Address:nowAddr InOrOut:self.signType];
            for (StuProfileAllMySignInfo *info in self.allMySignInfo) {
                if ([self.mySignInfo.date isEqualToString:info.date]) {
                    NSString *signTime = [self getNowDate];
                    if ([self.signType isEqualToString:@"in"]) {
                        [self.signInBtn setSelected:YES];
                        self.signInBtn.userInteractionEnabled = NO;
                        
                        info.signInTime = [[signTime substringFromIndex:1]substringToIndex:signTime.length-2];
                        info.signInAddress = nowAddr;
                    }
                    else
                    {
                        [self.signOutBtn setSelected:YES];
                        self.signOutBtn.userInteractionEnabled = NO;
                        info.signOutTime = [[signTime substringFromIndex:1]substringToIndex:signTime.length-2];
                        info.signOutAddress = nowAddr;
                    }
                    BOOL result = [self signInOutActionWithSessionId:globalSessionId DateId:self.mySignInfo.dateId IsAgent:self.oneJob.isAgent Address:nowAddr];
                    if (!result) {
                        info.signOutAddress = @"";
                        info.signInAddress = @"";
                        info.signInTime = @"";
                        info.signOutTime = @"";
                        self.signInBtn.userInteractionEnabled = YES;
                        self.signOutBtn.userInteractionEnabled = YES;
                        [self.signInBtn setSelected:NO];
                        [self.signOutBtn setSelected:NO];
                    }
                    break;
                }
            }
            [self.mySignInfoTableView reloadData];
            
        }
    }];
}

- (BOOL)signInOutActionWithSessionId:(NSString*)sessionId DateId:(NSString*)dateId IsAgent:(NSString*)isAgent Address:(NSString*)address
{
    NSString *url = [NSString string];
    if ([self.signType isEqualToString:@"in"]) {
        url = @"/weChat/member/jobSignIn";
    }
    else
    {
        url = @"/weChat/member/jobSignOut";
    }
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"memberId=%@&dateId=%@&isAgent=%@&address=%@",sessionId, dateId, isAgent, address];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqualToString:@"\"success\""]) {
        return YES;
    }
    else if([str isEqualToString:@"\"包办未完成，不能签到\""] || [str isEqualToString:@"\"包办未完成，不能签退\""])
    {
        if ([self.signType isEqualToString:@"in"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"包办未完成，不能签到" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"包办未完成，不能签退" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertView show];
        }
        return NO;
    }
    else
    {
        return NO;
    }
}

@end
