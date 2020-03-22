//
//  ViewController.m
//  DashLine Demo
//
//  Created by FanYu on 9/21/16.
//  Copyright © 2016 SRT. All rights reserved.
//

#import "ViewController.h"
#import "DashLineView.h"

@interface ViewController ()
@property (nonatomic, strong) DashLineView *lineView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lineView = [[DashLineView alloc] initWithFrame:CGRectMake(20, 200, 200, 10) orientation:FYDottedLineOrientationHorizontal color:[UIColor redColor]];
    [self.view addSubview:self.lineView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.lineView drawWithDotLength:7 intervalLength:7];
}

@end
