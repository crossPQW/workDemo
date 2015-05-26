//
//  SHReportTableViewCell.m
//  PIE and Tag
//
//  Created by 黄少华 on 15/5/26.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHReportView.h"
#import "Masonry.h"

#define kBaseInfoFont 14.f
#define kpadding 10.f
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface SHReportView()

/**
 *  底部的提示
 */
@property (nonatomic, strong) UIButton *tipBtn;
/**
 *  保存所有信息的view
 */
@property (nonatomic, strong) UIView *infomationView;
@property (nonatomic, strong) UIImageView *userImage;
@property (nonatomic, strong) NSArray *array;
@end

@implementation SHReportView


- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupTip];//提示tips
        [self setupContentView];//内容view
    }
    return self;
}


- (void)setupContentView
{
    WS(ws);
    //添加背景
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MessageContent_TimeNodeBkg"]];
    UIView *infomationView = [[UIView alloc] init];
    self.infomationView = infomationView;
    [self addSubview:infomationView];
    [infomationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.tempView.mas_top).with.offset(kpadding);
        make.left.equalTo(ws.tempView.mas_left).with.offset(kpadding);
        make.right.equalTo(ws.tempView.mas_right).with.offset(-kpadding);
        make.bottom.equalTo(ws.tipBtn.mas_top).with.offset(-kpadding);
    }];
    
    //基本信息
    [self setupBaseInfo];
    //追加信息
    [self setupOtherInfo];
}

- (void)setupBaseInfo
{
    WS(ws);
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"您的基本信息"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font     = [UIFont systemFontOfSize:kBaseInfoFont];
    [self.bgImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.bgImageView.mas_top).with.offset(kpadding);
        make.left.equalTo(ws.bgImageView.mas_left);
        make.right.equalTo(ws.bgImageView.mas_right);
        make.height.equalTo(@20);
    }];
    
    //年龄
    UILabel *ageLabel   = [[UILabel alloc] init];
    ageLabel.text       = @"年龄:  8";
    [self.bgImageView addSubview:ageLabel];
    ageLabel.font       = [UIFont systemFontOfSize:kBaseInfoFont];
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bgImageView.mas_left).with.offset(kpadding);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(kpadding);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    //性别
    UILabel *sexLabel   = [[UILabel alloc] init];
    sexLabel.text       = @"性别:  女";
    [self.bgImageView addSubview:sexLabel];
    sexLabel.font       = [UIFont systemFontOfSize:kBaseInfoFont];
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ageLabel.mas_right).with.offset(kpadding);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(kpadding);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    //出现症状
    UILabel *symptomLabel   = [[UILabel alloc] init];
    symptomLabel.text       = @"出现症状: 发烧,头痛.";
    [self.bgImageView addSubview:symptomLabel];
    symptomLabel.font       = [UIFont systemFontOfSize:kBaseInfoFont];
    [symptomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bgImageView.mas_left).with.offset(kpadding);
        make.top.equalTo(ageLabel.mas_bottom).with.offset(kpadding);
        make.size.mas_equalTo(CGSizeMake(300, 20));
    }];
    
    //补充信息
    UILabel *addInfoLabel   = [[UILabel alloc] init];
    addInfoLabel.text       = @"补充信息:感觉身体发高烧,高烧到头疼,但是测体温不高,这是怎么回事?";
    [self.bgImageView addSubview:addInfoLabel];
    addInfoLabel.numberOfLines = 0;
    addInfoLabel.font       = [UIFont systemFontOfSize:kBaseInfoFont];
    [addInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bgImageView.mas_left).with.offset(kpadding);
        make.top.equalTo(symptomLabel.mas_bottom);
        CGSize size = [addInfoLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200,10000.0f) lineBreakMode:0];
        make.right.equalTo(ws.bgImageView.mas_right).with.offset(-kpadding);
        make.height.mas_equalTo(size.height);
    }];
    
    //添加照片
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.userImage = imageView;
        imageView.image        = [UIImage imageNamed:@"4490836_20140324_104207_473.jpg"];
        [self.bgImageView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kpadding + (kpadding + 40) * i);
            make.top.equalTo(addInfoLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    
}

- (void)setupOtherInfo
{
    WS(ws);
    
}



- (void)setupTip{
    WS(ws);
    //创建提示按钮
    UIButton *tipBtn       = [[UIButton alloc] init];
    self.tipBtn            = tipBtn;
    tipBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [tipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [tipBtn setTitle:@"根据您的病情分析,还需要了解一些您的其他信息" forState:UIControlStateNormal];
    tipBtn.enabled         = NO;
    UIImage *image         = [UIImage imageNamed:@"MessageContent_TimeNodeBkg"];
    [tipBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5] forState:UIControlStateNormal];
    [self addSubview:tipBtn];
    [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize size        = [tipBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:nil size:12]}];
        make.centerX.mas_equalTo(ws.mas_centerX);
        make.size.mas_equalTo(size);
        make.bottom.equalTo(ws.mas_bottom).with.offset(-kpadding);
    }];
}


- (NSArray *)array
{
    if (!_array) {
        _array = @[@[@"Q:您发烧体温多少度?",@"A:测的不到38度"],
                   @[@"Q:您头痛时是间歇性还是持续性的?",@"A:持续性的,感觉一直疼"]
                   ];
    }
    return _array;
}
@end
