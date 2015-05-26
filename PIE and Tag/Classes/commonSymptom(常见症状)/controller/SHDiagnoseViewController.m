//
//  SHDiagnoseViewController.m
//  PIE and Tag
//
//  Created by 黄少华 on 15/5/26.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHDiagnoseViewController.h"
#import "Masonry.h"
#import "SHToolView.h"
#import "SHReportView.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kToolViewHeight 45.f
@interface SHDiagnoseViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) SHReportView *reportScrollView;//病历卡
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SHToolView  *toolView;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SHDiagnoseViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupUI];
}

- (void)setupUI
{
    WS(ws);
    //添加病历卡
    [self.view addSubview:self.reportScrollView];
    self.reportScrollView.backgroundColor = [UIColor redColor];
    [self.reportScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    //添加tableview
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView *superView = self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(superView).with.insets(UIEdgeInsetsMake(0, 0, kToolViewHeight, 0));
    }];
    
    //添加toolview
    [self.view addSubview:self.toolView];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.tableView.mas_bottom);
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
        make.bottom.equalTo(ws.view.mas_bottom);
    }];
}


#pragma mark - 事件响应



#pragma mark - 私有方法



#pragma mark - delegate & datesource
#pragma UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
#pragma mark - getters & setters

- (SHReportView *)reportScrollView
{
    if (_reportScrollView == nil) {
        _reportScrollView = [[SHReportView alloc] init];
    }
    return _reportScrollView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (SHToolView *)toolView
{
    if (!_toolView) {
        _toolView.backgroundColor = [UIColor grayColor];
        _toolView = [SHToolView toolView];
    }
    return _toolView;
}
@end
