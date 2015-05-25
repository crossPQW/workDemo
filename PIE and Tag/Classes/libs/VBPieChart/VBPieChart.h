//
//  VBPieChart.h
//  Charts
//
//  Created by Volodymyr Boichentsov on 15/02/2014.
//  Copyright (c) 2014 SAKrisT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, VBPieChartAnimationOptions) {
    VBPieChartAnimationFanAll                     = 1 <<  0, // default
    VBPieChartAnimationGrowth                     = 1 <<  1,
    VBPieChartAnimationGrowthAll                  = 1 <<  2,
    VBPieChartAnimationGrowthBack                 = 1 <<  3,
    VBPieChartAnimationGrowthBackAll              = 1 <<  4,
    VBPieChartAnimationFan                        = 1 <<  5,
    
    VBPieChartAnimationTimingEaseInOut            = 1 << 16,
    VBPieChartAnimationTimingEaseIn               = 2 << 16,
    VBPieChartAnimationTimingEaseOut              = 3 << 16,
    VBPieChartAnimationTimingLinear               = 4 << 16, // default
    
};

@interface VBPieChart : UIView

@property (nonatomic, strong) NSArray *chartValues;

@property (nonatomic, strong) UIColor *strokeColor;

// Default is NO
@property (nonatomic) BOOL enableStrokeColor;

// Default is NO
@property (nonatomic) BOOL enableInteractive;

// Default is NO, under development
@property (nonatomic) BOOL showLabels;


// Hole in center of diagram, precent of radius
// Default is 0.2, from 0 to 1
@property (nonatomic) float holeRadiusPrecent;

// Radius of diagram dependce to view size
// Default is 0.9, possible value from 0 to 1.
@property (nonatomic) float radiusPrecent;

// Default is 0.25, optimal
@property (nonatomic) float maxAccentPrecent;

// Length of circle, from 0 to M_PI*2
// Default M_PI*2.
@property (nonatomic) float length;

// Start angle
@property (nonatomic) float startAngle;

- (void) setChartValues:(NSArray *)chartValues animation:(BOOL)animation;

- (void) setChartValues:(NSArray *)chartValues animation:(BOOL)animation options:(VBPieChartAnimationOptions)options;

- (void) setChartValues:(NSArray *)chartValues animation:(BOOL)animation duration:(float)duration options:(VBPieChartAnimationOptions)options;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
