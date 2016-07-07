//
//  HMSliderMenuCell.m
//  SliderMenu
//
//  Created by liqiang on 16/4/14.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#import "HMSliderMenuCell.h"

#import "SVPullToRefresh.h"

@interface HMSliderMenuCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView * tableView;
@end



@implementation HMSliderMenuCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        __weak typeof(self) weakSelf = self;
        [self.tableView addPullToRefreshWithActionHandler:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            });
        }];
        
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.tableView.infiniteScrollingView stopAnimating];
            });
            
        }];
        
        [self.contentView addSubview:self.tableView];
        
        
    }
    
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)layoutSubviews {

    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
}
@end
