//
//  SHReportTableViewCell.m
//  PIE and Tag
//
//  Created by 黄少华 on 15/5/26.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHReportView.h"
#import "Masonry.h"
#import "UIColor+HexColor.h"
#define kBaseInfoFont 14.f
#define kpadding 10.f
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface SHReportView()

@property (nonatomic, strong) UIImageView *userImage;
@property (nonatomic, strong) NSArray *array;
@end

@implementation SHReportView


- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupContentView];//内容view
        [self setupTip];//提示tips
    }
    return self;
}

//所有的内容
- (void)setupContentView
{
    WS(ws);
    //添加包含所有内容的view
    UIView *infomationView = [[UIView alloc] init];
    infomationView.backgroundColor = [UIColor whiteColor];
    infomationView.layer.cornerRadius = 6.f;
    infomationView.layer.borderColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
    infomationView.layer.masksToBounds = YES;
    infomationView.layer.borderWidth = 1.f;
    self.infomationView = infomationView;
    [self addSubview:infomationView];
    
    [infomationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top).with.offset(kpadding);
        make.left.equalTo(ws.mas_left).with.offset(15);
        make.right.equalTo(ws.mas_right).with.offset(-15);
    }];
    
    //基本信息
    [self setupBaseInfo];

}

- (void)setupBaseInfo
{
    WS(ws);
    //保存所有基本信息
    UIView *basicInfoView         = [[UIView alloc] init];
    basicInfoView.backgroundColor = [UIColor clearColor];
    self.basicInfoView            = basicInfoView;
    [self.infomationView addSubview:basicInfoView];
    [basicInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.infomationView.mas_top);
        make.left.equalTo(ws.infomationView.mas_left);
        make.right.equalTo(ws.infomationView.mas_right);
        make.bottom.equalTo(ws.infomationView.mas_bottom).offset(-kpadding);
    }];

    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"您的基本情况"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font     = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    titleLabel.textColor= kblackColor;
    [basicInfoView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(basicInfoView.mas_top).with.offset(kpadding);
        make.left.equalTo(basicInfoView.mas_left);
        make.right.equalTo(basicInfoView.mas_right);
    }];

    //年龄
    UILabel *ageLabel   = [[UILabel alloc] init];
    ageLabel.text      = @"年龄: 8";
    ageLabel.textColor = kblackColor;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ageLabel.text];
    [attr addAttribute:NSForegroundColorAttributeName value:kgrayColor range:NSMakeRange(0, 3)];
    ageLabel.attributedText = attr;
    [basicInfoView addSubview:ageLabel];
    ageLabel.font      = [UIFont systemFontOfSize:14.f];
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(basicInfoView.mas_left).with.offset(kpadding);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(kpadding);
    }];

    //性别
    UILabel *sexLabel   = [[UILabel alloc] init];
    sexLabel.text      = @"性别: 女";
    sexLabel.textColor = kblackColor;
    NSMutableAttributedString *sexAttr = [[NSMutableAttributedString alloc] initWithString:sexLabel.text];
    [sexAttr addAttribute:NSForegroundColorAttributeName value:kgrayColor range:NSMakeRange(0, 3)];
    sexLabel.attributedText = sexAttr;
    [basicInfoView addSubview:sexLabel];
    sexLabel.font      = [UIFont systemFontOfSize:kBaseInfoFont];
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ageLabel.mas_right).with.offset(kpadding);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(kpadding);
    }];

    //出现症状
    UILabel *symptomLabel   = [[UILabel alloc] init];
    symptomLabel.text      = @"出现症状: 发烧,头痛.";
    symptomLabel.textColor = kblackColor;
    NSMutableAttributedString *symAttr = [[NSMutableAttributedString alloc] initWithString:symptomLabel.text];
    [symAttr addAttribute:NSForegroundColorAttributeName value:kgrayColor range:NSMakeRange(0, 5)];
    symptomLabel.attributedText = symAttr;
    symptomLabel.numberOfLines = 0;
    [basicInfoView addSubview:symptomLabel];
    symptomLabel.font      = [UIFont systemFontOfSize:kBaseInfoFont];
    [symptomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ageLabel.mas_bottom).with.offset(kpadding);
        make.centerX.equalTo(ws.mas_centerX);
        make.width.mas_equalTo(screenWidth - kpadding * 4);

    }];

    //补充信息
    UILabel *addInfoLabel   = [[UILabel alloc] init];
    addInfoLabel.text      = @"补充信息: 感觉身体发高烧,高烧到头疼,但是测体温不高,这是怎么回事?";
    addInfoLabel.textColor = kblackColor;
    NSMutableAttributedString *addLabel = [[NSMutableAttributedString alloc] initWithString:addInfoLabel.text];
    [addLabel addAttribute:NSForegroundColorAttributeName value:kgrayColor range:NSMakeRange(0, 5)];
    addInfoLabel.attributedText = addLabel;
    [basicInfoView addSubview:addInfoLabel];
    addInfoLabel.numberOfLines = 0;
    addInfoLabel.font      = [UIFont systemFontOfSize:kBaseInfoFont];
    [addInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.mas_centerX);
        make.width.mas_equalTo(screenWidth - kpadding * 4);
        make.top.equalTo(symptomLabel.mas_bottom).offset(kpadding);
    }];
