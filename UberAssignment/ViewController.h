//
//  ViewController.h
//  UberAssignment
//
//  Created by Ankita Mishra on 01/10/19.
//  Copyright © 2019 Ankita Mishra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollectionCell.h"
#import "Connection Manager.h"

@interface ViewController : UIViewController<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoader;

@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@end



