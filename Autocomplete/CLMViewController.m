//
//  CLMViewController.m
//  Autocomplete
//
//  Created by Andrew Hulsizer on 2/3/14.
//  Copyright (c) 2014 ClassyMonsters. All rights reserved.
//

#import "CLMViewController.h"
#import "CLMAutocompleteTextView.h"
#import "CLMAutocompleteCell.h"
@interface CLMViewController () <CLMAutocompleteTextViewDataSource>

@property (nonatomic, strong) IBOutlet CLMAutocompleteTextView *textField;

@end

@implementation CLMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CLMAutocompleteTextViewDataSource

- (NSArray *)resultsForTextView:(UITextView *)textView prefix:(NSString *)prefix
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSDictionary *autoComplete = @{@"A": @[@"Apple",@"Ape", @"Angle"], @"B": @[@"Banana",@"BBQ"]};
    
    if (prefix.length >= 1) {
        NSArray *arrayBucket = autoComplete[[prefix substringToIndex:1]];
        for (NSString *string in arrayBucket) {
            if ([string rangeOfString:prefix].location != NSNotFound) {
                [results addObject:string];
            }
        }
    }
    
    return results;
}

//- (NSString *)nibNameForResultsCell
//{
//    return @"CLMAutocompleteExampleCell";
//}


@end
