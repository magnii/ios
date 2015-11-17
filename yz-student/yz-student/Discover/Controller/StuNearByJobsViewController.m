//
//  StuNearByJobsViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/13.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuNearByJobsViewController.h"
#import "StuConfig.h"
#import "StuHomeJobTableViewCell.h"
#import "StuHomeLocalJob.h"
#import "StuLoadMoreFooter.h"
#import "StuHomeLeftBtn.h"
#import "StuJobDetailViewController.h"
#import "StuSelectBarButton.h"
#import "StuSelectBarTableViewController.h"
#import "StuGetJobsByLimit.h"
#import "StuCityJobTypeId.h"

#define cellH 56
#define pageSize 10
#define selectBarH 30
#define navigationBarH 64
#define areaTableViewMaxH 200
#define areaTableViewH 30*self.selectTableViewVc.itemsArray.count>areaTableViewMaxH?areaTableViewMaxH:30*self.selectTableViewVc.itemsArray.count
#define blueColor [UIColor colorWithRed:0/255.0 green:160/255.0 blue:219/255.0 alpha:1.0];

typedef enum
{
    SelectBarJobNone,
    SelectBarJobDis,
    SelectBarJobType,
    SelectBarJobTime,
}SelectBarJobItem;

extern NSString *globalCityName;
extern NSString *globalCityId;
extern double globalLatitude;
extern double globalLongitude;

@interface StuNearByJobsViewController ()<UITableViewDataSource, UITableViewDelegate, SelectBarProtocol>

@property(nonatomic, strong)UITableView *nearJobsTableView;

@property(nonatomic, assign)int currentPage;
@property(nonatomic, strong) UIRefreshControl *refresh;
@property(nonatomic, copy) NSString *cityId;
@property(nonatomic, strong)NSMutableArray *nearByJobsArray;

@property(nonatomic, strong)StuSelectBarButton *btn1;
@property(nonatomic, strong)StuSelectBarButton *btn2;
@property(nonatomic, strong)StuSelectBarButton *btn3;
@property(nonatomic, strong)NSArray *cityJobIdArray;

@property(nonatomic, strong)StuSelectBarTableViewController *selectTableViewVc;
@property(nonatomic, assign)SelectBarJobItem selectBarType;
@property(nonatomic, strong)NSString *selectItem;
@property(nonatomic, assign)float nearDistance;

@end

@implementation StuNearByJobsViewController

- (StuSelectBarTableViewController *)selectTableViewVc
{
    if (_selectTableViewVc == nil) {
        _selectTableViewVc = [[StuSelectBarTableViewController alloc]init];
    }
    return _selectTableViewVc;
}

- (NSString *)selectItem
{
    if (_selectItem == nil) {
        _selectItem = [NSString string];
    }
    return _selectItem;
}

- (NSArray *)cityJobIdArray
{
    if (_cityJobIdArray == nil) {
        _cityJobIdArray = [NSArray array];
    }
    return _cityJobIdArray;
}

- (NSArray *)nearByJobsArray
{
    if (_nearByJobsArray == nil) {
        _nearByJobsArray = [[NSMutableArray alloc]init];
    }
    return _nearByJobsArray;
}

- (UITableView *)nearJobsTableView
{
    if (_nearJobsTableView == nil) {
        _nearJobsTableView = [[UITableView alloc]init];
    }
    return _nearJobsTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的兼职";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUpRefresh];
    self.nearDistance = 1000.0;
    
    self.nearJobsTableView.delegate = self;
    self.nearJobsTableView.dataSource = self;
    self.selectTableViewVc.delegate = self;
    
    [self loadNewJobs];
    self.nearJobsTableView.frame = CGRectMake(0, selectBarH, screenFrame.size.width, screenFrame.size.height);
    [self.view addSubview:self.nearJobsTableView];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setUpSelectBar];
    
}

