//
//  CLMAutocompleteView.m
//  Autocomplete
//
//  Created by Andrew Hulsizer on 2/3/14.
//  Copyright (c) 2014 ClassyMonsters. All rights reserved.
//

#import "CLMAutocompleteView.h"
#import "CLMAutocompleteCell.h"

@interface CLMAutocompleteView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *cachedResults;

@property (nonatomic, strong) CLMAutocompleteCell *sizingCell;
@end

@implementation CLMAutocompleteView

- (id)initWithFrame:(CGRect)frame delegate:(id<CLMAutocompleteViewDelegate>)delegate dataSource:(id<CLMAutocompleteViewDataSource>)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _delegate = delegate;
        _dataSource = dataSource;
        [self setupStyles];
        [self setupCollectionView];
    }
    return self;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupStyles];
        [self setupCollectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self registerCells];
}

- (void)setupStyles
{
    self.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    
    [self registerCells];
}

- (void)registerCells
{
    if ([self.dataSource respondsToSelector:@selector(nibNameForAutocomplete)]) {
        NSString *cellName = [self.dataSource nibNameForAutocomplete];
        if (cellName) {
            [self.collectionView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:cellName];
            self.sizingCell = [[[UINib nibWithNibName:cellName bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
        }else{
            [self registerDefaultCell];
        }
        
    }else{
        [self registerDefaultCell];
    }
}

- (void)setAutoCompleteResults:(NSArray *)autoCompleteResults
{
    self.cachedResults = autoCompleteResults;
    [self.collectionView reloadData];
}

- (void)registerDefaultCell
{
    [self.collectionView registerClass:[CLMAutocompleteCell class] forCellWithReuseIdentifier:NSStringFromClass([CLMAutocompleteCell class])];
    self.sizingCell = [[CLMAutocompleteCell alloc] init];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sizingCell setTitle:self.cachedResults[indexPath.item]];
    [self.sizingCell sizeToFit];
    return CGSizeMake(CGRectGetWidth(self.sizingCell.frame), CGRectGetHeight(self.frame));
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.cachedResults count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLMAutocompleteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CLMAutocompleteCell class]) forIndexPath:indexPath];
    
    [cell setTitle:self.cachedResults[indexPath.item]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(autoCompleteResultSelected:)]) {
        NSString *result = [NSString stringWithFormat:@"%@ ",self.cachedResults[indexPath.item]];
        [self.delegate autoCompleteResultSelected:result];
    }
}
@end
