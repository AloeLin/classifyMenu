//
//  forumModel.h
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/5/14.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "typeListModel.h"

@interface forumModel : NSObject

/**
 "fid" : 34,
 "forum_name" : "俱乐部1",
 "typelist" :
 */


/**
 id
 */
@property (assign,nonatomic) NSInteger fid;


/**
 栏目名称
 */
@property (copy,nonatomic) NSString *forum_name;


/**
 详情列表
 */
@property (strong,nonatomic) typeListModel *typelist;

@end
