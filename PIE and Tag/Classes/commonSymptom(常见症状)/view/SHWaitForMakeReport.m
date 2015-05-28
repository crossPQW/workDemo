//
//  SHWaitForMakeReport.m
//  PIE and Tag
//
//  Created by 黄少华 on 15/5/28.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHWaitForMakeReport.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@implementation SHWaitForMakeReport

- (instancetype)init
{
    if (self = [super init]) {
        WS(ws);
        self.backgroundColor = [UIColor clearColor];
        UIButton *tipBtn       = [[UIButton alloc] init];
        [self addSubview:tipBtn];
        tipBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [tipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [tipBtn setTitle:@"根据您之前的描述,为您生成新的病例" forState:UIControlStateNormal];
        
        tipBtn.enabled         = NO;
        UIImage *image         = [UIImage imageNamed:@"MessageContent_TimeNodeBkg"];
        [tipBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5] forState:UIControlStateNormal];
        CGSize size        = [tipBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:nil size:13]}];
        [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.mas_top).offset(20);
            make.centerX.equalTo(ws);
            make.width.mas_equalTo(size.width);
        }];
        
        UIActivityIndicatorView *iv = [[UIActivityIndicatorView alloc] init];
        [iv startAnimating];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipBtn.mas_bottom).offset(20);
            make.centerX.equalTo(ws);
            make.height.mas_equalTo(@10);
            make.bottom.equalTo(ws.mas_bottom).offset(-40);
        }];
    }
    return self;
}


@end
