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
#import "SHWaitForMakeReport.h"
#import "SHWaitDoc.h"
#import "SHFindSuitableDoc.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kToolViewHeight 45.f
@interface SHDiagnoseViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SHWaitDocDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SHToolView  *toolView;

@property (nonatomic, strong) SHReportView *reportView;
///messageframe模型数组
@property (nonatomic, strong) NSMutableArray *messageFrames;
///所有提问数组
@property (nonatomic, strong) NSMutableArray *questions;

@property (nonatomic, assign) BOOL isDoct;
//医生所有提问
//@property (nonatomic, strong) NSMutableArray *doctQuestions;
@end

@implementation SHDiagnoseViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.isDoct = NO;
    [self setupUI];
    
//    [self loadData];
    _questions = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    [self loadQuestion];
    
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
    [self addAnimationWithView:reportView];
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


- (void)loadQuestion{
    NSString *question = [self.questions firstObject];
    [self addMessageWithContent:question withType:MessageTyeOther];
    [self.tableView reloadData];
    
    if (self.questions.count > 0) {
        [self.questions removeObjectAtIndex:0];
    }else{
        return;
    }
}

//- (void)loadDoctQuestion{
//    NSString *question = [self.doctQuestions firstObject];
//    [self addMessageWithContent:question withType:MessageTyeOther];
//    [self.tableView reloadData];
//    
//    if (self.doctQuestions.count > 0) {
//        [self.doctQuestions removeObjectAtIndex:0];
//    }else{
//        return;
//    }
//}



#pragma mark - 事件响应
//购买
- (void)buy:(UIButton *)button
{
    
}

#pragma mark - 私有方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchBegan");
}


- (void)addMessageWithContent:(NSString *)content withType:(MessageTye)messageType{
    
    SHMessageFrame *mf = [[SHMessageFrame alloc] init];
    SHMessage *msg = [[SHMessage alloc] init];
    msg.content = content;
    msg.icon = @"icon01.png";
    msg.type = messageType;
    mf.message = msg;
    
    [self.messageFrames addObject:mf];
}

//生成病例
- (void)makeReport
{
    SHWaitForMakeReport *waitView = [[SHWaitForMakeReport alloc] init];
    [waitView setNeedsLayout];
    [waitView layoutIfNeeded];
    CGFloat height = [waitView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    waitView.height = height;
    self.tableView.tableFooterView = waitView;
    
    //两秒后更新header跟footer
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //清空数据
        [self.messageFrames removeAllObjects];
        
        //更新header
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"111"];
        imageView.frame = CGRectMake(15, 20, screenWidth - 30, 360);
        [view addSubview:imageView];
        view.height= 380;
        self.tableView.tableHeaderView = view;
        
        //更换footer
        SHWaitDoc *waitDoc = [[SHWaitDoc alloc] init];
        waitDoc.delegate   = self;
        [waitDoc setNeedsDisplay];
        [waitDoc layoutIfNeeded];
        CGFloat newheight = [waitDoc systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        waitDoc.height = newheight;
        
        self.tableView.tableFooterView = waitDoc;
        
        [self.tableView reloadData];
        
        [waitDoc.buyButton addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    });
}

//添加动画
- (void)addAnimationWithView:(UIView *)view{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.fromValue = @-200;
    
    animation.toValue  = @0;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [view.layer addAnimation:animation forKey:@"transform"];
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0) {return NO;}
    
    
    [self addMessageWithContent:textField.text withType:MessageTyeMe];
    [self.tableView reloadData];
    
    
    //延迟1秒加载护士问题
    if (self.questions.count > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadQuestion];
        });
#pragma mark 回答完成开始生成病例
    }else if(self.isDoct == NO){
        NSLog(@"开始生成病例");
        [self.view endEditing:YES];
        [self makeReport];
    }else{
        NSLog(@"医生问完了");
    }
    
    
    if (self.messageFrames.count >1) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageFrames.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    textField.text = nil;
    
    return YES;
}

#pragma mark SHWaitDocDelegate
#pragma mark 倒计时完成,开始跳入医生咨询页
- (void)waitDoc:(SHWaitDoc *)waitDoc
{
    SHFindSuitableDoc *findSuitDoc = [[SHFindSuitableDoc alloc] init];
    [self addAnimationWithView:findSuitDoc];
    [findSuitDoc setNeedsLayout];
    [findSuitDoc layoutIfNeeded];
    CGFloat height = [findSuitDoc systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    findSuitDoc.height = height;
    self.tableView.tableHeaderView = findSuitDoc;
    
    //去掉footer
    UIView *view = [[UIView alloc] init];
    view.height = 0.f;
    self.tableView.tableFooterView = view;
    
    self.isDoct = YES;
#pragma mark 医患对话
    [self.questions removeAllObjects];
    self.questions = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    [self loadQuestion];
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
        _toolView.inputField.delegate = self;
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
