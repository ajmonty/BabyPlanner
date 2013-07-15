//
//  BPSoundPicker.m
//  BabyPlanner
//
//  Created by Mykola Vyshynskyi on 06.07.13.
//  Copyright (c) 2013 Mykola Vyshynskyi. All rights reserved.
//

#import "BPSoundPicker.h"

@interface BPSoundPicker ()

@property (nonatomic, strong) NSString *soundName;
@property (nonatomic, strong) NSArray *sounds;

@end


@implementation BPSoundPicker

- (id)init
{
    self = [super init];
    if (self) {
        self.sounds = @[@"Crickets.caf", @"Digital.caf", @"Marimba.caf", @"Old Phone.caf", @"Piano Riff.caf"];
    }
    
    return self;
}

#pragma mark - BPPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(BPPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(BPPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.sounds count];
}

#pragma mark - BPPickerViewDelegate

- (void)pickerView:(BPPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    DLog(@"%i %i", row, component);
    
    NSString *soundName = _sounds[row];
    self.control.value = soundName;
}

- (CGFloat)pickerView:(BPPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 252.f;
}

- (UIView *)pickerView:(BPPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24];
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    label.text = [_sounds[row] stringByDeletingPathExtension];

    return label;
}

- (CGFloat)pickerView:(BPPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44.f;
}

#pragma mark - BPValuePickerDelegate

- (id)value
{
    return [@"Sounds.bundle" stringByAppendingPathComponent:self.soundName];
}

- (void)pickerView:(BPPickerView *)pickerView setValue:(id)value animated:(BOOL)animated
{
    DLog(@"%@ %@ %i", pickerView, value, animated);
    if (_soundName != value && [pickerView.dataSource isKindOfClass:[self class]]) {
        _soundName = [value lastPathComponent];
                
        DLog(@"_soundName %@", _soundName);
        
        [pickerView selectRow:[self.sounds indexOfObject:_soundName] inComponent:0 animated:animated];
    }
}

@end
