//
//  SCPopupViewController.h
//  popupProject
//
//  Created by Adrian Ortuzar on 23/07/15.
//  Copyright (c) 2015 Adrian Ortuzar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPopupViewController : UIViewController

-(void)show;
-(void)hide;

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;

@end
