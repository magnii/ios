//
//  StuHomeTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/19.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuHomeTableViewController.h"
#import "StuHomeFourBtnView.h"
#import "StuHomeFourBtnOne.h"
#import "StuHomeJobTableViewCell.h"
#import "StuHomeLeftBtn.h"
#import "StuLocation.h"
#import "StuLocationTool.h"
#import "StuManualSelLocationTableViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "StuHomeLocalJob.h"
#import "StuHighSalaryViewController.h"
#import "StuArrangeJobsViewController.h"
#import "StuTrainingViewController.h"
#import "StuHighSalaryViewController.h"
#import "StuPreSalaryViewController.h"
#import "StuWalletInfo.h"
#import <CoreLocation/CoreLocation.h>
#import "StuConfig.h"
#import "AdView.h"
#import "StuLoadMoreFooter.h"
#import "StuJobDetailViewController.h"

#define adViewH 130
#define headViewH 190
#define fourBtnH 60
#define pageSize 10
#define cellH 66

NSString *globalCityName = nil;
NSString *globalCityId = nil;

double globalLatitude;
double globalLongitude;

extern NSString *globalSessionId;
extern NSString *globalComplete;
extern NSString *globalAlipayNum;

@interface StuHomeTableViewController ()<CLLocationManagerDelegate, StuManualSelLocationDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HomeFourBtnView *fourBtnView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) AdView *adView;
@property (nonatomic, strong) UIView *headView;

@property(nonatomic, strong)NSMutableArray *jobsArry;
@property(nonatomic, assign)int currentPage;
@property(nonatomic, strong) UIRefreshControl *refresh;

@end

@implementation StuHomeTableViewController

- (UIRefreshControl *)refresh
{
    if (_refresh == nil) {
        _refresh = [[UIRefreshControl alloc]init];
        [_refresh addTarget:self action:@selector(loadNewJobs) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:_refresh];
    }
    return _refresh;
}

- (void)setupUpRefresh
{
    StuLoadMoreFooter *footer = [StuLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

- (NSMutableArray *)jobsArry
{
    if (_jobsArry == nil) {
        _jobsArry = [NSMutableArray array];
    }
    return _jobsArry;
}

- (void)setLocationCity:(NSString *)cityName
{
    self.leftBtn.locateCityL.text = cityName;
    //手动选择城市之后立即返回，后台加载所在城市的兼职
    //不能用子线程，子线程不能改变主线程中的ui等布局展示
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    globalCityName = cityName;
    globalCityId = [StuHomeLocalJob transfromCityNameToCityId:globalCityName];
    [self loadNewJobs];
    //});
}

- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (AdView *)adView
{
    if (_adView == nil) {
        _adView = [[AdView alloc]init];
    }
    return _adView;
}

- (UIView *)fourBtnView
{
    if (_fourBtnView == nil) {
        _fourBtnView = [[HomeFourBtnView alloc]init];
    }
    return _fourBtnView;
}

- (CLLocationManager *)locationManager
{
    
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        
    }
    
    return _locationManager;
}

- (void)locationAuthorization
{
    if (![CLLocationManager locationServicesEnabled]) {
        [MBProgressHUD showError:@"请打开手机的定位功能"];
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
    CLLocationDistance distance=1000.0;//1000米定位一次
    self.locationManager.distanceFilter=distance;
    //启动跟踪定位
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addleftBtn];
    [self locationAuthorization];
    
    NSArray *imagesURL = @[
                           [NSString stringWithFormat:@"%@/resources/images/lunbo1.jpg", serverIp],
                           [NSString stringWithFormat:@"%@/resources/images/lunbo2.jpg", serverIp],
                           [NSString stringWithFormat:@"%@/resources/images/lunbo3.png", serverIp],
                           ];
    //AdView *adView = [AdView adScrollViewWithFrame:CGRectMake(0, 64, screenFrame.size.width, adViewH) localImageLinkURL:imagesURL  pageControlShowStyle:UIPageControlShowStyleNone];
    AdView *adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, screenFrame.size.width, adViewH) imageLinkURL:imagesURL placeHoderImageName:@"aaab1.jpg" pageControlShowStyle:UIPageControlShowStyleNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
    adView.isNeedCycleRoll = YES;
    adView.adMoveTime = 3.0;
    [self.headView addSubview:adView];
    
    self.headView.frame = CGRectMake(0, 64, screenFrame.size.width, headViewH);
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenFrame.size.width, 190)];
//    view.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = self.headView;
    
    //半透明属性
    //    self.navigationController.navigationBar.translucent = NO;
    //    self.tabBarController.tabBar.translucent = NO;
    //让tableView的y从64开始
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.translucent = NO;
//    self.tabBarController.tabBar.translucent = NO;
    
    [self loadFourBtn];
    [self addTapGesture];
    
