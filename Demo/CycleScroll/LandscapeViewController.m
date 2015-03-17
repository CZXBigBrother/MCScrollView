//
//  LandscapeViewController.m
//  CycleScroll
//
//  Created by 陈正星 on 15/1/30.
//  Copyright (c) 2015年 MarcoChen. All rights reserved.
//

#import "LandscapeViewController.h"
#import "MCScrollView.h"
@interface LandscapeViewController ()

@end

@implementation LandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
//    NSArray *arr2=@[ @"http://s.mangatown.com/store/manga/9/58-612.0/compressed/l001.jpg",
//                     @"http://s.mangatown.com/store/manga/9/58-612.0/compressed/l001a.jpg",
//                     @"http://s.mangatown.com/store/manga/9/58-612.0/compressed/l001c.jpg",
//                     @"http://s.mangatown.com/store/manga/9/58-612.0/compressed/l002.jpg",
//                     @"http://s.mangatown.com/store/manga/9/58-612.0/compressed/l003.jpg",
//                     @"http://s.mangatown.com/store/manga/9/58-612.0/compressed/l004.jpg",
//                     @"http://s.mangatown.com/store/manga/9/58-612.0/compressed/l005.jpg",];
    
    NSMutableArray * arr=[NSMutableArray array];
    for (int i =1; i<7; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"long%d.jpg",i]]];
    }
    MCScrollView *MC=[[MCScrollView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) cycleDirection:CycleDirectionLandscape pictures:arr isNetworkLink:NO];
    [self.view addSubview:MC];
    
    UIButton * back=[[UIButton alloc]init];
    back.frame=CGRectMake(0, 0, 50, 50);
    back.backgroundColor=[UIColor redColor];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back setTitle:@"back" forState:UIControlStateNormal];
    [self.view addSubview:back];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
