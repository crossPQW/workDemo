//
//  VBPiePiece.m
//  Charts
//
//  Created by Volodymyr Boichentsov on 15/02/2014.
//  Copyright (c) 2014 SAKrisT. All rights reserved.
//

#import "VBPiePiece.h"
#import "VBPieChart.h"

@interface VBPiePiece ()

@property (nonatomic) CGPoint accentVector;
@property (nonatomic) float accentValue;

@property (nonatomic) float endAngle;

@property (nonatomic) CGAffineTransform currentMatrix;

@property (nonatomic, copy) void (^endAnimationBlock)(void);

@property (nonatomic) VBPieChartAnimationOptions animationOptions;
@property (nonatomic) float animationDuration;

@property (nonatomic) BOOL showLabel;

@property (nonatomic, strong) CATextLayer *label;

@end


@implementation VBPiePiece {
    float temp_innerRadius;
    float temp_outerRadius;
}

- (id) init {
    self = [super init];
    self.innerRadius = 0;
    self.accentPrecent = 0.0;
    self.endAnimationBlock = nil;
    
    self.label = [[CATextLayer alloc] init];
    self.label.fontSize = 10;
    self.label.alignmentMode = kCAAlignmentCenter;
    self.label.foregroundColor = [UIColor blackColor].CGColor;
    return self;
}

- (void) setValue:(double)value {
    _value = value;
    if (value >= 0.04 && _showLabel) {
        [self.label setString:[NSString stringWithFormat:@"%0.0f%%", self.value ]];
    } else {
        [self.label setHidden:YES];
    }
}

- (void) setAccentPrecent:(float)accentPrecent {
    _accentPrecent = accentPrecent;
    _accent = YES;
    [self update];
}

- (void) update {
    [self pieceAngle:_angle start:_startAngle];
}

- (void) pieceAngle:(float)angle start:(float)startAngle; {
    _angle = angle;
    _endAngle = angle;
    _startAngle = startAngle;
    
    CGSize size = self.frame.size;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return;
    }
    
    CGPoint center = CGPointMake(size.width/2, size.height/2);
    if (_innerRadius == 0) {
        _innerRadius = size.width/2;
    }
    
    self.accentValue = _innerRadius*_accentPrecent;
    
    // calculate vector of moving
    
    float calcAngle = angle+startAngle*2;
    int mod_x = 1;
    int mod_y = 1;
    
    if (calcAngle/2 > M_PI+M_PI_2) {
        mod_x = 1;
        mod_y = -1;
    } else if (calcAngle/2 > M_PI) {
        mod_x = -1;
        mod_y = -1;
    } else if (calcAngle/2 > M_PI_2) {
        mod_x = -1;
        mod_y = 1;
    }
    
    float x = center.x + _innerRadius*cos(calcAngle/2);
    float y = center.y + _innerRadius*sin(calcAngle/2);
    
    _accentVector = CGPointMake(center.x-x, center.y-y);
    _accentVector.x = fabsf(_accentVector.x)*mod_x /_innerRadius;
    _accentVector.y = fabsf(_accentVector.y)*mod_y /_innerRadius;

    
    if (_accent) {
        CGAffineTransform matrix = CGAffineTransformIdentity;
        matrix = CGAffineTransformMakeTranslation(center.x, center.y);
        matrix = CGAffineTransformTranslate(matrix, _accentVector.x*_accentValue, _accentVector.y*_accentValue);
        matrix = CGAffineTransformTranslate(matrix,-center.x,-center.x);
        _currentMatrix = matrix;
        
#if DEBUG
//        CALayer *layer = [CALayer layer];
//        [layer setFrame:CGRectMake(center.x+_accentVector.x*size.width/2, center.y+_accentVector.y*size.height/2, 2, 2)];
//        layer.backgroundColor = [UIColor redColor].CGColor;
//        [self addSublayer:layer];
#endif
    }
    
    if (startAngle > -.01 && angle > -.01) {
        _endAngle = startAngle+angle;
        [self __angle:_angle];
    }
}


