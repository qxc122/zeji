//
//  ReplicatorView.m
//  TransitionDemo
//
//  Created by Apple on 15/7/14.
//  Copyright (c) 2015年 Linitial. All rights reserved.
//

#import "ReplicatorView.h"

#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)
#define WIDTHCIR  50
#define WIDTH_lineWidth  5.0

@interface ReplicatorView ()
@property (nonatomic,weak)CAShapeLayer *repLayer;
@end

#define WIDTHMIN  4.0

CGFloat const kLoadingWidth = 50.0;

@implementation ReplicatorView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        self.backgroundColor = RGBACOLOR(19, 37, 51, 0.9);
        [self setupLayers];
    }
    return self;
}

- (void)setupLayers {
    CAShapeLayer *layer =[CAShapeLayer layer];
    self.repLayer = layer;
    [self.layer addSublayer:layer];
    layer.lineWidth = WIDTH_lineWidth;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor =[UIColor redColor].CGColor;
    
    layer.frame = CGRectMake(self.bounds.size.width/2.0-WIDTHCIR/2.0, self.bounds.size.height/2.0-WIDTHCIR*2, WIDTHCIR, WIDTHCIR);
    layer.lineCap = kCALineCapRound;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTHCIR/2.0, WIDTHCIR/2.0) radius:WIDTHCIR/2.0 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    //画一个圆
    CAKeyframeAnimation *strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 0.5;
    strokeEndAnimation.values = @[@0.0, @1];
    strokeEndAnimation.keyTimes = @[@0.0,@1];
    
    //旋转2圈
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotaAni.fromValue = @(DEGREES_TO_RADIANS(0));
    rotaAni.toValue = @(DEGREES_TO_RADIANS(720));
    rotaAni.autoreverses = YES;
    rotaAni.removedOnCompletion = NO;
    
    //最后填充颜色
    //创建一个CABasicAnimation对象
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //设置颜色
    animation.toValue=(id)[UIColor blackColor].CGColor; //必须要用黑色
    animation.removedOnCompletion = NO;
    
    
    CABasicAnimation *strokeAnim = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeAnim.fromValue         = (id) [UIColor redColor].CGColor;
    strokeAnim.toValue           = (id) [UIColor greenColor].CGColor;
//    strokeAnim.toValue           = (id) RGBACOLOR(19, 37, 52, 1).CGColor;
    strokeAnim.removedOnCompletion = NO;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = INFINITY;
    group.duration = 2;
    group.animations = @[strokeEndAnimation,rotaAni,animation,strokeAnim];
    group.removedOnCompletion = NO;
    
    [layer addAnimation:group forKey:nil];
    
    
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
