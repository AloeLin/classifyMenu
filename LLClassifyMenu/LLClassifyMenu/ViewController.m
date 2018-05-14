//
//  ViewController.m
//  LLClassifyMenu
//
//  Created by 汪林林 on 2018/5/11.
//  Copyright © 2018年 汪林林. All rights reserved.
//

#import "ViewController.h"
#import "LLTableViewCell.h"
#import "forumModel.h"
#import "typeListModel.h"
#import "YYModel.h"

static NSString *identifier = @"identifierCell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;


/**
 标题的数组
 */
@property (nonatomic,strong) NSMutableArray *forumArray;


/**
 展开内容的数组
 */
@property (nonatomic,strong) NSMutableArray *typeListArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    [self initData];
    [self initUI];
}

//加载数据
- (void)initData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tagPlist" ofType:@"json"];
    NSData * jsonData = [[NSData alloc] initWithContentsOfFile:path];
    id JsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    for (id Element in JsonObject) {
        id typeListJson = Element[@"typelist"];
        NSMutableArray *temp = [NSMutableArray array];
        for (id typeListElement in typeListJson) {
            typeListModel *typeList = [typeListModel yy_modelWithJSON:typeListElement];
            [temp addObject:typeList];
        }
        [self.typeListArray addObject:temp];
         forumModel *forum = [forumModel yy_modelWithJSON:Element];
        [self.forumArray addObject:forum];
    }
    
}

//视图加载
- (void)initUI {

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LLTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.forumArray.count;
}

-(LLTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[LLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model =  self.forumArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

#pragma mark - inital

-(NSMutableArray *)forumArray {
    if (!_forumArray) {
        _forumArray = [NSMutableArray array];
    }
    return _forumArray;
}

-(NSMutableArray *)typeListArray {
    if (!_typeListArray) {
        _typeListArray  = [NSMutableArray array];
    }
    return _typeListArray;
}
@end
