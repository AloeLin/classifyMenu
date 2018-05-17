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
#import "typeListView.h"

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


/**
 需要展开的cell集合
 */
@property (nonatomic,strong) NSMutableArray *selectedRowArray;

@property (nonatomic,assign) CGFloat cellHeight;
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
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LLTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.forumArray.count;
}

-(LLTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell createCellTypeListViewsWithItemInfo:self.typeListArray[indexPath.row] isOpenDetail:([self.selectedRowArray containsObject:@(indexPath.row)]) ? YES : NO];
    cell.model =  self.forumArray[indexPath.row];
    cell.testLabel.text = [NSString stringWithFormat:@"********* %ld  ",(long)indexPath.row];
    _cellHeight =  cell.cellHeight;
    //删除cell的所有子视图
 
//    NSLog(@"cellheight === %f indexrow ==== %ld",_cellHeight,(long)indexPath.row);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.selectedRowArray containsObject:@(indexPath.row)]) {
        [self.selectedRowArray removeObject:@(indexPath.row)];
        [self.tableView reloadData];
        return;
    }
    [self.selectedRowArray addObject:@(indexPath.row)];
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.selectedRowArray containsObject:@(indexPath.row)]) {
        return _cellHeight;
    }
    return 50.f;
//    NSLog(@"cellheight ********* %f indexrow ********* %ld selectrow ********* %ld ",_cellHeight,(long)indexPath.row,_selectedRow);
//    return  (indexPath.row == _selectedRow) ?  _cellHeight : 50.f;
    
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

-(NSMutableArray *)selectedRowArray {
    if (!_selectedRowArray) {
        _selectedRowArray = [NSMutableArray array];
    }
    return _selectedRowArray;
}
@end
