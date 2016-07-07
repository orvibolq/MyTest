//
//  HMSliderMenu.h
//  SliderMenu
//
//  Created by liqiang on 16/4/13.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HMSliderMenuDelegate  <NSObject>

- (void)sliderMenuClickIndex:(NSInteger)index;

@end

@interface HMSliderMenu : UIView

@property (nonatomic, weak) id <HMSliderMenuDelegate> delegate;

@property (nonatomic, strong) NSArray * menuNames;

- (void)setSelectTilteIndex:(NSInteger)index;
@end
