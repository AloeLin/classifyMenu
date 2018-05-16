//
//  typeListView.h
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/5/14.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import <UIKit/UIKit.h>
 typedef void(^CallBackBlock)(NSString *result);
@interface typeListView : UIView

/**
 数据内容
 */
@property (nonatomic,strong) NSArray *contentArray;


/**
 当前视图的高度
 */
@property (nonatomic,assign) CGFloat maxHeight; 

@property (nonatomic,copy) CallBackBlock callBackBlock;
@end

