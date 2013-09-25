//
//  BPCalendarCell.h
//  BabyPlanner
//
//  Created by Mykola Vyshynskyi on 25.09.13.
//  Copyright (c) 2013 Mykola Vyshynskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPCalendarCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic, strong) NSNumber *pregnant;
@property (nonatomic, strong) NSNumber *menstruation;
@property (nonatomic, strong) NSNumber *sexualIntercourse;
@property (nonatomic, strong) NSNumber *ovulation;
@property (nonatomic, strong) NSNumber *childBirth;

@end