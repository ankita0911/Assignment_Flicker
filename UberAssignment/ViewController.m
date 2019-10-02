//
//  ViewController.m
//  UberAssignment
//
//  Created by Ankita Mishra on 01/10/19.
//  Copyright © 2019 Ankita Mishra. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

static NSString * const photoCellIdentifier = @"cell";

@implementation ViewController{
    NSString *searchStr;  //string used for searching
    NSInteger page;
    NSMutableArray *photosArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    searchStr = @"kittens";
    page = 1;
    _searchbar.text = searchStr;
    photosArray = [[NSMutableArray alloc] init];
    [self callServerRequest:[NSString stringWithFormat:@"%ld",(long)page] andSearch:searchStr];
}


#pragma mark WEBSERVICE CALLED
-(void)callServerRequest:(NSString *)pageValue andSearch:(NSString *)text{
    [_activityLoader setHidden:NO];
    [_activityLoader startAnimating];

    [[Connection_Manager sharedInstance] getServerData:pageValue andText:text withCompletion:^(NSDictionary * _Nonnull news, NSError * _Nonnull error) {
        
        for (NSDictionary *imageDict in [[news valueForKey:@"photos"]valueForKey:@"photo"]) {
            ImageModel *imagemodel = [[ImageModel alloc] init];
            [imagemodel parseObject:imageDict];
            [self->photosArray addObject:imagemodel];
        }
        [self->_collectionview reloadData];
        [self->_activityLoader stopAnimating];
        [self->_activityLoader setHidden:YES];
    }];
}


#pragma mark - UISearchControllerDelegate & UISearchResultsDelegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchbar.showsCancelButton = YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchbar.showsCancelButton = YES;
    searchStr = [NSString stringWithFormat:@"%@",_searchbar.text];   // get text for searching
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = false;
    page = 1;
    [photosArray removeAllObjects];
    [_collectionview reloadData];
    [self callServerRequest:[NSString stringWithFormat:@"%ld",(long)page] andSearch:searchStr];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _searchbar.text = searchStr;
    [_searchbar setShowsCancelButton:NO animated:YES];
    [_searchbar resignFirstResponder];
}


#pragma mark COLLECTIONVIEW DELEGATE AND DATASOURCE
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellIdentifier forIndexPath:indexPath];
    ImageModel *imgModel = [photosArray objectAtIndex:indexPath.row];
    [cell updateCellFrame:imgModel];
    
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == photosArray.count-1) {
        page += 1;
        [self callServerRequest:[NSString stringWithFormat:@"%ld",(long)page] andSearch:searchStr];
    }
}
@end
