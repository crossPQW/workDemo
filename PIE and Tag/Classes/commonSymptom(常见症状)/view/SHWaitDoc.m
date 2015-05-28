//
//  SHWaitDoc.m
//  PIE and Tag
//
//  Created by 黄少华 on 15/5/28.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHWaitDoc.h"
#import "Masonry.h"
#import "SHClockBtn.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


@interface SHWaitDoc()

@property (nonatomic, strong) NSTimer *myTimer;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *contentView;
@end
@implementation SHWaitDoc


- (instancetype)init
{
    if (self = [super init]) {
        
        WS(ws);
        self.backgroundColor = [UIColor clearColor];
        
        
        [self setupTimer];
        
        //所有内容的view
        UIView *contentView            = [[UIView alloc] init];
        self.contentView               = contentView;
        [self addSubview:contentView];
        contentView.backgroundColor    = [UIColor whiteColor];
        contentView.layer.cornerRadius = 6.f;
        contentView.layer.borderColor  = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        contentView.layer.masksToBounds= YES;
        contentView.layer.borderWidth  = 1.f;
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.mas_top).offset(10.f);
            make.left.equalTo(ws.mas_left).offset(15.f);
            make.right.equalTo(ws.mas_right).offset(-15.f);
            make.bottom.equalTo(ws.mas_bottom).offset(-10.f);
        }];
        
#pragma mark - 等待文字
        UILabel *label = [[UILabel alloc] init];
        self.label     = label;
        if (![self.myTimer isValid]) {
            [self.myTimer fire];
            //开启定时器
            [self.myTimer setFireDate:[NSDate distantPast]];
        }
        int number = 5;
        label.text = [NSString stringWithFormat:@"您前面有%d人等候\n等待时间预计20分钟",number];
        label.numberOfLines = 0;
        label.textColor= kblackColor;
        label.font     = [UIFont systemFontOfSize:15.f];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:label.text];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#f74507"] range:NSMakeRange(4, 1)];
        label.attributedText = attr;
        [contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).offset(20.f);
            make.left.equalTo(contentView.mas_left).offset(40.f);
        }];
        
        
        //分割线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        [contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView);
            make.right.equalTo(contentView);
            make.top.equalTo(label.mas_bottom).offset(20.f);
            make.height.mas_equalTo(@1);
        }];
        
        
        SHClockBtn *clockBtn = [[SHClockBtn alloc] init];
        [clockBtn setImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];
        [clockBtn setTitle:@"提醒我" forState:UIControlStateNormal];
        [contentView addSubview:clockBtn];
        [clockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.right.equalTo(contentView.mas_right).offset(-40.f);
        }];
        
        UILabel *genjuLabel      = [[UILabel alloc] init];
        genjuLabel.text          = @"根据您的病情,建议您找专家问诊";
        genjuLabel.textColor     = kblackColor;
        genjuLabel.font          = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        [contentView addSubview:genjuLabel];
        genjuLabel.textAlignment = NSTextAlignmentCenter;
        [genjuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView.mas_left).offset(37.f);
            make.top.equalTo(lineView.mas_bottom).offset(20.f);
        }];
        
        UILabel *quanweiLabel      = [[UILabel alloc] init];
        quanweiLabel.text          = @"权威专家,立即接诊";
        quanweiLabel.textColor     = kgrayColor;
        quanweiLabel.font          = [UIFont systemFontOfSize:14.f];
        [contentView addSubview:quanweiLabel];
        quanweiLabel.textAlignment = NSTextAlignmentCenter;
        [quanweiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(genjuLabel);
            make.top.equalTo(genjuLabel.mas_bottom).offset(8.f);
        }];
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.text     = @"￥5";
        priceLabel.textColor= [UIColor colorWithHexString:@"#f74507"];
        priceLabel.font     = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
        [contentView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(quanweiLabel.mas_bottom).offset(25.f);
            make.left.equalTo(quanweiLabel);
            make.bottom.equalTo(contentView.mas_bottom).offset(-62);
        }];
        
        UILabel *buyCountLabel = [[UILabel alloc] init];
        [contentView addSubview:buyCountLabel];
        buyCountLabel.text     = @"2548人购买";
        buyCountLabel.font     = [UIFont systemFontOfSize:12.f];
        buyCountLabel.textColor= kgrayColor;
        [buyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceLabel.mas_right).offset(11.f);
            make.bottom.equalTo(priceLabel.mas_bottom);
        }];
        
        //购买按钮
        UIButton *buyButton           = [[UIButton alloc] init];
        self.buyButton                = buyButton;
        [buyButton setTitle:@"购买" forState:UIControlStateNormal];
        [buyButton setTitleColor:[UIColor colorWithHexString:@"#f74507"] forState:UIControlStateNormal];
        buyButton.layer.borderColor   = [UIColor colorWithHexString:@"#f74507"].CGColor;
        buyButton.layer.borderWidth   = 1.f;
        buyButton.layer.cornerRadius  = 4.f;
        buyButton.layer.masksToBounds = YES;
        [contentView addSubview:buyButton];
        [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 35));
            make.right.equalTo(contentView.mas_right).offset(- 37);
            make.bottom.equalTo(priceLabel.mas_bottom).offset(22);
        }];
    }
    return self;
}


- (void)setupTimer
{
    CGFloat timeInterval = 1;
    
    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:(timeInterval) target:self selector:@selector(changeTitle) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:myTimer forMode:NSRunLoopCommonModes];
    self.myTimer = myTimer;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTimer invalidate];  //  销毁定时器
    });
}

- (void)changeTitle
{
    static int j = 5;
    NSLog(@"哈哈哈哈哈哈");
   self.label.text = [NSString stringWithFormat:@"您前面有%d人等候\n等待时间预计20分钟",j];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.label.text];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#f74507"] range:NSMakeRange(4, 1)];
    self.label.attributedText = attr;
    j --;
    
    if (j == 0) {
        if ([self.delegate respondsToSelector:@selector(waitDoc:)]) {
            [self.delegate waitDoc:self];
        }
    }
}



@end
