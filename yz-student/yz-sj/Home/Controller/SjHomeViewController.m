//
//  SjHomeViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjHomeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD+MJ.h"
#import "StuConfig.h"
#import "StuHomeLeftBtn.h"
#import "StuManualSelLocationTableViewController.h"
#import "StuLocation.h"
#import "StuHomeLocalJob.h"
#import "StuLocationTool.h"
#import "StuLoadMoreFooter.h"
#import "SjHomeJobTableViewCell.h"
#import "SjOneJobInfo.h"
#import "SjOneJobTableViewController.h"

#define pageSize 10
#define cellH 70

NSString *sjGlobalCityName = nil;
NSString *sjGlobalCityId = nil;

extern NSString *sjGlobalSessionId;

double sjGlobalLatitude;
double sjGlobalLongitude;

@interface SjHomeViewController ()<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property(nonatomic, strong)NSMutableArray *jobsArry;
@property(nonatomic, assign)int currentPage;
@property(nonatomic, strong) UIRefreshControl *refresh;
@property(nonatomic, strong) UITableView *jobsTableView;

@end

@implementation SjHomeViewController

- (UITableView *)jobsTableView
{
    if (_jobsTableView == nil) {
        _jobsTableView = [[UITableView alloc]init];
    }
    return _jobsTableView;
}

- (UIRefreshControl *)refresh
{
    if (_refresh == nil) {
        _refresh = [[UIRefreshControl alloc]init];
        [_refresh addTarget:self action:@selector(loadNewJobs) forControlEvents:UIControlEventValueChanged];
        [self.jobsTableView addSubview:_refresh];
    }
    return _refresh;
}

- (void)setupUpRefresh
{
    StuLoadMoreFooter *footer = [StuLoadMoreFooter footer];
    footer.hidden = YES;
    self.jobsTableView.tableFooterView = footer;
}

- (NSMutableArray *)jobsArry
{
    if (_jobsArry == nil) {
        _jobsArry = [NSMutableArray array];
    }
    return _jobsArry;
}

- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (CLLocationManager *)locationManager
{
    
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        
    }
    
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addleftBtn];
    [self locationAuthorization];
    
    self.jobsTableView.delegate = self;
    self.jobsTableView.dataSource = self;
    self.jobsTableView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height);
    [self.view addSubview:self.jobsTableView];
    
    [self loadNewJobs];
    
//    UIView *footerView = [[UIView alloc]init];
//    footerView.backgroundColor = [UIColor clearColor];
//    self.jobsTableView.tableFooterView = footerView;
    [self setupUpRefresh];
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
    [self.navigationController pushViewController:tableVc animated:YES];
}

- (void)loadNewJobs
{
    [self.refresh beginRefreshing];
    self.currentPage=0;
    [self.jobsArry removeAllObjects];
    NSArray *arry = [SjOneJobInfo sjJobsWithMemberId:sjGlobalSessionId JobStatus:@"" MinResult:[NSString stringWithFormat:@"%d", self.currentPage] MaxResult:[NSString stringWithFormat:@"%d", self.currentPage+pageSize]];
    [self.jobsArry addObjectsFromArray:arry];
    
    [self.jobsTableView reloadData];
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
    NSArray *arry = [SjOneJobInfo sjJobsWithMemberId:sjGlobalSessionId JobStatus:@"0" MinResult:[NSString stringWithFormat:@"%d", self.currentPage] MaxResult:[NSString stringWithFormat:@"%d", pageSize]];
    [self.jobsArry addObjectsFromArray:arry];
    
    [self.jobsTableView reloadData];
    if (arry!=nil && arry.count != 0) {
        self.currentPage ++;
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
    SjHomeJobTableViewCell *cell = [SjHomeJobTableViewCell cellFromNibWithTableView:tableView];
    
    SjOneJobInfo *jobInfo = self.jobsArry[indexPath.row];
    [cell.jobTypeBtn setTitle:jobInfo.jobType forState:UIControlStateNormal];
    [cell.jobNameL setText:jobInfo.name];
    [cell.jobDateL setText:jobInfo.createTime];
    if (![jobInfo.isAgent isEqualToString:@"1"]) {
        cell.imgBao.hidden = YES;
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.jobsArry.count == 0||self.jobsTableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y-44;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height - self.jobsTableView.tableFooterView.bounds.size.height;
    //NSLog(@"offsetY=%f, judgeOffsetY=%f", offsetY, judgeOffsetY);
    //NSLog(@"scrollView.contentSize.height=%f,scrollView.bounds.size.height=%f, self.tableView.tableFooterView.bounds.size.height=%f", scrollView.contentSize.height, scrollView.bounds.size.height, self.tableView.tableFooterView.bounds.size.height);
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.jobsTableView.tableFooterView.hidden = NO;
        
        // 加载更多的数据
        [self loadMoreJobs];
        self.jobsTableView.tableFooterView.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SjOneJobInfo *jobInfo = self.jobsArry[indexPath.row];
    
    SjOneJobTableViewController *vc = [[SjOneJobTableViewController alloc]init];
    vc.jobId = jobInfo.jobId;
    
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
        sjGlobalLatitude = coordinate.latitude;
        sjGlobalLongitude = coordinate.longitude;
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
        sjGlobalCityName = placemark.addressDictionary[@"City"];
        sjGlobalCityId = [StuHomeLocalJob transfromCityNameToCityId:sjGlobalCityName];
        cityInfo.cityName = sjGlobalCityName;
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
            sjGlobalCityName = cityInfo.provinceName;
            cityInfo.cityName = sjGlobalCityName;
            sjGlobalCityId = [StuHomeLocalJob transfromCityNameToCityId:sjGlobalCityName];
        }
        
        [StuLocationTool saveLocation:cityInfo];
        if (cityInfo.cityName !=nil && ![cityInfo.cityName isEqualToString:@""]) {
            self.leftBtn.locateCityL.text = cityInfo.cityName;
            
            //自动加载定位后的城市兼职
            //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //[self loadNewJobs];
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
