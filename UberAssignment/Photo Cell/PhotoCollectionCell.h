//
//  PhotoCollectionCell.h
//  UberAssignment
//
//  Created by Ankita Mishra on 03/10/19.
//  Copyright © 2019 Ankita Mishra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionCell : UICollectionViewCell<NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;

-(void)updateCellFrame:(ImageModel *)imagemodel;
@end

NS_ASSUME_NONNULL_END
