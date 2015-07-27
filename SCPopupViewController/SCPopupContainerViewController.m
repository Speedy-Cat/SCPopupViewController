//
//  SCPopupContainerViewController.m
//  popupProject
//
//  Created by Adrian Ortuzar on 27/07/15.
//  Copyright (c) 2015 Adrian Ortuzar. All rights reserved.
//

#import "SCPopupContainerViewController.h"

@interface SCPopupContainerViewController ()

@end

@implementation SCPopupContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(closeActioned:)]) {
        [self.delegate closeActioned:sender];
    }
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
