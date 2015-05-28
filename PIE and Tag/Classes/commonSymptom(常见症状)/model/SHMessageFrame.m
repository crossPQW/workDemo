//
//  SHMessageFrame.m
//  疾病助手
//
//  Created by 黄少华 on 15/5/12.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import "SHMessageFrame.h"
#import "SHMessage.h"
@implementation SHMessageFrame

- (void)setMessage:(SHMessage *)message
{
    _message = message;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    
    //头像
    CGFloat iconX = 10;
    if (message.type == MessageTyeMe) {//我发的在右边
        iconX = screenW - 10 - 40;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF) + 10;
    _iconF = CGRectMake(iconX, iconY, 40, 40);
    
    //正文
    CGFloat contentX = CGRectGetMaxX(_iconF) + 10;
    CGFloat contentY = iconY;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:nil size:14]};
    CGSize contentSize = [message.content sizeWithAttributes:attributes];
    if (message.type == MessageTyeMe) {
        contentX = iconX - 10 - contentSize.width - 25 - 15;
    }
    CGFloat width = contentSize.width + 40;
    if ((contentX + width) > screenWidth) {
        width = screenWidth - contentX - 20;
    }
    
    _contentF = CGRectMake(contentX, contentY, width, contentSize.height + 40);

    _cellHeight = CGRectGetMaxY(_contentF);
}
@end
