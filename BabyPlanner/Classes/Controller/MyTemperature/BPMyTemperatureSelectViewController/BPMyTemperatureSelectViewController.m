//
//  BPMyTemperatureSelectViewController.m
//  BabyPlanner
//
//  Created by Mykola Vyshynskyi on 13.08.13.
//  Copyright (c) 2013 Mykola Vyshynskyi. All rights reserved.
//

#import "BPMyTemperatureSelectViewController.h"
#import "BPUtils.h"
#import "BPValuePicker.h"
#import "BPDate.h"
#import "ObjectiveRecord.h"

@interface BPMyTemperatureSelectViewController ()

@property (nonatomic, strong) BPValuePicker *pickerView;

@end

@implementation BPMyTemperatureSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = BPLocalizedString(@"Temperature");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.pickerView = [[BPValuePicker alloc] initWithFrame:CGRectMake(0, MAX(BPSettingsPickerMinimalOriginY, self.view.bounds.size.height - BPPickerViewHeight - self.tabBarController.tabBar.frame.size.height), self.view.bounds.size.width, BPPickerViewHeight)];
    [self.pickerView addTarget:self action:@selector(pickerViewValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pickerView];
    
    self.pickerView.valuePickerMode = BPValuePickerModeTemperature;
    self.pickerView.value = self.date.temperature;
    
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUI
{
    [super updateUI];
}

- (void)pickerViewValueChanged
{
    switch (self.pickerView.valuePickerMode) {
        case BPValuePickerModeTemperature:
            DLog(@"%s %i %@", __PRETTY_FUNCTION__, self.pickerView.valuePickerMode, self.pickerView.value);
            self.date.temperature = self.pickerView.value;
            [self.date save];
            break;
        default:
            break;
    }
}

@end