- (void)setUpSelectTableView:(CGFloat)oraignX
{
    NSMutableArray *itemArray = [NSMutableArray array];
    [itemArray removeAllObjects];
    if (fabs(oraignX - 2*screenFrame.size.width/3.0) < 1.0)
    {
        [itemArray addObject:@"1000米"];
        [itemArray addObject:@"3000米"];
        [itemArray addObject:@"5000米"];
        self.selectBarType = SelectBarJobDis;
        
    }else if (fabs(oraignX - screenFrame.size.width/3.0) < 1.0)
    {
        [itemArray addObject:@"全部"];
        [itemArray addObject:@"今天"];
        [itemArray addObject:@"三天内"];
        [itemArray addObject:@"一周内"];
        self.selectBarType = SelectBarJobTime;
    }
    else
    {
        self.cityJobIdArray = [StuGetJobsByLimit getCityAreasJobTypeWithCityId:globalCityId].jobTypes;
        [itemArray addObject:@"全部"];
        for (StuCityJobTypeId *cityJobTypeId in self.cityJobIdArray) {
            [itemArray addObject:cityJobTypeId.jobTypeName];
        }
        self.selectBarType = SelectBarJobType;
    }
    
    self.selectTableViewVc.itemsArray = itemArray;
    [self.selectTableViewVc.tableView reloadData];
    
    self.selectTableViewVc.tableView.frame = CGRectMake(oraignX, selectBarH+navigationBarH, screenFrame.size.width/3.0, areaTableViewH);
    [self addChildViewController:self.selectTableViewVc];
    [self.view addSubview:self.selectTableViewVc.view];
}

