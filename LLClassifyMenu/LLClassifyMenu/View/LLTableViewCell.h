//
//  LLTableViewCell.h
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/5/14.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "forumModel.h"
#import "typeListModel.h"
#import "typeListView.h"

@interface LLTableViewCell : UITableViewCell

@property (nonatomic,strong) forumModel *model;
 
/**
 选中圆圈
 */
@property (weak, nonatomic) IBOutlet UIImageView *selectedRadio;


/**
 选中的标题
 */
@property (weak, nonatomic) IBOutlet UILabel *selectedTitle;

/**
 上下箭头
 */
@property (weak, nonatomic) IBOutlet UIImageView *arrowsImage;

@property (weak, nonatomic) IBOutlet typeListView *typeListView;

@property (assign,nonatomic) BOOL isOpenDetail;

//cell的高度
@property (nonatomic,assign) CGFloat cellHeight;

- (void)createCellTypeListViewsWithItemInfo:(NSArray *)infoArray isOpenDetail:(BOOL)isOpen;
@end
