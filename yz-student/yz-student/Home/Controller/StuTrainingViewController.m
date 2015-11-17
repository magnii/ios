//
//  StuTrainingViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/10.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuTrainingViewController.h"
#import "StuHomeLocalJob.h"
#import "StuLoadMoreFooter.h"
#import "StuTrainningTableViewCell.h"
#import "StuTrainingModel.h"
#import "StuTrainingDetailViewController.h"
#import "StuConfig.h"

#define grayLineColor [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:0.2]
#define textColor [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1.0]
#define blueColor [UIColor colorWithRed:28/255.0 green:141/255.0 blue:213/255.0 alpha:1.0]
#define textFontSize 12
#define navigationBarH CGRectGetMaxY(self.navigationController.navigationBar.frame)
#define pageSize 10
#define cellH 115

extern NSString *globalCityName;
extern NSString *globalCityId;
extern NSString *globalSessionId;

@interface StuTrainingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UIButton *trainingOnGoingBtn;
@property(nonatomic, strong)UIButton *trainingEndBtn;
@property(nonatomic, strong)UIView *trainingOnGoingView;
@property(nonatomic, strong)UIView *trainingEndView;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UITableView *trainingTableView;

@property(nonatomic, strong)NSMutableArray *trainingArray;
@property(nonatomic, assign)int currentPage;
@property(nonatomic, strong) UIRefreshControl *refresh;

@property(nonatomic, assign) NSString *jobStatus;

@end


@implementation StuTrainingViewController

- (NSString *)jobStatus
{
    if (_jobStatus == nil) {
        _jobStatus = [NSString string];
    }
    return _jobStatus;
}

- (UIButton *)trainingOnGoingBtn
{
    if (_trainingOnGoingBtn == nil) {
        _trainingOnGoingBtn = [[UIButton alloc]init];
        
        [_trainingOnGoingBtn setBackgroundImage:[UIImage imageNamed:@"line002"] forState:UIControlStateSelected];
        [_trainingOnGoingBtn setTitle:@"进行中的培训" forState:UIControlStateNormal];
        [_trainingOnGoingBtn setTitleColor:blueColor forState:UIControlStateSelected];
        [_trainingOnGoingBtn setTitleColor:textColor forState:UIControlStateNormal];
        _trainingOnGoingBtn.titleLabel.font = [UIFont systemFontOfSize:textFontSize];
    }
    [_trainingOnGoingBtn addTarget:self action:@selector(trainingOnGoingBtnClick:) forControlEvents:UIControlEventTouchDown];
    return _trainingOnGoingBtn;
}

- (UIButton *)trainingEndBtn
{
    if (_trainingEndBtn == nil) {
        _trainingEndBtn = [[UIButton alloc]init];
        
        [_trainingEndBtn setBackgroundImage:[UIImage imageNamed:@"line002"] forState:UIControlStateSelected];
        [_trainingEndBtn setTitle:@"往期培训" forState:UIControlStateNormal];
        [_trainingEndBtn setTitleColor:blueColor forState:UIControlStateSelected];
        [_trainingEndBtn setTitleColor:textColor forState:UIControlStateNormal];
        _trainingEndBtn.titleLabel.font = [UIFont systemFontOfSize:textFontSize];
    }
    [_trainingEndBtn addTarget:self action:@selector(trainingEndBtnClick:) forControlEvents:UIControlEventTouchDown];
    return _trainingEndBtn;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:grayLineColor];
    }
    return _lineView;
}

- (UIView *)trainingOnGoingView
{
    if (_trainingOnGoingView == nil) {
        _trainingOnGoingView = [[UIView alloc]init];
        _trainingOnGoingView.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), screenFrame.size.width, screenFrame.size.height);
    }
    
    return _trainingOnGoingView;
}

- (UIView *)trainingEndView
{
    if (_trainingEndView == nil) {
        _trainingEndView = [[UIView alloc]init];
        _trainingEndView.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), screenFrame.size.width, screenFrame.size.height);
    }
    return _trainingEndView;
}

- (UITableView *)trainingTableView
{
    if (_trainingTableView == nil) {
        _trainingTableView = [[UITableView alloc]init];
    }
    return _trainingTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"培训活动";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setAllFrames];
    [self setupUpRefresh];
    //[self loadNewTraining];
    
    self.trainingTableView.delegate = self;
    self.trainingTableView.dataSource = self;
    
    //[self trainingOnGoingBtnClick:self.trainingOnGoingBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self trainingOnGoingBtnClick:self.trainingOnGoingBtn];
}

- (void)trainingOnGoingBtnClick:(UIButton*)btn
{
    self.jobStatus = @"ongoing";
    [self loadNewTraining];
    [btn setSelected:YES];
    [self.trainingEndBtn setSelected:!btn.selected];
    
    [self.trainingOnGoingView addSubview:self.trainingTableView];
    
    [self.trainingEndView removeFromSuperview];
    [self.view addSubview:self.trainingOnGoingView];
}

