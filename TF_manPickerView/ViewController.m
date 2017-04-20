//
//  ViewController.m
//  TF_manPickerView
//
//  Created by TF_man on 16/5/11.
//  Copyright © 2016年 TF_man. All rights reserved.
//

#import "ViewController.h"
#import "PickerChoiceView.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,TFPickerDelegate>
{
    NSInteger selectIndex;
}

@property (nonatomic,strong)UITableView *tv;

@property (nonatomic,strong)NSMutableArray *mutArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //哈哈哈哈哈哈哈哈哈
    self.mutArray = [NSMutableArray array];
    //注册nib
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tv registerNib:nib forCellReuseIdentifier:@"TableViewCellID"];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Property List" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc]initWithContentsOfFile:plistPath];
    for (NSDictionary *dict in arr) {
        
        [self.mutArray addObject:dict];
    }

}

#pragma mark -------懒加载

- (UITableView *)tv{
    
    if (!_tv) {
        
        _tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tv.delegate = self;
        _tv.dataSource = self;
        _tv.tableFooterView = [[UIView alloc]init];
        //添加UITableView
        [self.view addSubview:self.tv];
        
    }
    
    return _tv;
}

#pragma mark -------- UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return self.mutArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = [self.mutArray objectAtIndex:indexPath.row];
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellID"];
    cell.leftLb.text = dict[@"title1"];
    cell.rightLb.text = dict[@"title2"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:self.view.bounds];
    selectIndex = indexPath.row;
    picker.delegate = self;
    if (indexPath.row == 0) {
        
        picker.arrayType = GenderArray;
        picker.selectStr  = cell.rightLb.text;
        
    }if (indexPath.row == 1) {
        
        picker.arrayType = HeightArray;
        picker.selectStr  = cell.rightLb.text;
        
    }if (indexPath.row == 2) {
        
        picker.arrayType = weightArray;
        picker.selectStr  = cell.rightLb.text;
        
    }if (indexPath.row == 3) {
        
        picker.arrayType = DeteArray;
         picker.selectStr  = cell.rightLb.text;
        
    }if (indexPath.row == 4) {
        
        picker.selectLb.text = @"自定义";
        picker.customArr = @[@"超哥",@"小猪",@"大黑牛",@"小鹿",@"完美",@"凯凯",@"baby"];
        picker.selectStr  = cell.rightLb.text;
    }if (indexPath.row == 5) {
        
        picker.arrayType = DeteAndTimeArray;
        picker.selectStr  = cell.rightLb.text;
    }if (indexPath.row == 6) {
        picker.arrayType = ColourArray;
        picker.selectStr  = cell.rightLb.text;

    }

    [self.view addSubview:picker];

}

#pragma mark -------- TFPickerDelegate

- (void)PickerSelectorIndixString:(NSString *)str{

    NSDictionary *dict = [self.mutArray objectAtIndex:selectIndex];
    
    NSMutableDictionary *muDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [muDict setObject:str forKey:@"title2"];
    [self.mutArray replaceObjectAtIndex:selectIndex withObject:muDict];
//    [self.mutArray removeObjectAtIndex:selectIndex];
//    [self.mutArray insertObject:muDict atIndex:selectIndex];
    
    [self.tv reloadData];
    
}

- (void)PickerSelectorIndixColour:(UIColor *)color{
    
    NSLog(@"p----%@",color);
}

@end
