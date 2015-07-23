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

- (id)initWithContentView:(UIView*)content onTargetViewController:(UIViewController*)targetViewController
{
    self = [self init];
    if (self) {
        self.contentView = content;
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
    
    [self.view addSubview:self.backgroundView];
    
    [self.view addSubview:self.contentView];
    
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                        action:@selector(showGestureForTapRecognizer:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self.backgroundView addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer
{
    [self hide];
}

-(UIView *)contentView
{
    if (!_contentView) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        int width = 300;
        int height = 300;
        int x = (CGRectGetWidth(screenRect)/2) - width/2;
        int y = (CGRectGetHeight(screenRect)/2) - height/2;
        CGRect rect = CGRectMake(x, y, width, height);
        _contentView = [[UIView alloc] initWithFrame:rect];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

-(UIView *)backgroundView
{
    if (!_backgroundView) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        _backgroundView = [[UIView alloc] initWithFrame:screenRect];
        _backgroundView.backgroundColor = _RGBA(0,0,0,0.5);
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
