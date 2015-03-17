//
//  MCScrollView.h
//  CycleScroll
//
//  Created by 陈正星 on 15/1/29.
//  Copyright (c) 2015年 MarcoChen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CycleDirectionPortait,          // 垂直滚动
    CycleDirectionLandscape         // 水平滚动
}CycleDirection;

@class MCScrollView;

@protocol MCScrollViewDelegate <NSObject>

@optional
- (void)MCScrollViewDelegate:(MCScrollView *)cycleScrollView didSelectImageView:(int)index;
- (void)MCScrollViewDelegate:(MCScrollView *)cycleScrollView currentPage:(int)index;
- (void)MCScrollViewDelegate:(MCScrollView *)cycleScrollView didScrollImageView:(int)index;

@end


@interface MCScrollView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)NSArray *imagesArray;            // 存放所有需要滚动的图片 UIImage

@property(nonatomic,assign)int  curPage;//当前页码

@property(nonatomic,assign)int totalPage;//总页数

@property (nonatomic, assign)id<MCScrollViewDelegate> delegate;


@property(nonatomic,strong)UIScrollView * scrollView;

- (id)initWithFrame:(CGRect)frame cycleDirection:(CycleDirection)direction pictures:(NSArray *)pictureArray isNetworkLink:(BOOL)isNetwork;

- (NSArray *)getDisplayImagesWithCurpage:(int)page;

- (void)refreshScrollView;

@end
