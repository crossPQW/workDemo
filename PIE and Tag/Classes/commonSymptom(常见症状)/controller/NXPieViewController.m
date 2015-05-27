//
//  NXPieViewController.m
//  pieDemo
//
//  Created by linyibin on 15/5/19.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "NXPieViewController.h"
#import "VBPieChart.h"
#import "UIColor+HexColor.h"
#import "SKTagView.h"
#import "SKTagButton.h"
#import "MASConstraint.h"
#import "Masonry.h"
#import "SHDiagnoseViewController.h"
#define kTagViewH 100
#define kSecondTagViewH 100
#define kTagNum 1000

@interface NXPieViewController ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) VBPieChart *chart;

@property (nonatomic, strong) NSArray *chartValues;

@property (nonatomic, strong) SKTagView *tagView;

@property (nonatomic, strong) SKTagView *secondTagView;
/** 定时器，用于按时间间隔显示标签按钮 */
@property (nonatomic, strong) NSTimer *myTimer;

//保存上面所有tags
@property (nonatomic, strong) NSMutableArray *firstTags;

//保存下面的所有tags
@property (nonatomic, strong) NSMutableArray *secondTags;
//中间层,用来scrollview内部所有控件
@property (nonatomic, weak) UIView *tempView;
@end

@implementation NXPieViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    self.view.backgroundColor = [UIColor whiteColor];
//    //开启定时器
//    [self.myTimer setFireDate:[NSDate distantPast]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    //关闭定时器
//    [self.myTimer setFireDate:[NSDate distantFuture]];
}

- (void)loadView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setNeedsLayout];
    
    
    [self setupUI];
    
    [self setupTimer];
    
    [self setupRightItem];
}


- (void)setupRightItem
{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commit:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)commit:(UIButton *)btn
{
    SHDiagnoseViewController *diagnoseVc = [[SHDiagnoseViewController alloc] init];
    diagnoseVc.title = @"病例";
    [self.navigationController pushViewController:diagnoseVc animated:YES];
//    testViewController *test = [[testViewController alloc] init];
//    [self.navigationController pushViewController:test animated:YES];
//    test.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupUI
{
    
    [self setupPieView];
    
    [self setupOptionSympotm];
    
    [self setupSymptom];
    
}

- (void)setupTimer
{
    CGFloat timeInterval = 5.0 / self.chartValues.count;
    
    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:(timeInterval) target:self selector:@selector(showTagButton) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:myTimer forMode:NSRunLoopCommonModes];
    self.myTimer = myTimer;
    //    if (![self.myTimer isValid]) {
    ////        [self.myTimer fire];
    //        //开启定时器
    //        [self.myTimer setFireDate:[NSDate distantPast]];
    //    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTimer invalidate];  //  销毁定时器
    });
}

/**
 *  创建饼状图
 */
- (void)setupPieView{
    __weak NXPieViewController *weakSelf = self;
    
    //中间层的view,用来存放scrollview内部所有view
    UIView *temp = [[UIView alloc] init];
    self.tempView = temp;
    [self.view addSubview:temp];
    [temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view);
    }];
    
    
    if (!_chart) {
        _chart = [[VBPieChart alloc] init];
        [temp addSubview:_chart];
    }
    
    [_chart setFrame:CGRectMake(0, 0, 200, 200)];
    CGPoint tempCenter = self.view.center;
    tempCenter.y = tempCenter.y * 0.3;
    _chart.center = tempCenter;
    [_chart setEnableStrokeColor:YES];
    [_chart setHoleRadiusPrecent:0.3];
    
    [_chart.layer setShadowOffset:CGSizeMake(2, 2)];
    [_chart.layer setShadowRadius:3];
    [_chart.layer setShadowColor:[UIColor blackColor].CGColor];
    [_chart.layer setShadowOpacity:0.7];
    
    [_chart setHoleRadiusPrecent:0.3];
    
    self.chartValues = @[
                         @{@"name":@"胸闷", @"value":@50, @"color":[UIColor colorWithHex:0xdd191daa]},
                         @{@"name":@"气短", @"value":@20, @"color":[UIColor colorWithHex:0xd81b60aa]},
                         @{@"name":@"心慌", @"value":@20, @"color":[UIColor colorWithHex:0x8e24aaaa]},
                         @{@"name":@"头晕", @"value":@20, @"color":[UIColor colorWithHex:0x8e24aa4b]},
                         @{@"name":@"长期干咳", @"value":@70, @"color":[UIColor colorWithHex:0x3f51b5aa]}
                         ];
    
    [_chart setChartValues:_chartValues animation:YES];

}
/**
 *  创建可选的症状
 */
