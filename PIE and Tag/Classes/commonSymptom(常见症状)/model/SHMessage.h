//
//  SHMessage.h
//  疾病助手
//
//  Created by 黄少华 on 15/5/12.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MessageTyeMe         = 0,//自己
    MessageTyeOther      = 1//别人
}MessageTye;
@interface SHMessage : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) MessageTye type;

@property (nonatomic, copy) NSDictionary *dict;

@end
