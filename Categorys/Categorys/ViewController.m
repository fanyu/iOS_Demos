//
//  ViewController.m
//  Categorys
//
//  Created by Yu Fan on 2019/5/21.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+PerformSelector.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(testAction:parmTwo:parmThree:) withObjects:@"1", @"2", @"3", [EndMark end]];
}

- (void)testAction:(NSString *)paraOne parmTwo:(NSString *)two parmThree:(NSString *)three {
    NSLog(@"%@,%@,%@", paraOne, two, three);
}

@end
