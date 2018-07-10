//
//  typeListView.m
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/5/14.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import "typeListView.h"
#import "typeListModel.h"

#define  kScreen_Width [UIScreen mainScreen].bounds.size.width
@interface typeListView()
@property (nonatomic,strong) NSArray *testArray;
@end
@implementation typeListView


#pragma mark - 动态设置个性标签长度/换行
-(void) setContentArray:(NSArray *)contentArray
{
    //为了解决cell重用是 重复添加的问题
    for( UIView * v in self.subviews ){
        [v removeFromSuperview];
    }
    _contentArray = contentArray;
    float y =0;
    
    //根据字数设置label的宽度   for (typeListModel *model in _contentArray)
    for (typeListModel *model in _contentArray) {
        
        //设置一个行高上限
        CGSize size =CGSizeMake(320,2000);
        NSDictionary *attribute =@{NSFontAttributeName:[UIFont systemFontOfSize:8]};
        CGSize labelsize = [model.typename boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine  attributes:attribute context:nil].size;
    
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, y, labelsize.width + 40, 40)];
        titleLabel.text = model.typename;
        titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:titleLabel];
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) -   labelsize.width - 60 , y, labelsize.width + 40, 40)];
        descLabel.text = model.typename;
        descLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:descLabel];
        
        y += 40;
        //      这里涉及到的内容是返回自定义高度
        _maxHeight = titleLabel.frame.origin.y + titleLabel.frame.size.height;
    }
}


/**
 选中标题的点击事件
 */
- (void)selectButton:(UIButton *)sender {
    if (self.callBackBlock) {
        self.callBackBlock(sender.titleLabel.text);
    }
}

@end
