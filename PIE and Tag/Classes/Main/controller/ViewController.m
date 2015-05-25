//
//  ViewController.m
//  pieDemo
//
//  Created by 黄少华 on 15/5/18.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "ViewController.h"
#import "NXPieViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (IBAction)JumpBtn:(id)sender {
    NXPieViewController *peiVc = [[NXPieViewController alloc] init];
    [self.navigationController pushViewController:peiVc animated:YES];
}
@end
