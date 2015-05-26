//
//  SHMessageFrame.h
//  疾病助手
//
//  Created by 黄少华 on 15/5/12.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SHMessage;
@interface SHMessageFrame : NSObject


@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect contentF;

@property (nonatomic, assign, readonly) CGFloat cellHeight; //cell高度

@property (nonatomic, strong) SHMessage *message;

@property (nonatomic, assign) BOOL showTime;
@end