- (void)trainingEndBtnClick:(UIButton*)btn
{
    self.jobStatus = @"finished";
    [self loadNewTraining];
    [btn setSelected:YES];
    [self.trainingOnGoingBtn setSelected:!btn.selected];
    
    [self.trainingEndView addSubview:self.trainingTableView];
    
    [self.trainingOnGoingView removeFromSuperview];
    [self.view addSubview:self.trainingEndView];
}

-(void)setAllFrames
{
    [self.view addSubview:self.trainingOnGoingBtn];
    [self.view addSubview:self.trainingEndBtn];
    [self.view addSubview:self.lineView];
    
    self.trainingOnGoingBtn.frame = CGRectMake(0, navigationBarH, screenFrame.size.width*0.5, 30);
    self.trainingEndBtn.frame = CGRectMake(CGRectGetMaxX(self.trainingOnGoingBtn.frame), navigationBarH, screenFrame.size.width*0.5, 30);
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.trainingOnGoingBtn.frame)-2, screenFrame.size.width, 1);
    
    self.trainingTableView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height-CGRectGetMaxY(self.lineView.frame));
}

- (UIRefreshControl *)refresh
{
    if (_refresh == nil) {
        _refresh = [[UIRefreshControl alloc]init];
        [_refresh addTarget:self action:@selector(loadNewTraining) forControlEvents:UIControlEventValueChanged];
        [self.trainingTableView addSubview:_refresh];
    }
    return _refresh;
}

- (void)setupUpRefresh
{
    StuLoadMoreFooter *footer = [StuLoadMoreFooter footer];
    footer.hidden = YES;
    self.trainingTableView.tableFooterView = footer;
}

- (NSMutableArray *)trainingArray
{
    if (_trainingArray == nil) {
        _trainingArray = [NSMutableArray array];
    }
    return _trainingArray;
}

- (void)loadNewTraining
{
    [self.refresh beginRefreshing];
    self.currentPage=0;
    [self.trainingArray removeAllObjects];
    
    NSArray *arry = [StuTrainingModel trainingModelWithCityId:globalCityId CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize] Status:self.jobStatus Cond:@"memberId" Value:globalSessionId];
    [self.trainingArray addObjectsFromArray:arry];
    
    [self.trainingTableView reloadData];
    [self.refresh endRefreshing];
    
    if (arry != nil && arry.count != 0) {
        self.currentPage++;
    }
}

- (void)loadMoreTraining
{
    //当显示的小于10条数据的时候上拉加载不起作用，只有下拉可以显示最新的10条数据，为了防止在程序第一次启动的时候同时调用下拉和上拉接口，导致数据重复，上拉接口是根据footerviewer的位置来显示的，当数据太少的时候第一次启动会导致同时加载下拉和上拉
    if (self.trainingArray.count < 5) {
        return;
    }
    NSArray *arry = [StuTrainingModel trainingModelWithCityId:globalCityId CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize] Status:self.jobStatus Cond:@"memberId" Value:globalSessionId];
    [self.trainingArray addObjectsFromArray:arry];
    
    [self.trainingTableView reloadData];
    self.currentPage++;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trainingArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuTrainningTableViewCell *cell = [StuTrainningTableViewCell cellWithTableView:tableView];
    StuTrainingModel *oneTraining = self.trainingArray[indexPath.row];
    cell.trainingImageView.image = [UIImage imageNamed:oneTraining.imgName];
    cell.trainingTitle.text = oneTraining.name;
    cell.trainingStartDate.text = [NSString stringWithFormat:@"开始日期：%@", oneTraining.startDate];
    cell.trainingEndDate.text = [NSString stringWithFormat:@"结束日期：%@", oneTraining.endDate];
    cell.trainingPeoples.text = [NSString stringWithFormat:@"名额：%@", oneTraining.peoples];
    cell.trainingAddress.text = oneTraining.address;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.trainingArray.count == 0||self.trainingTableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y-44;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height - self.trainingTableView.tableFooterView.bounds.size.height;
    //NSLog(@"offsetY=%f, judgeOffsetY=%f", offsetY, judgeOffsetY);
    //NSLog(@"scrollView.contentSize.height=%f,scrollView.bounds.size.height=%f, self.tableView.tableFooterView.bounds.size.height=%f", scrollView.contentSize.height, scrollView.bounds.size.height, self.tableView.tableFooterView.bounds.size.height);
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.trainingTableView.tableFooterView.hidden = NO;
        
        // 加载更多的数据
        [self loadMoreTraining];
        self.trainingTableView.tableFooterView.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StuTrainingDetail" bundle:[NSBundle mainBundle]];
    StuTrainingDetailViewController *trainingDetailVc = [sb instantiateViewControllerWithIdentifier:@"StuTrainingDetail"];
    
    trainingDetailVc.trainingModel = self.trainingArray[indexPath.row];
    
    [self.navigationController pushViewController:trainingDetailVc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
