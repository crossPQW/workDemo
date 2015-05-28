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
        
//        UIButton *timeBtn = [[UIButton alloc] init];
//        self.timeBtn = timeBtn;
//        [timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        timeBtn.enabled = NO;
//        UIImage *image = [UIImage imageNamed:@"MessageContent_TimeNodeBkg"];
//        [timeBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5] forState:UIControlStateNormal];
//        [self.contentView addSubview:_timeBtn];
        
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        iconView.layer.cornerRadius = 20.f;
        iconView.layer.masksToBounds= YES;
        [self.contentView addSubview:iconView];

        //正文
        UIButton *contentBtn = [[UIButton alloc] init];
        self.contentBtn = contentBtn;
        contentBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        contentBtn.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:contentBtn];
    }
    return self;
}

- (void)setMessageFrame:(SHMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    SHMessage *message = messageFrame.message;
    
//    [_timeBtn setTitle:message.time forState:UIControlStateNormal];
//    _timeBtn.frame = _messageFrame.timeF;
    
    _iconView.frame = _messageFrame.iconF;
    
    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(15, 10, 15, 10);
    
    UIImage *normal, *focused;
    if (message.type == MessageTyeMe) {
        normal = [UIImage imageNamed:@"blue"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"blue"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        [_contentBtn setTitleColor:[UIColor colorWithHexString:@"#fff"] forState:UIControlStateNormal];
        _iconView.image = [UIImage imageNamed:@"20131017210454_W5HnG"];

    }else{
        normal = [UIImage imageNamed:@"white"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"white"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        [_contentBtn setTitleColor:kblackColor forState:UIControlStateNormal];
        _iconView.image = [UIImage imageNamed:@"2532-1211191425230-L.jpg"];

    }
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
    _contentBtn.frame = messageFrame.contentF;

}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
@end
