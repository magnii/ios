//
//  StuProfileMyJobsCommentsViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobsCommentsViewController.h"
#import "StuConfig.h"
#import "StuProfileCommentsTableViewCell.h"
#import "StuProfileComments.h"
#import "StuHomeLocalJob.h"
#import "StuLoadMoreFooter.h"
#import "MBProgressHUD+MJ.h"

#define textFontSize 12
#define pageSize 10

extern NSString *globalSessionId;

@interface StuProfileMyJobsCommentsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property(nonatomic, strong)UITableView *commentsTableView;
@property(nonatomic, strong)UITextView *commentsTextView;
@property(nonatomic, strong)UIButton *commentsBtn;
@property(nonatomic, strong)NSMutableArray *commentsArray;
@property(nonatomic, strong)UILabel *label;

@property(nonatomic, assign)int currentPage;
@property(nonatomic, strong) UIRefreshControl *refresh;

@end

@implementation StuProfileMyJobsCommentsViewController

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc]init];
    }
    return _label;
}

- (NSArray *)commentsArray
{
    if (_commentsArray == nil) {
        _commentsArray = [NSMutableArray array];
    }
    return _commentsArray;
}

- (UIButton *)commentsBtn
{
    if (_commentsBtn == nil) {
        _commentsBtn = [[UIButton alloc]init];
    }
    return _commentsBtn;
}

- (UITableView *)commentsTableView
{
    if (_commentsTableView == nil) {
        _commentsTableView = [[UITableView alloc]init];
    }
    return _commentsTableView;
}

- (UITextView *)commentsTextView
{
    if (_commentsTextView == nil) {
        _commentsTextView = [[UITextView alloc]init];
    }
    return _commentsTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位交流区";
    
    //tableView
    
    self.commentsTableView.delegate = self;
    self.commentsTableView.dataSource = self;
    
    self.commentsTableView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height-200);
    [self.view addSubview:self.commentsTableView];
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.commentsTableView setTableFooterView:view];
    
    [self setupUpRefresh];
    [self loadNewJobs];
    
    //textView
    self.commentsTextView.frame = CGRectMake(20, CGRectGetMaxY(self.commentsTableView.frame), screenFrame.size.width-40, 120);
    
    [self.commentsTextView.layer setBorderColor:[UIColor grayColor].CGColor];
    self.commentsTextView.layer.borderWidth = 1;
    self.commentsTextView.layer.cornerRadius = 5;
    self.commentsTextView.delegate = self;
    [self loadTextViewPlaceHolder];
    [self.view addSubview:self.commentsTextView];
    
    //button
    self.commentsBtn.frame = CGRectMake(50, CGRectGetMaxY(self.commentsTextView.frame)+20, screenFrame.size.width-100, 35);
    
    [self.commentsBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    self.commentsBtn.layer.cornerRadius = 5;
    [self.commentsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commentsBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:160/255.0 blue:219/255.0 alpha:1.0]];
    [self.view addSubview:self.commentsBtn];
    [self.commentsBtn addTarget:self action:@selector(commentsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加手势动作，用来取消下面的评论键盘
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(commentsTextViewDismissKeyboard)];
    [self.commentsTableView addGestureRecognizer:singleFingerTap];
    
}

- (void)loadTextViewPlaceHolder
{
    self.label.text = @"我要发表的评论......";
    [self.label setFont:[UIFont systemFontOfSize:12]];
    
    self.label.frame = CGRectMake(5, 3, 120, 20);
    [self.commentsTextView addSubview:self.label];
}


- (UIRefreshControl *)refresh
{
    if (_refresh == nil) {
        _refresh = [[UIRefreshControl alloc]init];
        [_refresh addTarget:self action:@selector(loadNewJobs) forControlEvents:UIControlEventValueChanged];
        [self.commentsTableView addSubview:_refresh];
    }
    return _refresh;
}

- (void)setupUpRefresh
{
    StuLoadMoreFooter *footer = [StuLoadMoreFooter footer];
    footer.hidden = YES;
    self.commentsTableView.tableFooterView = footer;
}

- (void)loadNewJobs
{
    [self.refresh beginRefreshing];
    self.currentPage=0;
    [self.commentsArray removeAllObjects];
    NSArray *arry = [StuProfileComments loadCommentsWithJobId:self.oneJob.jobId IsArranged:self.oneJob.isAgent CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize]];
    [self.commentsArray addObjectsFromArray:arry];
    
    [self.commentsTableView reloadData];
    [self.refresh endRefreshing];
    
    if (arry != nil && arry.count != 0) {
        self.currentPage++;
    }
}

- (void)loadMoreJobs
{
    //当显示的小于10条数据的时候上拉加载不起作用，只有下拉可以显示最新的10条数据，为了防止在程序第一次启动的时候同时条用下拉和上拉接口，导致数据重复，上拉接口是根据footerviewer的位置来显示的，当数据太少的时候第一次启动会导致同时加载下拉和上拉
    if (self.commentsArray.count < 10) {
        return;
    }
    NSArray *arry = [StuProfileComments loadCommentsWithJobId:self.oneJob.jobId IsArranged:self.oneJob.isAgent CurrentPage:[NSString stringWithFormat:@"%d", self.currentPage] PageSize:[NSString stringWithFormat:@"%d", pageSize]];
    [self.commentsArray addObjectsFromArray:arry];
    
    [self.commentsTableView reloadData];
    self.currentPage++;
}

#pragma tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuProfileComments *comment = self.commentsArray[indexPath.row];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:textFontSize];
    CGFloat contentH = [comment.commentsContent boundingRectWithSize:CGSizeMake(screenFrame.size.width-125, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    return contentH+56;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuProfileCommentsTableViewCell *cell = [StuProfileCommentsTableViewCell cellFromNibWithTableView:tableView];
    StuProfileComments *comment = self.commentsArray[indexPath.row];
    cell.commentsName.text = comment.commentsName;
    cell.commentsDate.text = comment.commentsDate;
    cell.commentsContent.text = comment.commentsContent;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        self.label.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        self.label.hidden = NO;
    }
    return YES;
}
//
//- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
//{
//    NSLog(@"touchesBegan");
//    [self.commentsTextView endEditing:YES];
//    UIViewController *vc = [[UIViewController alloc]init];
//}

- (void)commentsTextViewDismissKeyboard {
    [self.commentsTextView resignFirstResponder];
}

- (void)commentsBtnClick
{
    if ([StuProfileComments pushCommentsWithSessionId:globalSessionId JobId:self.oneJob.jobId Content:self.commentsTextView.text MemberAttr:@"1"]) {
        self.commentsTextView.text = nil;
        [self loadNewJobs];
    }
    else
    {
        [MBProgressHUD showError:@"发表失败"];
    }
    
}

@end
