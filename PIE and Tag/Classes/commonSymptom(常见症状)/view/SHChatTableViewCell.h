//
//  SHChatTableViewCell.h
//  疾病助手
//
//  Created by 黄少华 on 15/5/12.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHMessageFrame;
@interface SHChatTableViewCell : UITableViewCell
@property (nonatomic, weak) UIButton *timeBtn;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UIButton *contentBtn;
@property (nonatomic, strong) SHMessageFrame *messageFrame;
@end
