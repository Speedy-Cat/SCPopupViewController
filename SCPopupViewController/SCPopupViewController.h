//
//  SCPopupViewController.h
//  popupProject
//
//  Created by Adrian Ortuzar on 23/07/15.
//  Copyright (c) 2015 Adrian Ortuzar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPopupContainerViewController.h"

@interface SCPopupViewController : UIViewController <SCPopupContainerDelegate>

- (id)initWithContentView:(SCPopupContainerViewController*)content onTargetViewController:(UIViewController*)targetViewController;
-(void)show;
-(void)hide;

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) SCPopupContainerViewController *containerViewController;
@property (strong, nonatomic) UIViewController *targetViewController;
@property (nonatomic) BOOL hideWhenTouchBackground;

@end
