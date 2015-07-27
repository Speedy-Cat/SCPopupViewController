//
//  ContentPopupViewController.m
//  popupProject
//
//  Created by Adrian Ortuzar on 27/07/15.
//  Copyright (c) 2015 Adrian Ortuzar. All rights reserved.
//

#import "ContentPopupViewController.h"

@interface ContentPopupViewController ()

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation ContentPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.closeButton addTarget:self
                         action:@selector(closeAction:)
       forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
