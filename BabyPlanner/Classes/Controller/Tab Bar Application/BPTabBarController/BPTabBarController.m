//
//  BPTabBarController.m
//  BabyPlanner
//
//  Created by Mykola Vyshynskyi on 24.06.13.
//  Copyright (c) 2013 Mykola Vyshynskyi. All rights reserved.
//

#import "BPTabBarController.h"
#import "BPUtils.h"
#import "UIImage+Additions.h"

@interface BPTabBarController ()

@end

@implementation BPTabBarController

+ (void)initialize
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        UITextAttributeTextColor: RGB(149, 149, 149),
                                                        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                                                        UITextAttributeFont: [UIFont fontWithName:@"HelveticaNeue" size:10]
                                                        }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        UITextAttributeTextColor: RGB(255, 255, 255),
                                                        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                                                        UITextAttributeFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:10]
                                                        }
                                             forState:UIControlStateSelected];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.tabBar.backgroundColor = [UIColor blackColor];
    self.tabBar.backgroundImage = [BPUtils imageNamed:@"tabbar_background"];
    self.tabBar.selectionIndicatorImage = [[BPUtils imageNamed:@"tabbar_selectionIndicator"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8) resizingMode:UIImageResizingModeStretch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
