//
//  StuPreSalarySelectJobViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuPreSalarySelectJobViewController.h"
#import "StuHomeJobTableViewCell.h"
#import "StuLoadMoreFooter.h"
#import "StuHomeLeftBtn.h"
#import "StuHomeLocalJob.h"
#import "StuJobDetailViewController.h"
#import "StuSelectBarButton.h"
#import "StuSelectBarTableViewController.h"
#import "StuConfig.h"
#import "StuGetJobsByLimit.h"
#import "StuCityAreasId.h"
#import "StuCityJobTypeId.h"
#import "StuPreSalaryJobDetailViewController.h"

#define cellH 56
#define pageSize 10
#define selectBarH 30
#define navigationBarH 64
#define blueColor [UIColor colorWithRed:0/255.0 green:160/255.0 blue:219/255.0 alpha:0.8];

extern NSString *globalCityName;
extern NSString *globalCityId;
extern NSString *globalSessionId;

typedef enum
{
    SelectBarJobNone,
    SelectBarJobArea,
    SelectBarJobType,
    SelectBarJobTime,
}SelectBarJobItem;

@interface StuPreSalarySelectJobViewController ()<UITableViewDataSource, UITableViewDelegate, SelectBarProtocol>
@property(nonatomic, strong)NSMutableArray *jobsArry;
@property(nonatomic, assign)int currentPage;
@property(nonatomic, strong) UIRefreshControl *refresh;

@property(nonatomic, strong)StuSelectBarButton *btn1;
@property(nonatomic, strong)StuSelectBarButton *btn2;
@property(nonatomic, strong)StuSelectBarButton *btn3;

@property(nonatomic, strong)UITableView *jobTableView;
@property(nonatomic, strong)StuSelectBarTableViewController *selectTableViewVc;
@property(nonatomic, assign)SelectBarJobItem selectBarType;

@property(nonatomic, strong)NSArray *cityAreaIdArray;
@property(nonatomic, strong)NSArray *cityJobIdArray;

@property(nonatomic, strong)NSString *selectItem;
@end

@implementation StuPreSalarySelectJobViewController

- (StuSelectBarTableViewController *)selectTableViewVc
{
    if (_selectTableViewVc == nil) {
        _selectTableViewVc = [[StuSelectBarTableViewController alloc]init];
    }
    return _selectTableViewVc;
}

- (UITableView *)jobTableView
{
    if (_jobTableView == nil) {
        _jobTableView = [[UITableView alloc]init];
    }
    return _jobTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择兼职";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUpRefresh];
    [self loadNewJobs];
    
    self.jobTableView.delegate = self;
    self.jobTableView.dataSource = self;
    self.selectTableViewVc.delegate = self;
    self.jobTableView.frame = CGRectMake(0, selectBarH, screenFrame.size.width, screenFrame.size.height);
    [self.view addSubview:self.jobTableView];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self setUpSelectBar];
}

- (void)setUpSelectTableView:(CGFloat)oraignX
{
    NSMutableArray *itemArray = [NSMutableArray array];
    [itemArray removeAllObjects];
    if (fabs(oraignX - 2*screenFrame.size.width/3.0) < 1.0)
    {
        [itemArray addObject:@"全部"];
        [itemArray addObject:@"今天"];
        [itemArray addObject:@"三天内"];
        [itemArray addObject:@"一周内"];
        self.selectBarType = SelectBarJobTime;
    }else if (fabs(oraignX - screenFrame.size.width/3.0) < 1.0)
    {
        self.cityJobIdArray = [StuGetJobsByLimit getCityAreasJobTypeWithCityId:globalCityId].jobTypes;
        [itemArray addObject:@"全部"];
        for (StuCityJobTypeId *cityJobTypeId in self.cityJobIdArray) {
            [itemArray addObject:cityJobTypeId.jobTypeName];
        }
        self.selectBarType = SelectBarJobType;
    }
    else
    {
        self.cityAreaIdArray = [StuGetJobsByLimit getCityAreasJobTypeWithCityId:globalCityId].cityareas;
        [itemArray addObject:@"全部"];
        for (StuCityAreasId *cityAreaId in self.cityAreaIdArray) {
            [itemArray addObject:cityAreaId.cityAreaName];
        }
        self.selectBarType = SelectBarJobArea;
    }
    
    self.selectTableViewVc.itemsArray = itemArray;
    [self.selectTableViewVc.tableView reloadData];
    
    self.selectTableViewVc.tableView.frame = CGRectMake(oraignX, selectBarH+navigationBarH, screenFrame.size.width/3.0, 30*self.selectTableViewVc.itemsArray.count);
    [self addChildViewController:self.selectTableViewVc];
    [self.view addSubview:self.selectTableViewVc.view];
}

