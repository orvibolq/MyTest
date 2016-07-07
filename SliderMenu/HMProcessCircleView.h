//
//  HMProcessCircleView.h
//  SliderMenu
//
//  Created by liqiang on 16/4/14.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMProcessCircleView : UIView
@property (nonatomic, assign) CGFloat progressValue;

@property (nonatomic, assign) CGFloat progressStrokeWidth;

@property (nonatomic, strong) UIColor * progressColor;

@property (nonatomic, strong) UIColor * progressTrackColor;
@end
