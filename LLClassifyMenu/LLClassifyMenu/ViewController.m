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


/**
 选中cell
 */
@property (nonatomic,assign) NSInteger selectedRow;

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
    [cell createCellTypeListViewsWithItemInfo:self.typeListArray[indexPath.row] isOpenDetail:(indexPath.row == _selectedRow) ? YES : NO];
    cell.model =  self.forumArray[indexPath.row];
    _cellHeight =  cell.cellHeight;    
//    NSLog(@"cellheight === %f indexrow ==== %ld",_cellHeight,(long)indexPath.row);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    _selectedRow = indexPath.row;
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.row == _selectedRow) {
        height = _cellHeight;
    }else {
        height = 50.f;
    }
//    NSLog(@"cellheight ********* %f indexrow ********* %ld selectrow ********* %ld ",_cellHeight,(long)indexPath.row,_selectedRow);
    return  (indexPath.row == _selectedRow) ?  _cellHeight : 50.f;
    
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