- (void) createArcAnimationForKey:(NSString *)key fromValue:(NSNumber *)from toValue:(NSNumber *)to delegate:(id)delegate {
    CABasicAnimation *arcAnimation = [CABasicAnimation animationWithKeyPath:key];
    [arcAnimation setFromValue:from];
    [arcAnimation setToValue:to];
    if (_animationOptions & VBPieChartAnimationFanAll) {
        arcAnimation.duration = _animationDuration/((M_PI*2)/_angle);
    } else if (_animationOptions & VBPieChartAnimationGrowth || _animationOptions & VBPieChartAnimationGrowthBack) {
        arcAnimation.duration = _animationDuration/(float)[[self.superlayer sublayers] count];
    } else if (_animationOptions & VBPieChartAnimationGrowthAll || _animationOptions & VBPieChartAnimationGrowthBackAll) {
        arcAnimation.duration = _animationDuration;
    } else if (_animationOptions & VBPieChartAnimationFan) {
        arcAnimation.duration = _animationDuration;
    }
    
    [arcAnimation setDelegate:delegate];
    
    if (_animationOptions & VBPieChartAnimationTimingEaseIn) {
        [arcAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    } else if (_animationOptions & VBPieChartAnimationTimingEaseOut) {
        [arcAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    } else if (_animationOptions & VBPieChartAnimationTimingEaseInOut) {
        [arcAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    } else {
        [arcAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    }
    
    [self addAnimation:arcAnimation forKey:key];
    [self setValue:to forKey:key];
}

+ (BOOL) needsDisplayForKey:(NSString*)key {
    if ([key isEqualToString:@"endAngle"] || [key isEqualToString:@"startAngle"] || [key isEqualToString:@"innerRadius"]|| [key isEqualToString:@"outerRadius"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (void) drawInContext:(CGContextRef)ctx {
    
    CAAnimation *arcAnimation = [self animationForKey:@"endAngle"];
    if (arcAnimation) {
        _angle = _endAngle;
        VBPiePiece *p = arcAnimation.delegate;
        [p __angle:_endAngle];
    }
    
    arcAnimation = [self animationForKey:@"innerRadius"];
    if (arcAnimation) {
        VBPiePiece *p = arcAnimation.delegate;
        [p __innerRadius:_innerRadius];
    }
    
    arcAnimation = [self animationForKey:@"outerRadius"];
    if (arcAnimation) {
        VBPiePiece *p = arcAnimation.delegate;
        [p __outerRadius:_outerRadius];
    }
}



- (void) animationDidStart:(CAAnimation *)anim { }

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([((CABasicAnimation*)anim).keyPath isEqualToString:@"endAngle"]) {
        [self __angle:_endAngle];
    }
    if ([((CABasicAnimation*)anim).keyPath isEqualToString:@"innerRadius"] && flag) {
        [self __innerRadius:temp_innerRadius];
    }
    if ([((CABasicAnimation*)anim).keyPath isEqualToString:@"outerRadius"] && flag) {
        [self __outerRadius:temp_outerRadius];
    }
    
    if (_endAnimationBlock != nil) {
        _endAnimationBlock();
        _endAnimationBlock = nil;
    }
}

- (void) _animate {
    if (_animationOptions & VBPieChartAnimationFan || _animationOptions & VBPieChartAnimationFanAll) {
        [self createArcAnimationForKey:@"endAngle"
                             fromValue:[NSNumber numberWithFloat:0]
                               toValue:[NSNumber numberWithFloat:_angle]
                              delegate:self];
        [self __angle:0];
    }
    if (_animationOptions & VBPieChartAnimationGrowthBack || _animationOptions & VBPieChartAnimationGrowthBackAll) {
        temp_outerRadius = _outerRadius;
        [self createArcAnimationForKey:@"outerRadius"
                             fromValue:[NSNumber numberWithFloat:_innerRadius]
                               toValue:[NSNumber numberWithFloat:_outerRadius]
                              delegate:self];
        [self __outerRadius:_innerRadius];
    }

    if (_animationOptions & VBPieChartAnimationGrowth || _animationOptions & VBPieChartAnimationGrowthAll) {
        temp_innerRadius = _innerRadius;
        [self createArcAnimationForKey:@"innerRadius"
                             fromValue:[NSNumber numberWithFloat:_outerRadius]
                               toValue:[NSNumber numberWithFloat:_innerRadius]
                              delegate:self];
        [self __innerRadius:_outerRadius];
    }
    [self setHidden:NO];
}


- (CGMutablePathRef) refreshPath {
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRelativeArc(path, &_currentMatrix, center.x, center.y, _innerRadius, _startAngle, _angle);
    CGPathAddRelativeArc(path, &_currentMatrix, center.x, center.y, _outerRadius, _startAngle+_angle , -_angle);
    CGPathCloseSubpath(path);
    return path;
}


- (void) setPath:(CGPathRef)path {
    [super setPath:path];
    
    if (_showLabel) {
        CGRect rect = CGPathGetPathBoundingBox(path);
        CGSize size = self.frame.size;
        CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        center = CGPointMake(center.x+_accentVector.x*size.width/4+_accentValue, center.y+_accentVector.y*size.height/4+_accentValue);
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (CGRectContainsPoint(rect, center)) {
            [self.label setPosition:center];
            [self.label setHidden:NO];
        } else {
            [self.label setHidden:YES];
        }
        [CATransaction commit];
    }
}


- (BOOL) animateToAccent:(float)accentPrecent {

    if ([[self animationKeys] count] != 0) {
        return NO;
    }
    _accentPrecent = accentPrecent;
    _accent = YES;
    
    self.accentValue = _innerRadius*_accentPrecent;
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGAffineTransform matrix = CGAffineTransformIdentity;
    matrix = CGAffineTransformMakeTranslation(center.x, center.y);
    matrix = CGAffineTransformTranslate(matrix, _accentVector.x*_accentValue, _accentVector.y*_accentValue);
    matrix = CGAffineTransformTranslate(matrix,-center.x,-center.x);
    _currentMatrix = matrix;
    
    CGMutablePathRef path = [self refreshPath];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.repeatCount = 0;
    animation.duration = 0.3;
	animation.fromValue = (__bridge id)self.path;
	animation.toValue = (__bridge id)path;
    [self addAnimation:animation forKey:@"animatePath"];
    
    self.path = path;
    CGPathRelease(path);
    
    return YES;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self.label setFrame:CGRectMake(0, 0, 20, 20)];
    [self addSublayer:_label];
}

- (BOOL) containsPoint:(CGPoint)point {
    return CGPathContainsPoint(self.path, NULL, point, false);
}

- (NSString *) description {
    return [NSString stringWithFormat:@"<VBPiePiece: %p, _startAngle=%f, _endAngle=%f>", self, _startAngle, _endAngle];
}

- (void) __angle:(float)angle {
    _angle = angle;
    CGPathRef path = [self refreshPath];
    self.path = path;
    CGPathRelease(path);
}

- (void) __innerRadius:(float)radius {
    _innerRadius = radius;
    CGPathRef path = [self refreshPath];
    self.path = path;
    CGPathRelease(path);
}

- (void) __outerRadius:(float)radius {
    _outerRadius = radius;
    CGPathRef path = [self refreshPath];
    self.path = path;
    CGPathRelease(path);
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
