//
//  BPMyChartsDiagramViewController.m
//  BabyPlanner
//
//  Created by Mykola Vyshynskyi on 23.09.13.
//  Copyright (c) 2013 Mykola Vyshynskyi. All rights reserved.
//

#import "BPMyChartsDiagramViewController.h"
#import "SVSegmentedControl.h"
#import "UIView+Sizes.h"

@interface BPMyChartsDiagramViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SVSegmentedControl *segmentedControl;

@end

@implementation BPMyChartsDiagramViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.statusBarView.backgroundColor = [UIColor clearColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.text = [NSString stringWithFormat:@"TODO:\n%@", [self class]];
    [self.scrollView addSubview:titleLabel];
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 40; i++) {
        [titles addObject:[NSString stringWithFormat:@"%i", i + 1]];
    }
    
    self.segmentedControl = [[SVSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 30.f*titles.count, 20.f)];
    self.segmentedControl.backgroundTintColor = nil;
    self.segmentedControl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    self.segmentedControl.textColor = RGB(4, 139, 106);
    self.segmentedControl.textShadowOffset = CGSizeZero;
    
//    self.segmentedControl.thumb.tintColor = nil;
//    self.segmentedControl.thumb.textColor = RGB(4, 139, 106);
//    self.segmentedControl.thumb.textShadowOffset = CGSizeZero;
//    self.segmentedControl.thumb.shouldCastShadow = NO;
    
    self.segmentedControl.sectionTitles = titles;
    [self.scrollView addSubview:self.segmentedControl];
    self.scrollView.contentSize = CGSizeMake(self.segmentedControl.width, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BPBaseViewController

- (void)setBackgroundImage:(UIImage *)backgroundImage
{

}

@end
