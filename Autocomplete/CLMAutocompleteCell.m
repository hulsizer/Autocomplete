//
//  CLMAutocompleteCell.m
//  Autocomplete
//
//  Created by Andrew Hulsizer on 2/3/14.
//  Copyright (c) 2014 ClassyMonsters. All rights reserved.
//

#import "CLMAutocompleteCell.h"

static const CGFloat kCellPadding = 10;

@interface CLMAutocompleteCell ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@end

@implementation CLMAutocompleteCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellPadding/2, 0, CGRectGetWidth(self.bounds)+kCellPadding, CGRectGetHeight(self.frame))];
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:17];
    self.titleLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    [self addSubview:self.titleLabel];
    
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    self.autoresizesSubviews = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)sizeToFit{
    [self.titleLabel sizeToFit];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.titleLabel.frame)+kCellPadding, CGRectGetHeight(self.frame));
}
@end