- (void)setUpSelectBar
{
    self.btn1 = [self setUpOneSelectBtn:@"职位"];
    self.btn1.frame = CGRectMake(0, 64, screenFrame.size.width/3.0, selectBarH);
    [self.view addSubview:self.btn1];
    [self.btn1 addTarget:self action:@selector(selectBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = [self setUpOneSelectBtn:@"发布时间"];
    self.btn2.frame = CGRectMake(CGRectGetMaxX(self.btn1.frame), 64, screenFrame.size.width/3.0, selectBarH);
    [self.view addSubview:self.btn2];
    [self.btn2 addTarget:self action:@selector(selectBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn3 = [self setUpOneSelectBtn:@"距离"];
    self.btn3.frame = CGRectMake(CGRectGetMaxX(self.btn2.frame), 64, screenFrame.size.width/3.0, selectBarH);
    [self.view addSubview:self.btn3];
    [self.btn3 addTarget:self action:@selector(selectBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (StuSelectBarButton*)setUpOneSelectBtn:(NSString *)title
{
    StuSelectBarButton *btn = [[StuSelectBarButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = blueColor;
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [btn setImage:[UIImage imageNamed:@"ic_arrow_down_black"] forState:UIControlStateNormal];
    
    return btn;
}

- (void)selectBarBtnClick:(UIButton*)btn
{
    if (self.selectTableViewVc.tableView.hidden) {
        [btn setSelected:NO];
    }
    [btn setSelected:!btn.selected];
    [self.selectTableViewVc.tableView setHidden:!btn.selected];
    if (btn.selected) {
        [self setUpSelectTableView:btn.frame.origin.x];
    }
}



- (UIRefreshControl *)refresh
{
    if (_refresh == nil) {
        _refresh = [[UIRefreshControl alloc]init];
        [_refresh addTarget:self action:@selector(loadNewJobs) forControlEvents:UIControlEventValueChanged];
        [self.nearJobsTableView addSubview:_refresh];
    }
    return _refresh;
}

- (void)setupUpRefresh
{
    StuLoadMoreFooter *footer = [StuLoadMoreFooter footer];
    footer.hidden = YES;
    self.nearJobsTableView.tableFooterView = footer;
}

- (void)loadNewJobs
{
    [self.refresh beginRefreshing];
    self.currentPage=0;
    [self.nearByJobsArray removeAllObjects];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *arry = [StuHomeLocalJob nearByJobsWithCityId:globalCityId TypeId:nil CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize] Period:nil JobStatus:@"ongoing" Lng:[NSString stringWithFormat:@"%f", globalLongitude] Lat:[NSString stringWithFormat:@"%f", globalLatitude] Radius:[NSString stringWithFormat:@"%f", self.nearDistance]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.nearByJobsArray addObjectsFromArray:arry];
            [self.nearJobsTableView reloadData];
            [self.refresh endRefreshing];
            if (arry != nil && arry.count != 0)
            {
                self.currentPage++;
            }
        });
    });

}

- (void)loadMoreJobs
{
    //当显示的小于10条数据的时候上拉加载不起作用，只有下拉可以显示最新的10条数据，为了防止在程序第一次启动的时候同时条用下拉和上拉接口，导致数据重复，上拉接口是根据footerviewer的位置来显示的，当数据太少的时候第一次启动会导致同时加载下拉和上拉
    if (self.nearByJobsArray.count < 10) {
        return;
    }
    NSArray *arry = [StuHomeLocalJob nearByJobsWithCityId:globalCityId TypeId:nil CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize] Period:nil JobStatus:@"ongoing" Lng:[NSString stringWithFormat:@"%f", globalLongitude] Lat:[NSString stringWithFormat:@"%f", globalLatitude] Radius:[NSString stringWithFormat:@"%f", self.nearDistance]];
    [self.nearByJobsArray addObjectsFromArray:arry];
    
    [self.nearJobsTableView reloadData];
    self.currentPage++;
}



#pragma tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nearByJobsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuHomeJobTableViewCell *cell = [StuHomeJobTableViewCell cellNibWithTableView:tableView];
    StuHomeLocalJob *oneJob = self.nearByJobsArray[indexPath.row];
    [cell.jobTypeBtn setTitle:oneJob.jobType forState:UIControlStateNormal];
    cell.jobTitleL.text = oneJob.name;
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
    if (self.nearByJobsArray.count == 0||self.nearJobsTableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y-44;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height - self.nearJobsTableView.tableFooterView.bounds.size.height;
    //NSLog(@"offsetY=%f, judgeOffsetY=%f", offsetY, judgeOffsetY);
    //NSLog(@"scrollView.contentSize.height=%f,scrollView.bounds.size.height=%f, self.tableView.tableFooterView.bounds.size.height=%f", scrollView.contentSize.height, scrollView.bounds.size.height, self.tableView.tableFooterView.bounds.size.height);
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.nearJobsTableView.tableFooterView.hidden = NO;
        
        // 加载更多的数据
        [self loadMoreJobs];
        self.nearJobsTableView.tableFooterView.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StuHomeLocalJob *oneJob = self.nearByJobsArray[indexPath.row];
    StuHomeLocalJob *oneJobDetail = [[StuHomeLocalJob alloc]init];
    if ([oneJob.isAgent isEqualToString:@"0"]) {
        oneJobDetail = [StuHomeLocalJob nonArrangeJobWithJobId:oneJob.jobId MemberId:@""];
    }
    else
    {
        oneJobDetail = [StuHomeLocalJob arrangeJobWithJobId:oneJob.jobId MemberId:@""];
    }
    
    StuJobDetailViewController *jobDetaiVc = [[StuJobDetailViewController alloc]init];
    jobDetaiVc.oneJob = oneJobDetail;
    [self.navigationController pushViewController:jobDetaiVc animated:YES];
}



//************************selectBarProtocol*************
//代理方法，通过限制条件加载数据
- (void)loadNewJobsWithSelectedItem:(NSString*)selectItem
{
    self.selectItem = selectItem;
    [self.nearByJobsArray removeAllObjects];
    self.currentPage = 0;
    NSString *areaId = nil;
    NSString *typeId = nil;
    NSString *period = nil;
    
    if (self.selectBarType == SelectBarJobDis) {
        if ([selectItem isEqualToString:@"全部"]) {
            areaId = globalCityId;
        }
        else
        {
            if ([selectItem isEqualToString:@"1000米"]) {
                self.nearDistance = 1000.0;
            }
            if ([selectItem isEqualToString:@"3000米"]) {
                self.nearDistance = 3000.0;
            }
            if ([selectItem isEqualToString:@"5000米"]) {
                self.nearDistance = 5000.0;
            }
        }
    }
    
    if (self.selectBarType == SelectBarJobType) {
        
        if ([selectItem isEqualToString:@"全部"]) {
            typeId = nil;
        }
        else
        {
            for (StuCityJobTypeId *jobType in self.cityJobIdArray) {
                if ([selectItem isEqualToString:jobType.jobTypeName]) {
                    typeId = jobType.jobTypeId;
                }
            }
        }
    }
    
    if (self.selectBarType == SelectBarJobTime) {
        
        if ([selectItem isEqualToString:@"全部"]) {
            period = nil;
        }
        if ([selectItem isEqualToString:@"今天"]) {
            period = @"1";
        }
        if ([selectItem isEqualToString:@"三天内"]) {
            period = @"3";
        }
        if ([selectItem isEqualToString:@"一周内"]) {
            period = @"7";
        }
    }
    
    NSArray *arry = [StuHomeLocalJob nearByJobsWithCityId:globalCityId TypeId:typeId CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize] Period:period JobStatus:@"ongoing" Lng:[NSString stringWithFormat:@"%f", globalLongitude] Lat:[NSString stringWithFormat:@"%f", globalLatitude] Radius:[NSString stringWithFormat:@"%f", self.nearDistance]];
    
    [self.nearByJobsArray addObjectsFromArray: arry];
    
    self.currentPage++;
    [self.nearJobsTableView reloadData];
}

@end
