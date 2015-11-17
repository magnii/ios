//
//  StuProfileMySavedTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMySavedTableViewController.h"
#import "StuHomeJobTableViewCell.h"
#import "AFNetworking.h"
#import "Account.h"
#import "AccountTool.h"
#import "StuHomeLocalJob.h"
#import "StuHomeLeftBtn.h"
#import "StuLoadMoreFooter.h"
#import "StuJobDetailViewController.h"
#import "StuConfig.h"


#define cellH 56
#define pageSize 10

extern NSString *globalCityName;
extern NSString *globalCityId;
extern NSString *globalSessionId;

@interface StuProfileMySavedTableViewController ()

@property(nonatomic, strong)NSMutableArray *jobsArry;
@property(nonatomic, assign)int currentPage;

@property(nonatomic, strong) UIRefreshControl *refresh;
@property(nonatomic, copy) NSString *cityId;

@end

@implementation StuProfileMySavedTableViewController

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

- (NSMutableArray *)jobsArry
{
    if (_jobsArry == nil) {
        _jobsArry = [NSMutableArray array];
    }
    return _jobsArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUpRefresh];
    [self loadNewJobs];
}

- (void)loadNewJobs
{
    //    //手动刷新数据的时候调用父控制器上的城市名来加载数据
    //    if ([cityName isKindOfClass:[UIRefreshControl class]]) {
    //        StuHomeViewController *homeVc = (StuHomeViewController*)self.parentViewController;
    //        cityName = homeVc.leftBtn.locateCityL.text;
    //    }
    //
    [self.refresh beginRefreshing];
    self.currentPage=0;
    [self.jobsArry removeAllObjects];
    //    NSString *cityId = [StuHomeLocalJob transfromCityNameToCityId:globalCityName];
    //    self.cityId = cityId;
    NSArray *arry = [StuHomeLocalJob savedJobsWithSession:globalSessionId CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize]];
    [self.jobsArry addObjectsFromArray:arry];
    
    [self.tableView reloadData];
    [self.refresh endRefreshing];
    
    if (arry != nil && arry.count != 0) {
        self.currentPage++;
    }
    //NSLog(@"loadNewJobs currentPage=%d", self.currentPage);
}

- (void)loadMoreJobs
{
    //当显示的小于10条数据的时候上拉加载不起作用，只有下拉可以显示最新的10条数据，为了防止在程序第一次启动的时候同时条用下拉和上拉接口，导致数据重复，上拉接口是根据footerviewer的位置来显示的，当数据太少的时候第一次启动会导致同时加载下拉和上拉
    if (self.jobsArry.count < 10) {
        return;
    }
    NSArray *arry = [StuHomeLocalJob savedJobsWithSession:globalSessionId CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize]];
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
    
    NSArray * array = [oneJob.workingStartDate componentsSeparatedByString:@" "];
    cell.jobStartDateL.text = array[0];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.jobsArry.count == 0||self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y-44;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height - self.tableView.tableFooterView.bounds.size.height;
    //NSLog(@"offsetY=%f, judgeOffsetY=%f", offsetY, judgeOffsetY);
    //NSLog(@"scrollView.contentSize.height=%f,scrollView.bounds.size.height=%f, self.tableView.tableFooterView.bounds.size.height=%f", scrollView.contentSize.height, scrollView.bounds.size.height, self.tableView.tableFooterView.bounds.size.height);
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的数据
        [self loadMoreJobs];
        self.tableView.tableFooterView.hidden = YES;
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
    
    StuJobDetailViewController *jobDetaiVc = [[StuJobDetailViewController alloc]init];
    jobDetaiVc.oneJob = oneJobDetail;
    [self.navigationController pushViewController:jobDetaiVc animated:YES];
}
@end
