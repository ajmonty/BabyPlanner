//
//  BPMyPregnancyYouAndYourBabyViewController.m
//  BabyPlanner
//
//  Created by Mykola Vyshynskyi on 13.08.13.
//  Copyright (c) 2013 Mykola Vyshynskyi. All rights reserved.
//

#import "BPMyPregnancyYouAndYourBabyViewController.h"
#import "BPUtils.h"
#import "BPValuePicker.h"
#import "BPWeekPicker.h"
#import "BPDate.h"
#import "ObjectiveRecord.h"
#import "BPThemeManager.h"
#import "UIImage+Additions.h"
#import "BPTemperaturesManager.h"
#import "BPPregnancyCalendarCell.h"
#import "ObjectiveSugar.h"
#import "BPSettings+Additions.h"
#import "UIView+Sizes.h"
#import <QuartzCore/QuartzCore.h>

#define BPPregnancyCalendarCellIdentifier @"BPPregnancyCalendarCellIdentifier"
#define BPPageSpacing 20.f

@interface BPMyPregnancyYouAndYourBabyViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BPValuePicker *pickerView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *rightButton;

- (void)showPreviousWeek;
- (void)showAllWeeks;
- (void)showNextWeek;

@end

@implementation BPMyPregnancyYouAndYourBabyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = BPLocalizedString(@"You & your baby");
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImage *selectWeekPanelBackground = [BPUtils imageNamed:@"mypregnancy_calendar_weekselect_panel_background"];
    UIImageView *selectWeekPanel = [[UIImageView alloc] initWithImage:selectWeekPanelBackground];
    selectWeekPanel.frame = CGRectMake(0, self.view.height - self.tabBarController.tabBar.height - selectWeekPanelBackground.size.height, self.view.width, selectWeekPanelBackground.size.height);
    [self.view addSubview:selectWeekPanel];
    
    UIImage *buttonBackground = [BPUtils imageNamed:@"mypregnancy_calendar_weekselect_button_background"];
    buttonBackground = [buttonBackground resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30)];
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    CGFloat inset = floor(selectWeekPanel.height/2 - buttonBackground.size.height/2);
    self.leftButton.frame = CGRectMake(inset, selectWeekPanel.top + inset, 90.f, buttonBackground.size.height);
    self.leftButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [self.leftButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(showPreviousWeek) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    
    self.middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.middleButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    self.middleButton.frame = CGRectMake(self.leftButton.right + inset, selectWeekPanel.top + inset, selectWeekPanel.width - 2*(self.leftButton.right + inset), buttonBackground.size.height);
    self.middleButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [self.middleButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [self.middleButton addTarget:self action:@selector(showAllWeeks) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.middleButton];

    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    self.rightButton.frame = CGRectMake(self.middleButton.right + inset, selectWeekPanel.top + inset, 90.f, buttonBackground.size.height);
    self.rightButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [self.rightButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(showNextWeek) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
	//[collectionViewFlowLayout setItemSize:CGSizeMake(self.view.width - 20, 320.0)];
	//[collectionViewFlowLayout setHeaderReferenceSize:CGSizeMake(320, 30)];
	//[collectionViewFlowLayout setFooterReferenceSize:CGSizeMake(320, 50)];
	//[collectionViewFlowLayout setMinimumInteritemSpacing:20];
    [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
	[collectionViewFlowLayout setMinimumInteritemSpacing:0];
	[collectionViewFlowLayout setMinimumLineSpacing:BPPageSpacing];
	[collectionViewFlowLayout setSectionInset:UIEdgeInsetsMake(0, floor(BPPageSpacing/2), 0, floor(BPPageSpacing/2))];
    
    CGRect collectionViewRect = CGRectMake(-floor(BPPageSpacing/2), 64.f, self.view.width + BPPageSpacing, selectWeekPanel.top - 64.f);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewRect collectionViewLayout:collectionViewFlowLayout];
    self.collectionView.backgroundView = nil;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[BPPregnancyCalendarCell class] forCellWithReuseIdentifier:BPPregnancyCalendarCellIdentifier];
    
    self.pickerView = [[BPValuePicker alloc] initWithFrame:CGRectMake(0, MAX(BPSettingsPickerMinimalOriginY, self.view.height - BPPickerViewHeight - self.tabBarController.tabBar.height), self.view.width, BPPickerViewHeight)];
    self.pickerView.hidden = YES;
    [self.pickerView addTarget:self action:@selector(pickerViewValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.pickerView addTarget:self action:@selector(pickerViewValueDidEndEditing) forControlEvents:UIControlEventEditingDidEnd];
    [self.pickerView addTarget:self action:@selector(pickerViewValueDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.pickerView];

    DLog(@"self.collectionView = %@", self.collectionView);
    DLog(@"self.pickerView = %@", self.pickerView);
    
    
    [self updateUI];
    [self localize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
}

- (void)updateUI
{
    [super updateUI];
    
    if (self.isViewLoaded) {
        self.leftButton.hidden = ([self.selectedWeek integerValue] == 1);
        self.rightButton.hidden = ([self.selectedWeek integerValue] == BPWeekPickerNumberOfWeeks);
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[self.selectedWeek integerValue] - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
//        self.pickerView.value = @(self.selectedWeek);

        NSString *leftButtonTitle = [NSString stringWithFormat:@"%@ %i", BPLocalizedString(@"Week"), [self.selectedWeek integerValue] - 1];
        [self.leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
        
        NSString *rightButtonTitle = [NSString stringWithFormat:@"%@ %i", BPLocalizedString(@"Week"), [self.selectedWeek integerValue] + 1];
        [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    }
}

- (void)localize
{
    [super localize];
    
    [self.middleButton setTitle:BPLocalizedString(@"All weeks") forState:UIControlStateNormal];
    
    self.pickerView.valuePickerMode = BPValuePickerModeNone;
    self.pickerView.valuePickerMode = BPValuePickerModeWeek;
    self.pickerView.value = self.selectedWeek;

    [self.collectionView reloadData];

    [self updateUI];
}

- (void)pickerViewValueChanged
{
    switch (self.pickerView.valuePickerMode) {
        case BPValuePickerModeWeek: {
            DLog(@"%i %@", self.pickerView.valuePickerMode, self.pickerView.value);
            self.selectedWeek = self.pickerView.value;
            [self updateUI];
        }
            break;
        default:
            break;
    }
}

- (void)pickerViewValueDidEndEditing
{
    self.selectedWeek = self.pickerView.value;
    self.pickerView.hidden = YES;

    [self updateUI];
}

#pragma mark - Private

- (void)showPreviousWeek
{
    self.selectedWeek = @([self.selectedWeek integerValue] - 1);
    self.pickerView.value = self.selectedWeek;
    [self updateUI];
}

- (void)showAllWeeks
{
    self.pickerView.hidden = NO;
}

- (void)showNextWeek
{
    self.selectedWeek = @([self.selectedWeek integerValue] + 1);
    self.pickerView.value = self.selectedWeek;
    [self updateUI];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *currentPath = self.collectionView.indexPathsForVisibleItems.first;
    self.selectedWeek = @(currentPath.item + 1);
    self.pickerView.value = self.selectedWeek;

    [self updateUI];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return BPWeekPickerNumberOfWeeks;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BPPregnancyCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BPPregnancyCalendarCellIdentifier forIndexPath:indexPath];
    
    cell.weekNumber = @(indexPath.item + 1);
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectInset(collectionView.bounds, floor(BPPageSpacing/2), 0).size;
}

@end
