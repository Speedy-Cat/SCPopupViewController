//
//  SCPopupContainerViewController.h
//  popupProject
//
//  Created by Adrian Ortuzar on 27/07/15.
//  Copyright (c) 2015 Adrian Ortuzar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCPopupContainerDelegate <NSObject>

@optional
-(void)closeActioned:(id)sender;

@end

@interface SCPopupContainerViewController : UIViewController

@property (nonatomic, weak) id <SCPopupContainerDelegate> delegate;

- (IBAction)closeAction:(id)sender;

@end



