//
//  ViewController.m
//  TableViewCityListIndex
//
//  Created by  lichong on 16/8/2.
//  Copyright © 2016年 carsmart. All rights reserved.
//

#import "ViewController.h"
#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    NSArray *_allKeyArray;
    NSMutableArray *_allValuesArray;
    UILabel *nameLabel;
}

@property (nonatomic,strong) NSDictionary *cityDict;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allValuesArray = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    _cityDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, kScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:_tableView];
    
    
    _allKeyArray = [self.cityDict allKeys];
    [self setArraySortSecond];
    
    for (NSString *str  in _allKeyArray) {
        NSArray *array = _cityDict[str];
        [_allValuesArray addObject:array];
    }
}



-(void)setArraySortFirst
{
    NSLog(@"%@",_allKeyArray);
    
    _allKeyArray = [_allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    NSLog(@"%@",_allKeyArray);
}

-(void)setArraySortSecond
{
    _allKeyArray = [_allKeyArray sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@",_allKeyArray);
}

-(void)setArraySortThree
{
    NSSortDescriptor *descr = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    _allKeyArray = [_allKeyArray sortedArrayUsingDescriptors:@[descr]];
    NSLog(@"%@",_allKeyArray);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allKeyArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *array = _allValuesArray[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = _allValuesArray[indexPath.section][indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  _allKeyArray;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    
    if (headView == nil) {
        headView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerView"];
    }
    
    headView.textLabel.text = _allKeyArray[section];
    return headView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = _allValuesArray[indexPath.section][indexPath.row];
    NSLog(@"%@",str);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
