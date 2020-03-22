//
//  TestViewController.m
//  ChangeFontForSpecificPage
//
//  Created by Yu Fan on 2019/5/15.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"test";
    
    self.textLabel = [UILabel new];
    self.textLabel.text = @"测试，在不侵入且没有暴露接口的情况下，改变指定Controller里所有字体的大小";
    self.textLabel.numberOfLines = 0;
    self.textLabel.frame = CGRectMake(20, 100, 300, 300);
    self.textLabel.font = [UIFont systemFontOfSize:20];
    self.textLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.textLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"test viewWillAppear");
}

- (void)test {
    NSLog(@"dddd");
}

@end