- (void)setupOptionSympotm{
    
    __weak NXPieViewController *weakSelf = self;

    //添加标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text     = @"点选您出现的症状 便于医生坐诊";
    titleLabel.font     = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range: NSMakeRange(9, 6)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(9, 6)];
    titleLabel.attributedText = attrStr;
    [titleLabel sizeToFit];
    [self.tempView addSubview:titleLabel];
    titleLabel.frame   = CGRectMake(0, CGRectGetMaxY(self.chart.frame), screenWidth, 25);
    
    
    //添加第一个tagView
    self.tagView = ({
        SKTagView *tagView = [[SKTagView alloc] init];
        weakSelf.tagView   = tagView;
        tagView.backgroundColor = [UIColor clearColor];
        tagView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
        tagView.insets     = 10;
        tagView.lineSpace  = 10;
        //点击了第一行的按钮
        tagView.didClickTagAtIndex = ^(NSUInteger index){
            SKTagButton *firstTagBtn    = self.firstTags[index];//上面的按钮
            SKTagButton *secondTagBtn   = self.secondTags[index];//下面的按钮
            firstTagBtn.titleLabel.textColor = [UIColor lightGrayColor];
            secondTagBtn.titleLabel.textColor= [UIColor blackColor];
        };
        tagView;
    });
    
    [self.tempView addSubview:self.tagView];
    //添加第一个tagview的约束
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        UIView *supView = self.view;
        UIView *superView = self.tempView;
        make.top.equalTo(titleLabel.mas_bottom);
        make.width.equalTo(superView.mas_width);
        make.leading.equalTo(superView.mas_leading).with.offset(0);
        make.trailing.equalTo(superView.mas_trailing);
    }];
    
    //添加第一组tag
    for (int i = 0; i < self.chartValues.count; i++) {
        NSDictionary *dict = self.chartValues[i];
        SKTag *tag = [SKTag tagWithText:dict[@"name"]];
        tag.textColor = [UIColor whiteColor];
        tag.fontSize  = 12;
        tag.padding   = UIEdgeInsetsMake(8, 8, 8, 8);
        UIColor *color= dict[@"color"];
        tag.bgColor   = color;
        tag.cornerRadius = 5;
        //  添加标签，用药标记每个不同的对象
        tag.tag = kTagNum + i;
        
        
        [self.tagView addTag:tag];
        
        //添加到数组
        for (SKTagButton *tagBtn in self.tagView.subviews) {
            if ([tagBtn isKindOfClass:[SKTagButton class]]) {

                //  设置每个button的初始为不可见，之后按照时间间隔显示，产生动画的错觉
                tagBtn.hidden = YES;
                [self.firstTags insertObject:tagBtn atIndex:i];
            }
        }
    }

}
/**
 *  创建症状
 */
- (void)setupSymptom{
    
    __weak NXPieViewController *weakSelf = self;

    //添加标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text     = @"出现病症";
    titleLabel.font     = [UIFont systemFontOfSize:14];
    [titleLabel sizeToFit];
    [self.tempView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = weakSelf.tempView;
        make.width.equalTo(superView.mas_width);
        make.top.equalTo(weakSelf.tagView.mas_bottom);
        make.height.equalTo(@25);
    }];
    
    self.secondTagView = ({
        SKTagView *secondTagView = [[SKTagView alloc] init];
        weakSelf.secondTagView   = secondTagView;
        secondTagView.backgroundColor = [UIColor whiteColor];
        secondTagView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
        secondTagView.insets     = 10;
        secondTagView.lineSpace  = 10;
        //第二个view内部按钮点击事件
        secondTagView.didClickTagAtIndex = ^(NSUInteger index){
            SKTagButton *firstTagBtn     = self.firstTags[index];//上面的按钮
            SKTagButton *secondTagBtn    = self.secondTags[index];//下面得按钮
            NSDictionary *dict           = self.chartValues[index];
            
        };
        secondTagView;
    });
    
    [self.tempView addSubview:self.secondTagView];
    
    [self.secondTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *supView = self.view;
        make.top.equalTo(titleLabel.mas_bottom);
        make.width.equalTo(supView.mas_width);
        make.leading.equalTo(supView.mas_leading).with.offset(0);
        make.trailing.equalTo(supView.mas_trailing);
    }];
    
    
    for (int i = 0; i < self.chartValues.count; i++) {
        NSDictionary *dict = self.chartValues[i];
        SKTag *tag = [SKTag tagWithText:dict[@"name"]];
        tag.textColor = [UIColor lightGrayColor];
        tag.fontSize  = 12;
        tag.padding   = UIEdgeInsetsMake(8, 8, 8, 8);
        tag.bgColor   = [UIColor clearColor];
        tag.cornerRadius = 5;
        [self.secondTagView addTag:tag];
        
        //添加到数组
        for (SKTagButton *tagBtn in self.secondTagView.subviews) {
            if ([tagBtn isKindOfClass:[SKTagButton class]]) {
                [self.secondTags insertObject:tagBtn atIndex:i];
            }
        }
    }
    
    [self.tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.secondTagView.mas_bottom);
    }];

}


/** 显示隐藏的tag标签 */
- (void)showTagButton{
    static int j = 0;
   
            for (SKTagButton *tagBtn  in self.tagView.subviews) {
                if ((kTagNum + j) == tagBtn.tag) {
                    tagBtn.hidden = NO;
                }
            }
        j ++;
}



#pragma mark - getter & setter

- (NSMutableArray *)firstTags
{
    if (_firstTags == nil) {
        _firstTags = [NSMutableArray array];
    }
    return _firstTags;
}

- (NSMutableArray *)secondTags
{
    if (_secondTags == nil) {
        _secondTags = [NSMutableArray array];
    }
    return _secondTags;
}

- (void)dealloc{
}
@end