//    UIView *footerView = [[UIView alloc]init];
//    footerView.backgroundColor = [UIColor clearColor];
//    self.tableView.tableFooterView = footerView;
    [self setupUpRefresh];
}

- (void)loadFourBtn
{
    HomeFourBtnView *fourView = [HomeFourBtnView fourBtnInstance];
    fourView.frame = CGRectMake(0, adViewH, screenFrame.size.width, fourBtnH);
    _fourBtnView = fourView;
    [self.headView addSubview:fourView];
}

- (void)addTapGesture
{
    self.fourBtnView.highSalaryView.userInteractionEnabled = YES;
    UITapGestureRecognizer *highSalaryTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(highSalaryClick)];
    [self.fourBtnView.highSalaryView addGestureRecognizer:highSalaryTapGesture];
    
    self.fourBtnView.jobBBView.userInteractionEnabled = YES;
    UITapGestureRecognizer *jobBBTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jobBBClick)];
    [self.fourBtnView.jobBBView addGestureRecognizer:jobBBTapGesture];
    
    self.fourBtnView.trainView.userInteractionEnabled = YES;
    UITapGestureRecognizer *trainingTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(trainingClick)];
    [self.fourBtnView.trainView addGestureRecognizer:trainingTapGesture];
    
    self.fourBtnView.preSalaryView.userInteractionEnabled = YES;
    UITapGestureRecognizer *preSalaryTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(preSalaryClick)];
    [self.fourBtnView.preSalaryView addGestureRecognizer:preSalaryTapGesture];
}

- (void)highSalaryClick
{
    StuHighSalaryViewController *highVc = [[StuHighSalaryViewController alloc]init];
    [self.navigationController pushViewController:highVc animated:YES];
}

- (void)jobBBClick
{
    StuArrangeJobsViewController *arrangeJobsVc = [[StuArrangeJobsViewController alloc]init];
    [self.navigationController pushViewController:arrangeJobsVc animated:YES];
    
}

- (void)trainingClick
{
    StuTrainingViewController *trainingVc = [[StuTrainingViewController alloc]init];
    [self.navigationController pushViewController:trainingVc animated:YES];
}

