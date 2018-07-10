//
//  FRBTipPopView.m
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/7/9.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import "FRBTipPopView.h"
@interface FRBTipPopView()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UILabel *contentLabel;

/**
 视图蒙版
 */
@property (nonatomic,strong) UIView *maskView;

/** 点击蒙层的时候，是否使弹出框消失 */
@property (nonatomic,assign) BOOL dismissWhenClickMaskView;
@end

@implementation FRBTipPopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
         [self setDefault];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(3, self.triangleSide*2*cos(M_PI/3)+3, self.frame.size.width-8, self.frame.size.height - self.triangleSide*2*cos(M_PI/3)-8) ;
 }

/** 根据三角方向绘制三角 及 边框 */
#pragma mark - drawRect
- (void)drawRect:(CGRect)rect
{
    
    // 设置背景色
    [self.backgroundColor set];
    
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
  
    CGPoint  startPoint= CGPointMake(1, self.triangleSide*2*cos(M_PI/3));
    CGPoint middlePoint1= CGPointMake(self.triangleSeatScale*self.frame.size.width-self.triangleSide, self.triangleSide*2*cos(M_PI/3));
    CGPoint middlePoint2 = CGPointMake(self.triangleSeatScale*self.frame.size.width,0);
    CGPoint middlePoint3 = CGPointMake(self.triangleSeatScale*self.frame.size.width+self.triangleSide,self.triangleSide*2*cos(M_PI/3));
    CGPoint  middlePoint4 = CGPointMake( self.frame.size.width-3,self.triangleSide*2*cos(M_PI/3));
     CGPoint  middlePoint5 = CGPointMake( self.frame.size.width -3,self.frame.size.height-3);
    CGPoint  middlePoint6 = CGPointMake(1,self.frame.size.height - 3);
    CGPoint  endPoint = CGPointMake(1,self.triangleSide*2*cos(M_PI/3));
    
    CGContextMoveToPoint(context, startPoint. x, startPoint. y);
    CGContextAddLineToPoint(context, middlePoint1. x, middlePoint1. y);
    CGContextAddLineToPoint(context, middlePoint2. x, middlePoint2. y);
    CGContextAddLineToPoint(context, middlePoint3. x, middlePoint3. y);
    CGContextAddLineToPoint(context, middlePoint4. x, middlePoint4. y);
    CGContextAddLineToPoint(context, middlePoint5. x, middlePoint5. y);
    CGContextAddLineToPoint(context, middlePoint6. x, middlePoint6. y);
    CGContextAddLineToPoint(context, endPoint. x, endPoint. y);
    CGContextSetRGBStrokeColor(context, 9/255.0, 113/255.0, 206/255.0, 1.0);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextClosePath(context);
}
   
-(void)setDefault
{
    self.triangleSide = 10.f;
    self.triangleSeatScale = 0.15f;
    self.dismissWhenClickMaskView = YES;
    self.backgroundColor = [UIColor clearColor];
}

-(void)show:(UIView *)maskSuperView
{
    [maskSuperView addSubview:self.maskView];
    [self.maskView addSubview:self];
    [self addSubview:self.contentLabel];
}

- (void)dismiss
{
    [self removeFromSuperview];
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
    }];
    
    if (self.block) {
        self.block(nil);
    }
}
//
- (void)pressMaskViewAction{
    if (!self.dismissWhenClickMaskView) {
        return;
    }
    [self dismiss];
}

#pragma mark - initial
-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
     }
    _contentLabel.text = self.contentText;
    _contentLabel.font = [UIFont systemFontOfSize:13.f];
    _contentLabel.textColor = [UIColor blueColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.backgroundColor = [UIColor whiteColor];
    return _contentLabel;
}

-(UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        _maskView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressMaskViewAction)];
        [_maskView addGestureRecognizer:tap];
        _maskView.userInteractionEnabled = YES;
        tap.delegate = self;
    }
    return _maskView;
}
@end