- (void)setUpSelectBar
{
    self.btn1 = [self setUpOneSelectBtn:@"区域"];
    self.btn1.frame = CGRectMake(0, 64, screenFrame.size.width/3.0, selectBarH);
    [self.view addSubview:self.btn1];
    [self.btn1 addTarget:self action:@selector(selectBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = [self setUpOneSelectBtn:@"职位"];
    self.btn2.frame = CGRectMake(CGRectGetMaxX(self.btn1.frame), 64, screenFrame.size.width/3.0, selectBarH);
    [self.view addSubview:self.btn2];
    [self.btn2 addTarget:self action:@selector(selectBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn3 = [self setUpOneSelectBtn:@"发布时间"];
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
    
    //NSLog(@"%f", CGRectGetMaxY(self.navigationController.navigationBar.frame));
    //高度为64
    //btn.frame要最后设置才会起作用
    //btn.frame = CGRectMake(0, 64, screenFrame.size.width/3.0, selectBarH);
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

//**************************************************************************

- (UIRefreshControl *)refresh
{
    if (_refresh == nil) {
        _refresh = [[UIRefreshControl alloc]init];
        [_refresh addTarget:self action:@selector(loadNewJobs) forControlEvents:UIControlEventValueChanged];
        [self.jobTableView addSubview:_refresh];
    }
    return _refresh;
}

- (void)setupUpRefresh
{
    StuLoadMoreFooter *footer = [StuLoadMoreFooter footer];
    footer.hidden = YES;
    self.jobTableView.tableFooterView = footer;
}

- (NSMutableArray *)jobsArry
{
    if (_jobsArry == nil) {
        _jobsArry = [NSMutableArray array];
    }
    return _jobsArry;
}

- (void)loadNewJobs
{
    [self.refresh beginRefreshing];
    self.currentPage=0;
    [self.jobsArry removeAllObjects];
    
    NSString *areaId = @"";
    NSString *typeId = @"";
    NSString *period = @"";
    
    if (self.selectBarType == SelectBarJobArea) {
        if ([self.selectItem isEqualToString:@"全部"]) {
            areaId = globalCityId;
        }
        else
        {
            for (StuCityAreasId *cityArea in self.cityAreaIdArray) {
                if ([self.selectItem isEqualToString:cityArea.cityAreaName]) {
                    areaId = cityArea.cityAreaId;
                }
            }
        }
    }
    
    if (self.selectBarType == SelectBarJobType) {
        
        if ([self.selectItem isEqualToString:@"全部"]) {
            typeId = nil;
        }
        else
        {
            for (StuCityJobTypeId *jobType in self.cityJobIdArray) {
                if ([self.selectItem isEqualToString:jobType.jobTypeName]) {
                    typeId = jobType.jobTypeId;
                }
            }
        }
    }
    
    if (self.selectBarType == SelectBarJobTime) {
        
        if ([self.selectItem isEqualToString:@"全部"]) {
            period = nil;
        }
        if ([self.selectItem isEqualToString:@"今天"]) {
            period = @"1";
        }
        if ([self.selectItem isEqualToString:@"三天内"]) {
            period = @"3";
        }
        if ([self.selectItem isEqualToString:@"一周内"]) {
            period = @"7";
        }
    }
    
    //[self.jobsArry addObjectsFromArray: [StuHomeLocalJob jobsWithCityId:globalCityId  AreaId:areaId TypeId:typeId CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize] Period:period Lng:nil Lat:nil Radius:nil Cond:@"unit,salary" Value:[NSString stringWithFormat:@"元/天,%@", highSalary] JobStatus:@"ongoing"]];
    
    [self.jobsArry addObjectsFromArray:[StuHomeLocalJob preSalaryWithCityId:globalCityId AreaId:areaId TypeId:typeId Period:period JobStatus:@"ongoing" CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize]]];
     [self.refresh endRefreshing];
    
     [self.jobTableView reloadData];
    
    if (self.jobsArry != nil && self.jobsArry.count != 0) {
        self.currentPage++;
    }
}

- (void)loadMoreJobs
{
    //当显示的小于10条数据的时候上拉加载不起作用，只有下拉可以显示最新的10条数据，为了防止在程序第一次启动的时候同时条用下拉和上拉接口，导致数据重复，上拉接口是根据footerviewer的位置来显示的，当数据太少的时候第一次启动会导致同时加载下拉和上拉
    if (self.jobsArry.count < 10) {
        return;
    }
    
    NSString *areaId = nil;
    NSString *typeId = nil;
    NSString *period = nil;
    
    if (self.selectBarType == SelectBarJobArea) {
        if ([self.selectItem isEqualToString:@"全部"]) {
            areaId = globalCityId;
        }
        else
        {
            for (StuCityAreasId *cityArea in self.cityAreaIdArray) {
                if ([self.selectItem isEqualToString:cityArea.cityAreaName]) {
                    areaId = cityArea.cityAreaId;
                }
            }
        }
    }
    
    if (self.selectBarType == SelectBarJobType) {
        
        if ([self.selectItem isEqualToString:@"全部"]) {
            typeId = nil;
        }
        else
        {
            for (StuCityJobTypeId *jobType in self.cityJobIdArray) {
                if ([self.selectItem isEqualToString:jobType.jobTypeName]) {
                    typeId = jobType.jobTypeId;
                }
            }
        }
    }
    
    if (self.selectBarType == SelectBarJobTime) {
        
        if ([self.selectItem isEqualToString:@"全部"]) {
            period = nil;
        }
        if ([self.selectItem isEqualToString:@"今天"]) {
            period = @"1";
        }
        if ([self.selectItem isEqualToString:@"三天内"]) {
            period = @"3";
        }
        if ([self.selectItem isEqualToString:@"一周内"]) {
            period = @"7";
        }
    }
    
    [self.jobsArry addObjectsFromArray:[StuHomeLocalJob preSalaryWithCityId:globalCityId AreaId:areaId TypeId:typeId Period:period JobStatus:@"ongoing" CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize]]];
    
    [self.jobTableView reloadData];
    self.currentPage++;
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
    // 如果tableView还没有数据，就直接返回
    if (self.jobsArry.count == 0||self.jobTableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y-44;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height - self.jobTableView.tableFooterView.bounds.size.height;
    //NSLog(@"offsetY=%f, judgeOffsetY=%f", offsetY, judgeOffsetY);
    //NSLog(@"scrollView.contentSize.height=%f,scrollView.bounds.size.height=%f, self.tableView.tableFooterView.bounds.size.height=%f", scrollView.contentSize.height, scrollView.bounds.size.height, self.tableView.tableFooterView.bounds.size.height);
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.jobTableView.tableFooterView.hidden = NO;
        
        // 加载更多的数据
        [self loadMoreJobs];
        self.jobTableView.tableFooterView.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StuHomeLocalJob *oneJob = self.jobsArry[indexPath.row];
    StuHomeLocalJob *oneJobDetail = [[StuHomeLocalJob alloc]init];
    if ([oneJob.isAgent isEqualToString:@"0"]) {
        oneJobDetail = [StuHomeLocalJob nonArrangeJobWithJobId:oneJob.jobId MemberId:globalSessionId];
    }
    else
    {
        oneJobDetail = [StuHomeLocalJob arrangeJobWithJobId:oneJob.jobId MemberId:globalSessionId];
    }
    
    
    
//    StuJobDetailViewController *jobDetailVc = [[StuJobDetailViewController alloc]init];
//    jobDetailVc.oneJob = oneJobDetail;
//    [self.navigationController pushViewController:jobDetailVc animated:YES];
    StuPreSalaryJobDetailViewController *vc = [[StuPreSalaryJobDetailViewController alloc]init];
    vc.oneJob = oneJobDetail;
    [self.navigationController pushViewController:vc animated:YES];
}

//************************selectBarProtocol*************
//代理方法，通过限制条件加载数据
- (void)loadNewJobsWithSelectedItem:(NSString*)selectItem
{
    self.selectItem = selectItem;
    [self.jobsArry removeAllObjects];
    self.currentPage = 0;
    NSString *areaId = nil;
    NSString *typeId = nil;
    NSString *period = nil;
    
    if (self.selectBarType == SelectBarJobArea) {
        if ([selectItem isEqualToString:@"全部"]) {
            areaId = globalCityId;
        }
        else
        {
            for (StuCityAreasId *cityArea in self.cityAreaIdArray) {
                if ([selectItem isEqualToString:cityArea.cityAreaName]) {
                    areaId = cityArea.cityAreaId;
                }
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
    
    [self.jobsArry addObjectsFromArray:[StuHomeLocalJob preSalaryWithCityId:globalCityId AreaId:areaId TypeId:typeId Period:period JobStatus:@"ongoing" CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize]]];
    
    self.currentPage++;
    [self.jobTableView reloadData];
}

@end
