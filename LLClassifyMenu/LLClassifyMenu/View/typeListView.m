//
//  typeListView.m
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/5/14.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import "typeListView.h"
#import "typeListModel.h"
#import "TagsFrame.h"

@interface typeListView(){
     TagsFrame *_frame;
}


@end

@implementation typeListView



-(void)awakeFromNib {
   
        self.contentArray = @[@"全部",@"哈哈哈哈哈哈",@"的点点滴滴多多",@"他啦啦啦啦啦啦",@"发哈几个",@"鞥UNv",@"麓山国际后悔过",@"lllllldaffff",@"lalalalall",@"啦啦啦啦啦啦",@"喵喵吗喵毛",@"囖囖囖囖大家开发及囖囖咯",@"安安",@"对对对",@"错",@"初音MIKU"];
        [self initUI];
   
}

- (void)initUI {
    for (int i = 0; i < self.contentArray.count; i ++) {
//        typeListModel *model = self.contentArray[i];
        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagsBtn setTitle:self.contentArray[i] forState:UIControlStateNormal];
        [tagsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tagsBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        tagsBtn.backgroundColor = [UIColor whiteColor];
        tagsBtn.frame = CGRectFromString(_frame.tagsFrames[i]);
        
        [self addSubview:tagsBtn];
    }
}

@end
