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

-(void)setModel:(forumModel *)model {
    _titleName.text = model.forum_name;
}

-(void)awakeFromNib {

}
@end
