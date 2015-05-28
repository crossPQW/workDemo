//
//  SHWaitDoc.h
//  PIE and Tag
//
//  Created by 黄少华 on 15/5/28.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHWaitDoc;
@protocol SHWaitDocDelegate <NSObject>

@optional
- (void)waitDoc:(SHWaitDoc *)waitDoc;
@end

@interface SHWaitDoc : UIView

@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, weak) id<SHWaitDocDelegate>delegate;
@end
