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

@property UIViewController *targetViewController;

@end



@implementation SCPopupViewController

@synthesize containerView = _containerView;

- (id)initWithContentView:(SCPopupContainerViewController*)content onTargetViewController:(UIViewController*)targetViewController
{
    self = [self init];
    if (self) {
        
        if (content) {
            [self addChildViewController:content];
            content.delegate = self;
            self.containerView = content.view;
        }

        self.targetViewController = targetViewController;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    //
    // add subviews
    //
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.containerView];
    
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
            CGRect containerRect = self.containerView.frame;
            
            // center y
            int screenTop = (CGRectGetHeight(screenRect) - CGRectGetHeight(keyboardRect))/2;
            int containerCenterY = CGRectGetHeight(containerRect)/2;
            int y = screenTop - containerCenterY;
            resultRect = CGRectMake(CGRectGetMinX(containerRect), y, CGRectGetWidth(containerRect), CGRectGetHeight(containerRect));
            
        }
        else{
            resultRect = [self getRectForEndAnimationForContainterView:self.containerView];
        }
        
        
        self.containerView.frame = resultRect;
     }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // animations
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.containerView.frame = [self getRectForEndAnimationForContainterView:self.containerView];
            
        } completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer
{
    [self hide];
}

/**
 Get rect of the view out side of the screen to start the animation
 */
-(CGRect)getRectForStartAnimationForContainterView:(UIView*)container
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
 Get rect of the view out side of the screen to start the animation
 */
-(CGRect)getRectForEndAnimationForContainterView:(UIView*)container
{

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int y = (CGRectGetHeight(screenRect)/2) - CGRectGetHeight(container.frame)/2;
    return CGRectMake( CGRectGetMinX(container.frame), y, CGRectGetWidth(container.frame), CGRectGetHeight(container.frame));
}

-(UIView *)containerView
{
    if (!_containerView) {
        //
        //default initialization
        //
    
        //center the view
        CGRect rect = CGRectMake(0, 0, 300, 300);
        _containerView = [[UIView alloc] initWithFrame:rect];
        rect = [self getRectForStartAnimationForContainterView:_containerView];
        _containerView.frame = rect;
         _containerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _containerView;

}

-(void)setContainerView:(UIView *)containerView
{
    //center the view
    CGRect rect = [self getRectForStartAnimationForContainterView:containerView];
    containerView.frame = rect;
    
    _containerView = containerView;
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
    self.view.hidden = YES;
}

#pragma SCPopupControllerDelegate

-(void)closeActioned:(id)sender
{
    [self hide];
    [self.view endEditing:YES];
}



@end
