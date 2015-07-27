//
//  ViewController.m
//  popupProject
//
//  Created by Adrian Ortuzar on 23/07/15.
//  Copyright (c) 2015 Adrian Ortuzar. All rights reserved.
//

#import "ViewController.h"
#import "SCPopupViewController.h"
#import "ContentPopupViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openPopupAction:(id)sender {
    ContentPopupViewController *contentVC = [ContentPopupViewController new];
    UIView *popupContent = contentVC.view;
    SCPopupViewController *popup = [[SCPopupViewController alloc] initWithContentView:popupContent onTargetViewController:self];
    [popup show];
}

@end
