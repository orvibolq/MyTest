//
//  ViewController.m
//  SliderMenu
//
//  Created by liqiang on 16/4/13.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#import "HMEPGController.h"
#import "HMSliderMenu.h"
#import "HMSliderMenuCell.h"

@interface HMEPGController ()<HMSliderMenuDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray * menuArry;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) HMSliderMenu * menu;
@end

@implementation HMEPGController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   _menu = [[HMSliderMenu alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44)];
    _menu.menuNames = @[@"综艺",@"电视剧",@"电影",@"体育体育",@"新闻",@"综艺",@"综艺",@"综艺",@"综艺",@"综艺",@"综艺",@"电视剧",@"电影",@"体育",@"新闻",@"综艺",@"综艺",@"综艺",@"综艺",@"综艺"];
    self.menuArry = _menu.menuNames;
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectZero style: UITableViewStylePlain];
    tableView.transform = CGAffineTransformMakeRotation(270 * M_PI / 180);
    tableView.frame = CGRectMake(0, CGRectGetMaxY(_menu.frame),CGRectGetWidth([UIScreen mainScreen].bounds) , CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetMaxY(_menu.frame));
    [tableView setShowsVerticalScrollIndicator: NO];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setBackgroundColor: [UIColor clearColor]];
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    tableView.scrollsToTop = NO;
    tableView.pagingEnabled = YES;
    self.tableView = tableView;
    [self.view addSubview: tableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuArry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return   CGRectGetWidth(self.view.frame);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMSliderMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[HMSliderMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)sliderMenuClickIndex:(NSInteger)index {
    NSLog(@"did click title : %@",self.menuArry[index]);
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSArray * array = [self.tableView visibleCells];
    UITableViewCell * cell = array.firstObject;
    if(cell){
        NSIndexPath * path = [self.tableView indexPathForCell:cell];
        [self.menu setSelectTilteIndex:path.row];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