//
    //添加照片
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.userImage = imageView;
        imageView.image        = [UIImage imageNamed:@"20131017210454_W5HnG"];
        [basicInfoView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kpadding + (kpadding + 40) * i);
            make.top.equalTo(addInfoLabel.mas_bottom).offset(kpadding);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.bottom.equalTo(basicInfoView.mas_bottom).offset(-kpadding);
        }];
    }
}

/**
 *  追加补充信息
 */
- (void)setupOtherInfo
{
    WS(ws);
    UIView *addInfoView = [[UIView alloc] init];
    self.addInfoView    = addInfoView;
    [self.infomationView addSubview:addInfoView];
    addInfoView.backgroundColor = [UIColor clearColor];
    [addInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.basicInfoView.mas_bottom).offset(kpadding);
        make.left.equalTo(ws.infomationView.mas_left).offset(kpadding);
        make.right.equalTo(ws.infomationView.mas_right);
        make.bottom.equalTo(ws.infomationView.mas_bottom).offset(-kpadding);
    }];

    //分割线
    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = [UIColor lightGrayColor];
    [addInfoView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addInfoView.mas_top);
        make.left.equalTo(addInfoView.mas_left);
        make.right.equalTo(addInfoView.mas_right);
        make.height.mas_equalTo(1);
//        make.bottom.equalTo(addInfoView.mas_bottom).offset(-kpadding);
    }];

    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text    = @"追加补充信息";
    titleLabel.font    = [UIFont systemFontOfSize:15];
    [addInfoView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLineView.mas_bottom);
        make.centerX.equalTo(ws.mas_centerX);
        make.width.mas_equalTo(screenWidth - kpadding * 4);
        make.bottom.equalTo(addInfoView.mas_bottom).offset(-kpadding);
    }];
    

    //添加QA
//    UIView *lastView = nil;
//    
//    for (int i = 0; i < self.array.count; i++) {
//        UIView *lineView = [[UIView alloc] init];
//        lineView.backgroundColor = [UIColor lightGrayColor];
//        [lineView addSubview:topLineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(addInfoView.mas_top);
//            make.left.equalTo(addInfoView.mas_left);
//            make.right.equalTo(addInfoView.mas_right);
//            make.height.mas_equalTo(0.5);
//        }];
//       
//    }

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
        CGSize size        = [tipBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:nil size:13]}];
        make.top.equalTo(ws.infomationView.mas_bottom).offset(kpadding);
        make.centerX.equalTo(ws.mas_centerX);
        make.size.mas_equalTo(size);
        make.bottom.equalTo(ws.mas_bottom).with.offset(-kpadding);
    }];
}



- (void)addInfoWithArray:(NSArray *)array
{
    WS(ws);
    UIView *addInfoView = [[UIView alloc] init];
    self.addInfoView    = addInfoView;
    [self.infomationView addSubview:addInfoView];
    addInfoView.backgroundColor = [UIColor clearColor];
    [addInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.basicInfoView.mas_bottom).offset(kpadding);
        make.left.equalTo(ws.infomationView.mas_left).offset(kpadding);
        make.right.equalTo(ws.infomationView.mas_right);
        make.bottom.equalTo(ws.infomationView.mas_bottom).offset(-kpadding);
    }];
    
    //分割线
    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = [UIColor lightGrayColor];
    [addInfoView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addInfoView.mas_top);
        make.left.equalTo(addInfoView.mas_left);
        make.right.equalTo(addInfoView.mas_right);
        make.height.mas_equalTo(1);
        //        make.bottom.equalTo(addInfoView.mas_bottom).offset(-kpadding);
    }];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text    = @"追加补充信息";
    titleLabel.font    = [UIFont systemFontOfSize:15];
    [addInfoView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLineView.mas_bottom);
        make.centerX.equalTo(ws.mas_centerX);
        make.width.mas_equalTo(screenWidth - kpadding * 4);
        make.bottom.equalTo(addInfoView.mas_bottom).offset(-kpadding);
    }];
    
    
    //添加QA
    //    UIView *lastView = nil;
    //
    //    for (int i = 0; i < self.array.count; i++) {
    //        UIView *lineView = [[UIView alloc] init];
    //        lineView.backgroundColor = [UIColor lightGrayColor];
    //        [lineView addSubview:topLineView];
    //        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.equalTo(addInfoView.mas_top);
    //            make.left.equalTo(addInfoView.mas_left);
    //            make.right.equalTo(addInfoView.mas_right);
    //            make.height.mas_equalTo(0.5);
    //        }];
    //       
    //    }

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
