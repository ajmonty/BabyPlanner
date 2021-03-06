//
//  BPSettingsCell.m
//  BabyPlanner
//
//  Created by Mykola Vyshynskyi on 24.06.13.
//  Copyright (c) 2013 Mykola Vyshynskyi. All rights reserved.
//

#import "BPSettingsCell.h"
#import "BPUtils.h"
#import "UIImage+Additions.h"
#import "UIView+Sizes.h"

@interface BPSettingsCell()

//@property (nonatomic, strong) UIImageView *accessoryView;

@end

@implementation BPSettingsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        self.titleLabel.textColor = RGB(0, 0, 0);
        self.titleLabel.highlightedTextColor = RGB(255, 255, 255);
        [self.contentView addSubview:self.titleLabel];
        
        self.subtitleLabel = [[UILabel alloc] init];
        self.subtitleLabel.backgroundColor = [UIColor clearColor];
        self.subtitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        self.subtitleLabel.textColor = RGB(56, 84, 135);
        self.subtitleLabel.highlightedTextColor = RGB(255, 255, 255);
        self.subtitleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.subtitleLabel];
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[BPUtils imageNamed:@"cell_disclosureIndicator"]];
        self.accessoryView.highlightedImage = [self.accessoryView.image tintedImageWithColor:RGB(255, 255, 255) style:UIImageTintedStyleKeepingAlpha];
        [self.contentView addSubview:self.accessoryView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat left = BPDefaultCellInset;
    CGFloat maxWidth = self.contentView.width - (self.accessoryView.image.size.width + 3*BPDefaultCellInset);
    
    if (self.titleLabel.text.length) {
        self.titleLabel.frame = CGRectMake(left, 0, 120.f, self.contentView.height);
        left += self.titleLabel.width + BPDefaultCellInset;
        maxWidth -= self.titleLabel.width + BPDefaultCellInset;
    } else {
        self.titleLabel.frame = CGRectZero;
    }
    
    if (self.subtitleLabel.text.length) {
        self.subtitleLabel.frame = CGRectMake(left, 0, maxWidth, self.contentView.height);
        left += self.subtitleLabel.width + BPDefaultCellInset;
    } else {
        self.subtitleLabel.frame = CGRectZero;
    }
    
    self.accessoryView.frame = CGRectMake(self.contentView.width - self.accessoryView.image.size.width - BPDefaultCellInset,
                                          floorf(self.contentView.height/2 - self.accessoryView.image.size.height/2),
                                          self.accessoryView.image.size.width, self.accessoryView.image.size.height);
}

@end
