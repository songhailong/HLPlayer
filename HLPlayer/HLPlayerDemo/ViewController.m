//
//  ViewController.m
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/20.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "ViewController.h"
#import "VideoViewController.h"
@interface ViewController ()
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataarr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(100, 30, 100, 70)];
    [button setTitle:@"播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playaction) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor redColor];
    [self.view addSubview:button];
    
}

-(void)playaction{
    VideoViewController *video=[[VideoViewController alloc]init];
    [self presentViewController:video animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
