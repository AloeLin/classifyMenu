//
//  FRBTipPopView.h
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/7/9.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dismissBlock)(id result);
@interface FRBTipPopView : UIView

/** 视图消失的回调 */
@property (nonatomic,copy) dismissBlock block;

/** 三角形边长，默认是10 */
@property (nonatomic,assign) CGFloat triangleSide;

/** 三角位置的比例,默认0.5 */
@property (nonatomic, assign) CGFloat triangleSeatScale;

/** 提示框文本内容 */
@property (nonatomic,copy) NSString *contentText;

/**
 在蒙版上显示弹出框
 
 @param maskSuperView 蒙版父视图
 */
- (void)show:(UIView *)maskSuperView;

/**
 弹框消失
 */
-(void)dismiss;
@end
