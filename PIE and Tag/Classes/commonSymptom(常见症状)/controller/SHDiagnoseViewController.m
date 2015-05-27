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
#import "SHChatTableViewCell.h"
#import "SHMessageFrame.h"
#import "SHMessage.h"
#import "UIColor+HexColor.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kToolViewHeight 45.f
@interface SHDiagnoseViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SHToolView  *toolView;

@property (nonatomic, strong) SHReportView *reportView;
@property (nonatomic, strong) NSMutableArray *messageFrames;

@end

@implementation SHDiagnoseViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupUI];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboadrFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardHeight = keyboadrFrame.size.height;
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:7 << 16 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration delay:0 options:7 << 16 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:nil];
}


- (void)setupUI
{
    WS(ws);
    
    //添加tableview
    [self.view addSubview:self.tableView];
    UIView *superView = self.view;
    
    SHReportView *reportView = [[SHReportView alloc] init];
    self.reportView          = reportView;
    [reportView setNeedsLayout];
    [reportView layoutIfNeeded];
    CGFloat height = [reportView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"hhhhhhh == %f",height);
    reportView.height = height;
    self.tableView.tableHeaderView = reportView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(superView).with.insets(UIEdgeInsetsMake(0, 0, kToolViewHeight, 0));
    }];

    
    //添加toolview
    [self.view addSubview:self.toolView];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(ws.tableView.mas_bottom);
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
        make.bottom.equalTo(ws.view.mas_bottom);
    }];
}

- (void)loadData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    NSString *previousTime = nil;
    
    for (NSDictionary *dict in array) {
        SHMessageFrame *messageFrame = [[SHMessageFrame alloc] init];
        SHMessage *message = [[SHMessage alloc] init];
        message.dict = dict;
        messageFrame.showTime = ![previousTime isEqualToString:message.time];
        messageFrame.message = message;
        previousTime = message.time;
        [self.messageFrames addObject:messageFrame];
    }

}


#pragma mark - 事件响应



#pragma mark - 私有方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchBegan");
}


#pragma mark - delegate & datesource
#pragma UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *ID = @"cell";
    SHChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SHChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.messageFrame = self.messageFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.messageFrames[indexPath.row] cellHeight];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark - getters & setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor= [UIColor colorWithHexString:@"#e0e0e0"];

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

- (NSMutableArray *)messageFrames
{
    if (_messageFrames == nil) {
        _messageFrames = [NSMutableArray array];
    }
    return _messageFrames;
}
@end
