//
//  SHFindSuitableDoc.m
//  PIE and Tag
//
//  Created by 黄少华 on 15/5/28.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHFindSuitableDoc.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@implementation SHFindSuitableDoc

- (instancetype)init
{
    if (self = [super init]) {
        WS(ws);
        UIImageView *nurseIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2532-1211191425230-L.jpg"]];
        [self addSubview:nurseIcon];
        nurseIcon.layer.masksToBounds = YES;
        nurseIcon.layer.cornerRadius  = 20.f;
        nurseIcon.layer.borderColor   = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        nurseIcon.layer.borderWidth   = 1.f;
        [nurseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.mas_left).offset(10.f);
            make.top.equalTo(ws.mas_top).offset(20.f);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        UILabel *hushilabel = [[UILabel alloc] init];
        hushilabel.text     = @"小护士";
        hushilabel.textColor= kgrayColor;
        hushilabel.font     = [UIFont systemFontOfSize:12];
        [self addSubview:hushilabel];
        [hushilabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(nurseIcon.mas_centerX);
            make.top.equalTo(nurseIcon.mas_bottom).offset(5);
        }];
        
        
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:kblackColor forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        [button setTitle:@"已经为您找到了合适的医生" forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"white"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.7];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:nil size:14]};
        CGSize contentSize = [button.titleLabel.text sizeWithAttributes:attributes];
        NSLog(@"%@",NSStringFromCGSize(contentSize));
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nurseIcon.mas_right).offset(5.f);
            make.top.equalTo(ws.mas_top).offset(20.f);
            make.size.mas_equalTo(CGSizeMake(contentSize.width + 30, contentSize.height + 30));
        }];
        
        UIImageView *cardView = [[UIImageView alloc] init];
        cardView.image = [UIImage imageNamed:@"D766E9DC-B275-4F33-9D96-FA90A5A9B328.jpg"];
        cardView.backgroundColor = [UIColor whiteColor];
        cardView.layer.cornerRadius = 6.f;
        cardView.layer.borderColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        cardView.layer.masksToBounds = YES;
        cardView.layer.borderWidth = 1.f;
        [self addSubview:cardView];
        [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.mas_centerX);
            make.top.equalTo(button.mas_bottom).offset(10.f);
            make.size.mas_equalTo(CGSizeMake(230, 80));
        }];
        
        
        
        UIButton *timeBtn = [[UIButton alloc] init];
        timeBtn.layer.cornerRadius = 3.f;
        
        [self addSubview:timeBtn];
        [timeBtn setTitle:@"18:00" forState:UIControlStateNormal];
        NSDictionary *timeAttr = @{NSFontAttributeName:[UIFont fontWithName:nil size:12]};
        CGSize timeSize = [timeBtn.titleLabel.text sizeWithAttributes:timeAttr];
        timeBtn.titleEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [timeBtn setBackgroundColor:[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:0.17f]];
        [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cardView.mas_bottom).offset(20.f);
            make.centerX.equalTo(ws.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(timeSize.width + 10, timeSize.height + 10));
            make.bottom.equalTo(ws.mas_bottom).offset(-10);
        }];
        
    }
    return self;
}

@end
