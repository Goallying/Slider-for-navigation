//
//  ViewController1.m
//  Slider_Testing
//
//  Created by 万存 on 16/3/31.
//  Copyright © 2016年 WanCun. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"
@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"黄色第一页";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    ViewController2 * v = [ViewController2 new] ;
    [self.navigationController pushViewController:v animated:YES] ;
}


@end