- (void)preSalaryClick
{
    if (globalSessionId == nil || globalSessionId.length == 0) {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    
    if ([globalComplete isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"请先完善您的资料"];
        return;
    }
    
//    if (globalAlipayNum == nil || globalAlipayNum.length == 0) {
//        [MBProgressHUD showError:@"请先绑定支付宝"];
//        return;
//    }
    
    StuWalletInfo *walletInfo = [StuWalletInfo remainMoneyWithSessionId:globalSessionId];
    if (walletInfo.maxPoints < 80) {
        [MBProgressHUD showError:@"您还未达到V3等级，没有权限"];
        return;
    }
    StuPreSalaryViewController *vc = [[StuPreSalaryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addleftBtn
{
    StuHomeLeftBtn *leftBtn = [StuHomeLeftBtn stuHomeLeftBtnWithNib];
    leftBtn.frame = CGRectMake(5, 15, 30, 20);
    
    leftBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *leftBtnTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftBtnClick)];
    [leftBtn addGestureRecognizer:leftBtnTapGesture];
    
    _leftBtn = leftBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
}

- (void)leftBtnClick
{
    StuManualSelLocationTableViewController *tableVc = [[StuManualSelLocationTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    tableVc.delegate = self;
    [self.navigationController pushViewController:tableVc animated:YES];
}

- (void)loadNewJobs
{
    [self.refresh beginRefreshing];
    self.currentPage=0;
    [self.jobsArry removeAllObjects];
    NSArray *arry = [StuHomeLocalJob jobsWithCityId:globalCityId CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize] JobStatus:@"ongoing"];
    [self.jobsArry addObjectsFromArray:arry];
    
    [self.tableView reloadData];
    [self.refresh endRefreshing];
    
    if (arry != nil && arry.count != 0) {
        self.currentPage++;
    }
}

- (void)loadMoreJobs
{
    //当显示的小于10条数据的时候上拉加载不起作用，只有下拉可以显示最新的10条数据，为了防止在程序第一次启动的时候同时条用下拉和上拉接口，导致数据重复，上拉接口是根据footerviewer的位置来显示的，当数据太少的时候第一次启动会导致同时加载下拉和上拉
    if (self.jobsArry.count < 10) {
        return;
    }
    NSArray *arry = [StuHomeLocalJob jobsWithCityId:globalCityId CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize] JobStatus:@"ongoing"];
    [self.jobsArry addObjectsFromArray:arry];
    
    [self.tableView reloadData];
    if (arry!=nil && arry.count != 0) {
        self.currentPage++;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jobsArry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuHomeJobTableViewCell *cell = [StuHomeJobTableViewCell cellNibWithTableView:tableView];
    StuHomeLocalJob *oneJob = self.jobsArry[indexPath.row];
    [cell.jobTypeBtn setTitle:oneJob.jobType forState:UIControlStateNormal];
    cell.jobTitleL.text = oneJob.name;
    cell.jobAddrBtn.titleLabel.text = oneJob.parseArea;
    [cell.jobAddrBtn setTitle:oneJob.parseArea forState:UIControlStateNormal];
    cell.jobSalaryL.text = [NSString stringWithFormat:@"%d%@", (int)oneJob.salary, oneJob.unit];
    
    if (oneJob.isAgent == nil || ![oneJob.isAgent isEqualToString:@"1"]) {
        cell.baoBtn.hidden = YES;
    }
    
    NSArray * array = [oneJob.workingStartDate componentsSeparatedByString:@" "];
    cell.jobStartDateL.text = array[0];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    //if (self.jobsArry.count == 0||self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y-44;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height - self.tableView.tableFooterView.bounds.size.height;
//    NSLog(@"offsetY=%f, judgeOffsetY=%f", offsetY, judgeOffsetY);
    //NSLog(@"scrollView.contentSize.height=%f,scrollView.bounds.size.height=%f, self.tableView.tableFooterView.bounds.size.height=%f", scrollView.contentSize.height, scrollView.bounds.size.height, self.tableView.tableFooterView.bounds.size.height);
    if (offsetY+23 >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的数据
        if (offsetY >= judgeOffsetY+23)
        {
            [self loadMoreJobs];
            self.tableView.tableFooterView.hidden = YES;
        }
    }
    if (offsetY+9 == judgeOffsetY) {
        self.tableView.tableFooterView.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StuHomeLocalJob *oneJob = self.jobsArry[indexPath.row];
//    StuHomeLocalJob *oneJobDetail = [[StuHomeLocalJob alloc]init];
//    
//    if ([oneJob.isAgent isEqualToString:@"0"]) {
//        oneJobDetail = [StuHomeLocalJob nonArrangeJobWithJobId:oneJob.jobId MemberId:globalSessionId];
//    }
//    else
//    {
//        oneJobDetail = [StuHomeLocalJob arrangeJobWithJobId:oneJob.jobId MemberId:globalSessionId];
//    }
//    
    StuJobDetailViewController *vc = [[StuJobDetailViewController alloc]init];
//    vc.oneJob = oneJobDetail;
    vc.oneJob = oneJob;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- CoreLocation delegate

//ios8
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
        [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
        globalLatitude = coordinate.latitude;
        globalLongitude = coordinate.longitude;
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([error code] == kCLErrorDenied)
    {
        [MBProgressHUD showError:@"请在设置中允许软件使用定位功能"];
        [MBProgressHUD performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5f];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        [MBProgressHUD showError:@"定位失败，请手动选择城市"];
    }
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        StuLocation *cityInfo = [[StuLocation alloc]init];
        globalCityName = placemark.addressDictionary[@"City"];
        globalCityId = [StuHomeLocalJob transfromCityNameToCityId:globalCityName];
        cityInfo.cityName = globalCityName;
        cityInfo.subCityName = placemark.addressDictionary[@"SubLocality"];
        cityInfo.provinceName = placemark.addressDictionary[@"State"];
        cityInfo.streatName = placemark.addressDictionary[@"Street"];
        cityInfo.latitude = [NSString stringWithFormat:@"%f", latitude];
        cityInfo.longitude = [NSString stringWithFormat:@"%f", longitude];
        
        if ([cityInfo.provinceName isEqualToString:@"北京市"] ||
            [cityInfo.provinceName isEqualToString:@"天津市"] ||
            [cityInfo.provinceName isEqualToString:@"上海市"] ||
            [cityInfo.provinceName isEqualToString:@"重庆市"])
        {
            globalCityName = cityInfo.provinceName;
            cityInfo.cityName = globalCityName;
            globalCityId = [StuHomeLocalJob transfromCityNameToCityId:globalCityName];
        }
        
        [StuLocationTool saveLocation:cityInfo];
        if (cityInfo.cityName !=nil && ![cityInfo.cityName isEqualToString:@""]) {
            self.leftBtn.locateCityL.text = cityInfo.cityName;
            
            //自动加载定位后的城市兼职
            //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadNewJobs];
            //});
            
            [self.locationManager stopUpdatingLocation];
        }
    }];
}

-(void)getCoordinateByAddress:(NSString *)address{
    
    //地理编码
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark=[placemarks firstObject];
        
        CLLocation *location=placemark.location;//位置
        CLRegion *region=placemark.region;//区域
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
        //        NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //        NSString *locality=placemark.locality; // 城市
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        //[self loadNewJobWithCity:@"青岛" Longitude:@"100" Latitude:@"100" Radius:@"100" JobType:@"所有" Date:@"sf" CurrentPage:1 PageSize:10];
        
        //NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
        //NSLog(@"dj=%@,City=%@, name=%@", addressDic[@"State"], addressDic[@"City"], addressDic[@"Name"]);
    }];
}

//- (void)loadNewJobWithCity:(NSString*)cityName Longitude:(NSString*)longitude Latitude:(NSString*)latitude Radius:(NSString*)radius JobType:(NSString*)jobType Date:(NSString*)date CurrentPage:(int)currentPage PageSize:(int)pageSize
//{
//    NSString *ip = @"http://58.30.248.71:3333/weChat/job/findJobList";
//
//    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc]init];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"cityId"] = cityName;
//    params[@"typeId"] = jobType;
//    params[@"currentPage"] = [NSNumber numberWithInt:currentPage];
//    params[@"pageSize"] = [NSNumber numberWithInt:pageSize];
//    params[@"period"] = @"2015-9-10";
//    params[@"lng"] = @"120.355";
//    params[@"lat"] = @"36.082";
//    params[@"radius"] = @"1000";
//    [mgr GET:ip parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"array=%@", arry);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Load New Get failed--%@", error);
//    }];
//}

@end
