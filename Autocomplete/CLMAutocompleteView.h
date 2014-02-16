//
//  CLMAutocompleteView.h
//  Autocomplete
//
//  Created by Andrew Hulsizer on 2/3/14.
//  Copyright (c) 2014 ClassyMonsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLMAutocompleteViewDataSource;
@protocol CLMAutocompleteViewDelegate;

@interface CLMAutocompleteView : UIView

- (id)initWithFrame:(CGRect)frame delegate:(id<CLMAutocompleteViewDelegate>)delegate dataSource:(id<CLMAutocompleteViewDataSource>)dataSource;

- (void)setAutoCompleteResults:(NSArray *)autoCompleteResults;
@property (nonatomic, weak) IBOutlet id<CLMAutocompleteViewDelegate> delegate;
@property (nonatomic, weak) IBOutlet id<CLMAutocompleteViewDataSource> dataSource;
@end

@protocol CLMAutocompleteViewDelegate <NSObject>

- (void)autoCompleteResultSelected:(NSString *)resultString;
@end

@protocol CLMAutocompleteViewDataSource <NSObject>

- (NSString *)nibNameForAutocomplete;
@end