//
//  LLTableViewCell.m
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/5/14.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import "LLTableViewCell.h"
@interface LLTableViewCell()

/**
 标题栏名称
 */
@property (weak, nonatomic) IBOutlet UILabel *titleName; 


@end

@implementation LLTableViewCell 

-(void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(forumModel *)model {
    _titleName.text = model.forum_name;
}

- (void)createCellTypeListViewsWithItemInfo:(NSArray *)infoArray isOpenDetail:(BOOL)isOpen{
    self.typeListView.contentArray = infoArray;
    self.cellHeight = self.typeListView.maxHeight + 50;
    //    NSLog(@"maxHeight------------------------------------------%f",self.typeListView.maxHeight)
    if (isOpen) {
        self.typeListView.hidden = NO;
        self.arrowsImage.selected = YES;
        self.selectedRadio.selected = YES;
    }else {
        self.typeListView.hidden = YES;
        self.arrowsImage.selected = NO;
        self.selectedRadio.selected = NO;
    }
    self.typeListView.callBackBlock = ^(NSString *result) {
        self.selectedTitle.text = result;
    };
}

- (IBAction)remindEvent:(UIButton *)sender {
    NSLog(@"remindEvent===================");
    NSLog(@"%@",NSStringFromCGRect(sender.frame));
    
    
}

@end
