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
@implementation typeListView

#pragma mark - 动态设置个性标签长度/换行
-(void) setContentArray:(NSArray *)contentArray
{
    _contentArray = contentArray;
    float x = 10;
    float y =15;
    int i =0;
    
    //根据字数设置label的宽度
    for (typeListModel *model in _contentArray) {
        
        //设置一个行高上限
        CGSize size =CGSizeMake(320,2000);
        NSDictionary *attribute =@{NSFontAttributeName:[UIFont systemFontOfSize:8]};
        CGSize labelsize = [model.typename boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine  attributes:attribute context:nil].size;
        if (kScreen_Width - x < labelsize.width +40)
        {
            x = 10;
            y += 35;
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, labelsize.width + 40, 30)];
        button.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:button];
        button.tag =8000 + i;
        
        [button setTitle:model.typename forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        x += button.frame.size.width +10;
        i++;
//      这里涉及到的内容是返回自定义高度
        _maxHeight = button.frame.origin.y + button.frame.size.height + 15;
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
