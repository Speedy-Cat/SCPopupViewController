//
//  SCPopupViewController.m
//  popupProject
//
//  Created by Adrian Ortuzar on 23/07/15.
//  Copyright (c) 2015 Adrian Ortuzar. All rights reserved.
//

#import "SCPopupViewController.h"

#define _RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface SCPopupViewController ()

@property UIViewController *targetViewController;

@end



@implementation SCPopupViewController

@synthesize containerView = _containerView;

- (id)initWithContentView:(UIView*)content onTargetViewController:(UIViewController*)targetViewController
{
    self = [self init];
    if (self) {
        self.containerView = content;
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
    
    // add subviews
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.containerView];
    
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                        action:@selector(showGestureForTapRecognizer:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self.backgroundView addGestureRecognizer:tapRecognizer];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // animations
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            int y = (CGRectGetHeight(screenRect)/2) - CGRectGetHeight(self.containerView.frame)/2;
            CGRect rect = CGRectMake( CGRectGetMinX(self.containerView.frame), y, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame));
            self.containerView.frame = rect;
            
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

-(CGRect)getRectForContainer:(UIView*)container
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect viewRect = [container bounds];
    
    int width = CGRectGetWidth(viewRect);
    int height = CGRectGetHeight(viewRect);
    int x = (CGRectGetWidth(screenRect)/2) - width/2;
    int y = - height;
    
    return CGRectMake(x, y, width, height);
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
        rect = [self getRectForContainer:_containerView];
        _containerView.frame = rect;
         _containerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _containerView;

}

-(void)setContainerView:(UIView *)containerView
{
    //center the view
    CGRect rect = [self getRectForContainer:containerView];
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



@end
