//
//  typeListModel.h
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/5/14.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface typeListModel : NSObject

/**
 "typeid" : 1651,
 "typename" : "◆快乐寄养"
 */


/**
 id
 */
@property (assign,nonatomic) NSInteger typeid;

/**
 名称
 */
@property (copy,nonatomic) NSString *typename;

@end
