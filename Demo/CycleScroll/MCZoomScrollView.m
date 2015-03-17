//
//  MCZoomScrollView.m
//  CycleScroll
//
//  Created by 陈正星 on 15/1/29.
//  Copyright (c) 2015年 MarcoChen. All rights reserved.
//

#import "MCZoomScrollView.h"

@implementation MCZoomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        
        self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height+20);

        [self initImageView];
    }
    return self;
}
- (void)initImageView
{
    self.imageView = [[UIImageView alloc]init];
    // The imageView can be zoomed largest size
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width *3, self.frame.size.height*3 );

    self.imageView.userInteractionEnabled = YES;
    [self addSubview:self.imageView];
    
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleDoubleTap:)];
        [doubleTapGesture setNumberOfTapsRequired:2];
        [self.imageView addGestureRecognizer:doubleTapGesture];
    
    float minimumScale = self.frame.size.width / self.imageView.frame.size.width;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
}


#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    float newScale = self.zoomScale * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
    [self zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale animated:NO];
}

@end
