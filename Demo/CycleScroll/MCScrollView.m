//
//  MCScrollView.m
//  CycleScroll
//
//  Created by 陈正星 on 15/1/29.
//  Copyright (c) 2015年 MarcoChen. All rights reserved.
//

#import "MCScrollView.h"
#import "MCZoomScrollView.h"
#import "UIImageView+WebCache.h"
@interface MCScrollView()

@property(nonatomic,assign)int godown;

@property(nonatomic,assign)CGRect scrollFrame;

@property(nonatomic,strong)UIImageView *curImageView;

@property(nonatomic,assign)CycleDirection scrollDirection;  // scrollView滚动的方向

@property(nonatomic,strong) NSMutableArray *curImages;      // 存放当前滚动的三张图片

@property(nonatomic,assign)BOOL  isNetwork;
@end

@implementation MCScrollView

- (id)initWithFrame:(CGRect)frame cycleDirection:(CycleDirection)direction pictures:(NSArray *)pictureArray isNetworkLink:(BOOL)isNetwork
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.scrollFrame = frame;
        self.scrollDirection = direction;
        self.totalPage = (int)pictureArray.count;
        self.curPage = 1;                                    // 显示的是图片数组里的第一张图片
        self.curImages = [[NSMutableArray alloc] init];
        self.imagesArray = [[NSArray alloc] initWithArray:pictureArray];
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.bounces=NO;
        self.isNetwork=isNetwork;
        [self addSubview:self.scrollView];
       
        // 在水平方向滚动
        if(self.scrollDirection == CycleDirectionLandscape) {
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3,
                                                     self.scrollView.frame.size.height);
        }
        // 在垂直方向滚动
        if(self.scrollDirection == CycleDirectionPortait) {
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                                     self.scrollView.frame.size.height * 3);
        }
        [self addSubview:self.scrollView];
        [self refreshScrollView];
    }
    
    return self;
}
- (void)refreshScrollView {
    
    NSArray *subViews = [self.scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:self.curPage];
    
    for (int i = 0; i < 3; i++) {
        MCZoomScrollView * mc=[[MCZoomScrollView alloc]initWithFrame:self.scrollFrame];
        if (self.isNetwork) {
            [mc.imageView sd_setImageWithURL:[self.curImages objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"BrowserBG"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                int h=mc.imageView.image.size.height*self.scrollFrame.size.width/mc.imageView.image.size.width;
                h=h<self.scrollFrame.size.height?self.scrollFrame.size.height:h;
                mc.imageView.frame=CGRectMake(0, 0, self.scrollFrame.size.width, h);
            }];
        }else {
            mc.imageView.image=[self.curImages objectAtIndex:i];
            int h=mc.imageView.image.size.height*self.scrollFrame.size.width/mc.imageView.image.size.width;
            h=h<self.scrollFrame.size.height?self.scrollFrame.size.height:h;
            mc.imageView.frame=CGRectMake(0, 0, self.scrollFrame.size.width, h);
        }
        



        
        mc.contentSize=mc.imageView.frame.size;
        mc.imageView.contentMode=UIViewContentModeScaleAspectFit;
        
        if (i==0&&self.scrollDirection==CycleDirectionPortait) {
            mc.contentOffset=CGPointMake(0, mc.contentSize.height-self.scrollFrame.size.height);
        }
        if (self.godown==1&&i==1) {
            mc.contentOffset=CGPointMake(0, mc.contentSize.height-self.scrollFrame.size.height);
            self.godown=0;
        }
        // 水平滚动
        if(self.scrollDirection == CycleDirectionLandscape) {
            mc.frame = CGRectOffset(mc.frame, self.scrollFrame.size.width * i, 0);
        }
        // 垂直滚动
        if(self.scrollDirection == CycleDirectionPortait) {
            mc.frame = CGRectOffset(mc.frame, 0, self.scrollFrame.size.height * i);
        }
        
        [self.scrollView addSubview:mc];
    }
    if (self.scrollDirection == CycleDirectionLandscape) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollFrame.size.width, 0)];
    }
    if (self.scrollDirection == CycleDirectionPortait) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollFrame.size.height)];
    }
}

- (NSArray *)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:self.curPage-1];
    int last = [self validPageValue:self.curPage+1];
    
    if([self.curImages count] != 0) [self.curImages removeAllObjects];
    
    [self.curImages addObject:[self.imagesArray objectAtIndex:pre-1]];
    [self.curImages addObject:[self.imagesArray objectAtIndex:self.curPage-1]];
    [self.curImages addObject:[self.imagesArray objectAtIndex:last-1]];
    
    return self.curImages;
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == 0) value = self.totalPage;                   // value＝1为第一张，value = 0为前面一张
    if(value == self.totalPage + 1) value = 1;
    
    return (int)value;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    int y = aScrollView.contentOffset.y;
    NSLog(@"did  x=%d  y=%d", x, y);
    
    // 水平滚动
    if(self.scrollDirection == CycleDirectionLandscape) {
        // 往下翻一张
        if(x >= (2*self.scrollFrame.size.width)) {
            self.curPage = [self validPageValue:self.curPage+1];
            [self refreshScrollView];
        }
        if(x <= 0) {
            self.curPage = [self validPageValue:self.curPage-1];
            [self refreshScrollView];
        }
    }
    
    // 垂直滚动
    if(self.scrollDirection == CycleDirectionPortait) {
        // 往下翻一张
        if(y >= 2 * (self.scrollFrame.size.height)) {
            self.curPage = [self validPageValue:self.curPage+1];
            [self refreshScrollView];
        }
        if(y <= 0) {
            self.curPage = [self validPageValue:self.curPage-1];
            if (self.scrollDirection==CycleDirectionPortait) {
                self.godown=1;
            }
            [self refreshScrollView];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(MCScrollViewDelegate:didScrollImageView:)]) {
        [self.delegate MCScrollViewDelegate:self didScrollImageView:self.curPage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    int y = aScrollView.contentOffset.y;
    
    NSLog(@"--end  x=%d  y=%d", x, y);
    
    if (self.scrollDirection == CycleDirectionLandscape) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollFrame.size.width, 0) animated:YES];
    }
    if (self.scrollDirection == CycleDirectionPortait) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollFrame.size.height) animated:YES];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(MCScrollViewDelegate:didSelectImageView:)]) {
        [self.delegate MCScrollViewDelegate:self didSelectImageView:self.curPage];
    }
}




@end
