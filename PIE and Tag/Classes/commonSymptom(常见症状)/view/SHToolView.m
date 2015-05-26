//
//  SHToolView.m
//  疾病助手
//
//  Created by 黄少华 on 15/5/12.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import "SHToolView.h"

@implementation SHToolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)toolView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SHToolView" owner:nil options:nil] lastObject];
}

@end
