//
//  MainViewController.m
//  CycleScroll
//
//  Created by 陈正星 on 15/1/30.
//  Copyright (c) 2015年 MarcoChen. All rights reserved.
//

#import "MainViewController.h"
#import "LandscapeViewController.h"
#import "PortaitViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIDeviceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Landscape:(id)sender {

    LandscapeViewController *land=[[LandscapeViewController alloc]init];
    [self.navigationController pushViewController:land animated:YES];
    
}
- (IBAction)Portait:(id)sender {
    PortaitViewController * port=[[PortaitViewController alloc]init];
    [self.navigationController pushViewController:port animated:YES];
}

- (IBAction)LandscapeDL:(id)sender {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    LandscapeViewController *land=[[LandscapeViewController alloc]init];
    [self.navigationController pushViewController:land animated:YES];
}
- (IBAction)PrtaitDP:(id)sender {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    PortaitViewController * port=[[PortaitViewController alloc]init];
    [self.navigationController pushViewController:port animated:YES];
}


@end
