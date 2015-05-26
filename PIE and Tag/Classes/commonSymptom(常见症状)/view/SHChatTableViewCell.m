//
//  SHChatTableViewCell.m
//  疾病助手
//
//  Created by 黄少华 on 15/5/12.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import "SHChatTableViewCell.h"
#import "SHMessage.h"
#import "SHMessageFrame.h"
@interface SHChatTableViewCell()


@end
@implementation SHChatTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //时间
        self.selectedBackgroundView = [[UIView alloc] init];
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *timeBtn = [[UIButton alloc] init];
        self.timeBtn = timeBtn;
        [timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        timeBtn.enabled = NO;
        UIImage *image = [UIImage imageNamed:@"MessageContent_TimeNodeBkg"];
        [timeBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5] forState:UIControlStateNormal];
        [self.contentView addSubview:_timeBtn];
        
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [self.contentView addSubview:iconView];

        //正文
        UIButton *contentBtn = [[UIButton alloc] init];
        self.contentBtn = contentBtn;
        [contentBtn setTitleColor:[UIColor colorWithRed:154/255 green:154/255 blue:154/255 alpha:1.f] forState:UIControlStateNormal];
        contentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        contentBtn.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:contentBtn];
    }
    return self;
}

- (void)setMessageFrame:(SHMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    SHMessage *message = messageFrame.message;
    
    [_timeBtn setTitle:message.time forState:UIControlStateNormal];
    _timeBtn.frame = _messageFrame.timeF;
    
    _iconView.image = [UIImage imageNamed:@"EPackageTusijiImage"];
    _iconView.frame = _messageFrame.iconF;
    
    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 15, 10);
    
    UIImage *normal, *focused;
    if (message.type == MessageTyeMe) {
        normal = [UIImage imageNamed:@"SenderTextNodeBkg"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"SenderTextNodeBkgHL"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }else{
        normal = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"ReceiverTextNodeBkgHL"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBtn setBackgroundColor:[UIColor blueColor]];
    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
    _contentBtn.frame = messageFrame.contentF;

}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
@end
