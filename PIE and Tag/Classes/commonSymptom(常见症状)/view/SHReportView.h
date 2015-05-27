//
//  SHReportTableViewCell.h
//  PIE and Tag
//
//  Created by 黄少华 on 15/5/26.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHReportView : UIView
/**
 *  保存所有信息的view
 */
@property (nonatomic, strong) UIView *infomationView;
/**
 *  保存所有基本信息
 */
@property (nonatomic, strong) UIView *basicInfoView;
/**
 *  追加补充信息view
 */
@property (nonatomic, strong) UIView *addInfoView;

/**
 *  底部的提示
 */
@property (nonatomic, strong) UIButton *tipBtn;
@end
