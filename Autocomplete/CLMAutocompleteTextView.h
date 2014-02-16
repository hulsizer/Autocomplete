//
//  CLMAutocompleteTextView.h
//  Autocomplete
//
//  Created by Andrew Hulsizer on 2/11/14.
//  Copyright (c) 2014 ClassyMonsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLMAutocompleteTextViewDataSource;

@interface CLMAutocompleteTextView : UITextView

- (id)initWithFrame:(CGRect)frame dataSource:(id<CLMAutocompleteTextViewDataSource>)dataSource;

@property (nonatomic, weak) IBOutlet id<CLMAutocompleteTextViewDataSource> dataSource;
@end

@protocol CLMAutocompleteTextViewDataSource <NSObject>

- (NSArray *)resultsForTextView:(UITextView *)textView prefix:(NSString *)prefix;
- (NSString *)nibNameForResultsCell;
@end