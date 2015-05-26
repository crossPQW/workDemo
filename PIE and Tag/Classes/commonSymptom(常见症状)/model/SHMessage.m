//
//  SHMessage.m
//  疾病助手
//
//  Created by 黄少华 on 15/5/12.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import "SHMessage.h"

@implementation SHMessage

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.icon    = dict[@"icon"];
    self.time    = dict[@"time"];
    self.content = dict[@"content"];
    self.type    = [dict[@"type"] intValue];
}
@end
