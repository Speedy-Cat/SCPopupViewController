//
//  SCPopupViewController.m
//  popupProject
//
//  Created by Adrian Ortuzar on 23/07/15.
//  Copyright (c) 2015 Adrian Ortuzar. All rights reserved.
//

#import "SCPopupViewController.h"
#import "KGKeyboardChangeManager.h"

#define _RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface SCPopupViewController ()

@property (nonatomic) CGSize containerViewSize;

@end



@implementation SCPopupViewController

@synthesize containerViewController = _containerViewController;

- (id)initWithContentView:(SCPopupContainerViewController*)content onTargetViewController:(UIViewController*)targetViewController
{
    self = [super init];
    if (self) {
        
        if (content) {
            
            self.containerViewController = content;
        }

        self.targetViewController = targetViewController;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // container
    [self addChildViewController:self.containerViewController];
    self.containerViewController.delegate = self;
    
    self.containerViewSize = self.containerViewController.view.frame.size;
    
    //
    // add subviews
    //
    [self.view addSubview:self.backgroundView];
    self.containerViewController.view.frame = [self rectOutContainerView:self.containerViewController.view];
    [self.view addSubview:self.containerViewController.view];
    
    //
    // Create and initialize a tap gesture
    //
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                        action:@selector(showGestureForTapRecognizer:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self.backgroundView addGestureRecognizer:tapRecognizer];
    
    //
    // keyboard observers
    //
    [[KGKeyboardChangeManager sharedManager] addObserverForKeyboardChangedWithBlock:^(BOOL show, CGRect keyboardRect, NSTimeInterval animationDuration, UIViewAnimationCurve animationCurve) {
        
        CGRect resultRect;
        if (show){
            //
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            
            //
            CGRect containerRect = self.containerViewController.view.frame;
            
            //
            resultRect = ^CGRect(){
                CGRect frame;
                
                int screenSpaceHeight = CGRectGetHeight(screenRect) - CGRectGetHeight(keyboardRect);
                if (screenSpaceHeight < containerRect.size.height) {
                    frame = CGRectMake(CGRectGetMinX(containerRect), 0, CGRectGetWidth(containerRect), CGRectGetHeight(screenRect) - CGRectGetHeight(keyboardRect));
                }
                else{
                    // center y
                    int screenTop = (CGRectGetHeight(screenRect) - CGRectGetHeight(keyboardRect))/2;
                    int containerCenterY = CGRectGetHeight(containerRect)/2;
                    int y = screenTop - containerCenterY;
                    
                    frame = CGRectMake(CGRectGetMinX(containerRect), y, CGRectGetWidth(containerRect), CGRectGetHeight(containerRect));
                }
                
                return frame;
            }();
            
        }
        else{
            CGRect frame = self.containerViewController.view.frame;
            self.containerViewController.view.frame = CGRectMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame), self.containerViewSize.width, self.containerViewSize.height);
            resultRect = [self rectCenterContainerView:self.containerViewController.view];
        }
        
        
        self.containerViewController.view.frame = resultRect;
     }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.backgroundView.alpha != 1) {
        // background fade in animation
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundView.alpha = 1;
        } completion:^(BOOL finished) {
            
            // view animation
            
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 CGRect frame = [self rectCenterContainerView:self.containerViewController.view];
                                 self.containerViewController.view.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 20, CGRectGetWidth(frame), CGRectGetHeight(frame));
                                 
                             } completion:^(BOOL finished) {
                                 
                                 [UIView animateWithDuration:0.3
                                                       delay:0
                                                     options:0
                                                  animations:^{
                                                      
                                                      self.containerViewController.view.frame = [self rectCenterContainerView:self.containerViewController.view];
                                                      
                                                  } completion:^(BOOL finished) {
                                                      
                                                  }];
                             }];
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer
{
    if (self.hideWhenTouchBackground) {
        [self hide];
    }
}

/**
 Get rect of the view out side of the screen to start the animation
 */
-(CGRect)rectOutContainerView:(UIView*)container
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect viewRect = [container bounds];
    
    int width = CGRectGetWidth(viewRect);
    int height = CGRectGetHeight(viewRect);
    int x = (CGRectGetWidth(screenRect)/2) - width/2;
    int y = - height;
    
    return CGRectMake(x, y, width, height);
}

/**
 Get rect of the view out side of the screen to end the animation
 */
-(CGRect)rectCenterContainerView:(UIView*)container
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect viewRect = [container bounds];

    int width = CGRectGetWidth(viewRect);
    int height = CGRectGetHeight(viewRect);
    int x = (CGRectGetWidth(screenRect)/2) - width/2;
    int y = (CGRectGetHeight(screenRect)/2) - CGRectGetHeight(container.frame)/2;;
    
   
    return CGRectMake(x, y, width, height);
}

-(void)setContainerView:(SCPopupContainerViewController *)containerViewController
{
    //center the view
    CGRect rect = [self rectOutContainerView:containerViewController.view];
    containerViewController.view.frame = rect;
    
    _containerViewController = containerViewController;
}

-(UIView *)backgroundView
{
    if (!_backgroundView) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        _backgroundView = [[UIView alloc] initWithFrame:screenRect];
        _backgroundView.backgroundColor = _RGBA(0,0,0,0.5);
        self.backgroundView.alpha = 0;
    }
    return _backgroundView;
}

-(void)show
{
    [self.targetViewController addChildViewController:self];
    [self.targetViewController.view addSubview:self.view];
}

-(void)hide
{
    // hide keyboard
    [self.view endEditing:YES];
    
    // animation
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:0
                     animations:^{
                         
                         CGRect frame = [self rectCenterContainerView:self.containerViewController.view];
                         self.containerViewController.view.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 20, CGRectGetWidth(frame), CGRectGetHeight(frame));
                        
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.4
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              
                                              
                                              self.containerViewController.view.frame = [self rectOutContainerView:self.containerViewController.view];
                                              
                                          }
                                          completion:^(BOOL finished) {
                                              self.view.hidden = YES;
                                              [self.view endEditing:YES];
                                              
                                              [self.containerViewController.view removeFromSuperview];
                                              [self.containerViewController removeFromParentViewController];
                                              
                                              [self.view removeFromSuperview];
                                              [self removeFromParentViewController];
                                              
                                              
                                          }];
                     }];
}

#pragma SCPopupControllerDelegate

-(void)closeActioned:(id)sender
{
    [self hide];
    
}

-(void)dealloc{
    
}



@end
