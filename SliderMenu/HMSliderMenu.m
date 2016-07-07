//
//  HMSliderMenu.m
//  SliderMenu
//
//  Created by liqiang on 16/4/13.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#import "HMSliderMenu.h"

@interface HMSliderMenu ()
@property (nonatomic,strong) UIButton * directorBtn;
@property (nonatomic,strong) UIButton * selectBtn;

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic,strong) NSMutableArray * menuArray;

@end

@implementation HMSliderMenu
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.menuArray = [NSMutableArray array];
        [self addsubviews];
    }
    
    return self;
}

- (void)addsubviews {
    
    CGFloat buttongHeight = 34/2;

    
    self.directorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.directorBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - 15 - buttongHeight, (CGRectGetHeight(self.frame) - buttongHeight)/2, buttongHeight, buttongHeight);
    [self.directorBtn setBackgroundImage:[UIImage imageNamed:@"icon_pulldown"] forState:UIControlStateNormal ];
    [self addSubview:self.directorBtn];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMinX(self.directorBtn.frame) - 15, CGRectGetHeight(self.frame))];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.userInteractionEnabled = YES;
    [self addSubview:self.scrollView];
    
}

- (void)setMenuNames:(NSArray *)menuNames {

    [self.menuArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (NSInteger i = 0; i < menuNames.count;i ++ ) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString * title = menuNames[i];
        [button setTitle:title forState:UIControlStateNormal];
        CGFloat originX = 15;
        if (self.menuArray.count) {
            UIButton * button = self.menuArray.lastObject;
            originX = CGRectGetMaxX(button.frame) + 15;
        }
        [button setTitleColor:[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        CGSize  size = [title boundingRectWithSize:CGSizeMake(200,CGRectGetHeight(self.scrollView.frame)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        button.frame = CGRectMake(originX, 0, size.width, CGRectGetHeight(self.scrollView.frame));
        button.tag = i;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        
        [self.menuArray addObject:button];
    }
   
    UIButton * button = self.menuArray.lastObject;
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(button.frame), CGRectGetHeight(self.scrollView.frame));
    

    _menuNames = menuNames;
}
- (void)menuClick:(UIButton *)button {

    
    if ([self.delegate respondsToSelector:@selector(sliderMenuClickIndex:)]) {
        [self.delegate sliderMenuClickIndex:button.tag];
    }
    
    self.selectBtn = button;
    


}

- (void)setSelectBtn:(UIButton *)selectBtn {
    
    
    UIWindow * keyWindown = [UIApplication sharedApplication].keyWindow;
    CGFloat originX = selectBtn.center.x - CGRectGetMidX(keyWindown.frame);
    CGFloat maxOrigin = self.scrollView.contentSize.width - CGRectGetWidth(keyWindown.frame);
    if (originX < 0) {
        originX = 0;
    }else if (originX > maxOrigin) {
        originX = maxOrigin + CGRectGetWidth(selectBtn.frame) + 10;
    }
    
    [self.scrollView setContentOffset:CGPointMake(originX, 0) animated:YES];
    
    if (_selectBtn == selectBtn) {
        return;
    }
    
   
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1];
    animation.toValue = [NSNumber numberWithFloat:1.1];
    animation.duration = 0.3;
    animation.repeatCount = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.autoreverses = NO;
    [selectBtn.titleLabel.layer addAnimation:animation forKey:@"animation"];
   
    
    
    CABasicAnimation * animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.1];
    animation1.toValue = [NSNumber numberWithFloat:1];
    animation1.duration = 0.3;
    animation1.repeatCount = 1;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.autoreverses = NO;
    [_selectBtn.titleLabel.layer addAnimation:animation1 forKey:@"animation1"];
    

    [selectBtn setTitleColor:[UIColor colorWithRed:49/255.5 green:195/255.5 blue:124/255.5 alpha:1.0] forState:UIControlStateNormal];

    
    [_selectBtn setTitleColor:[UIColor colorWithRed:104/255.5 green:104/255.5 blue:104/255.5 alpha:1.0] forState:UIControlStateNormal];

    _selectBtn = selectBtn;
    
    
}
- (void)setSelectTilteIndex:(NSInteger)index {
    UIButton * button = self.menuArray[index];
    self.selectBtn = button;
}
@end
