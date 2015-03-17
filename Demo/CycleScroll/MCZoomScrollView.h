//
//  MCZoomScrollView.h
//  CycleScroll
//
//  Created by 陈正星 on 15/1/29.
//  Copyright (c) 2015年 MarcoChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCZoomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property(nonatomic,assign)BOOL  isBig;
@property(nonatomic,assign)BOOL  isR;

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end
