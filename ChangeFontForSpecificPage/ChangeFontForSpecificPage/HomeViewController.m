//
//  HomeViewController.m
//  ChangeFontForSpecificPage
//
//  Created by Yu Fan on 2019/5/15.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "HomeViewController.h"
#import "TestViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) UIButton *pushButton;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textLabel = [UILabel new];
    self.textLabel.text = @"测试，在不侵入且没有暴露接口的情况下，改变指定Controller里所有字体的大小";
    self.textLabel.frame = CGRectMake(20, 100, 300, 100);
    self.textLabel.font = [UIFont systemFontOfSize:20];
    self.textLabel.textColor = [UIColor redColor];
    self.textLabel.numberOfLines = 0;
    [self.view addSubview:self.textLabel];
    
    self.pushButton = [UIButton new];
    self.pushButton.frame = CGRectMake(0, 0, 100, 50);
    self.pushButton.center = self.view.center;
    [self.pushButton setTitle:@"showVC" forState:UIControlStateNormal];
    [self.pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.pushButton addTarget:self action:@selector(pushButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pushButton];
}

- (void)pushButtonTapped {
    TestViewController *vc = [TestViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
