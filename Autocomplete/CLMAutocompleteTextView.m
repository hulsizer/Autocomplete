//
//  CLMAutocompleteTextView.m
//  Autocomplete
//
//  Created by Andrew Hulsizer on 2/11/14.
//  Copyright (c) 2014 ClassyMonsters. All rights reserved.
//

#import "CLMAutocompleteTextView.h"
#import "CLMAutocompleteView.h"

@interface CLMAutocompleteTextView () <CLMAutocompleteViewDelegate, CLMAutocompleteViewDataSource>

@property (nonatomic, strong) CLMAutocompleteView *autoView;
@end

@implementation CLMAutocompleteTextView

- (id)initWithFrame:(CGRect)frame dataSource:(id<CLMAutocompleteTextViewDataSource>)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dataSource = dataSource;
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    [self setupAutoComplete];
    [self setupNotifications];
}

- (void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}

- (void)setupAutoComplete
{
    self.autoView = [[CLMAutocompleteView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 35) delegate:self dataSource:self];
    self.inputAccessoryView = self.autoView;
}

#pragma mark - UITextFieldDelegate

- (void)textDidChange
{
    if ([self.dataSource respondsToSelector:@selector(resultsForTextView:prefix:)]) {
        NSArray *results = [self.dataSource resultsForTextView:self prefix:[self autoCompletePrefix]];
        [self.autoView setAutoCompleteResults:results];
    }
}

#pragma mark - CLMAutocompleteViewDataSource

- (NSString *)nibNameForAutocomplete {
    if ([self.dataSource respondsToSelector:@selector(nibNameForResultsCell)]) {
        return [self.dataSource nibNameForResultsCell];
    }
    
    return nil;;
}

#pragma mark - CLMAutocompleteViewDelegate

- (void)autoCompleteResultSelected:(NSString *)resultString
{
    UITextRange *textRange = [self textRangeForAutocomplete];
    [self replaceRange:textRange withText:resultString];
}

#pragma mark - Helpers

- (NSString *)autoCompletePrefix
{
    NSRange range = [self rangeForAutocomplete];
    return [self.text substringWithRange:range];
}

- (NSRange )rangeForAutocomplete
{
    if (self.text.length == 0) {
        return NSMakeRange(0, 0);
    }
    
    NSRange range = [self.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]
                                                  options:NSBackwardsSearch
                                                    range:NSMakeRange(0, (self.text.length - 1))];
    
    //Check if first word
    if (range.location == NSNotFound) {
        range.location = 0;
    }else{
        //Skip the space
        range.location += 1;
    }

    range.length = self.text.length-range.location;
    return range;
}
- (UITextRange *)textRangeForAutocomplete
{
    NSRange range = [self rangeForAutocomplete];
    
    
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];
    return textRange;
}
@end
