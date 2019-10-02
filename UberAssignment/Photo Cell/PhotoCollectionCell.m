//
//  PhotoCollectionCell.m
//  UberAssignment
//
//  Created by Ankita Mishra on 03/10/19.
//  Copyright © 2019 Ankita Mishra. All rights reserved.
//

#import "PhotoCollectionCell.h"

@implementation PhotoCollectionCell

/*
    update cell with image data
*/
-(void)updateCellFrame:(ImageModel *)imagemodel{
    NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg",imagemodel.farm,imagemodel.server,imagemodel.image_id,imagemodel.secret];

    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: photoURLString]];
        if ( data == nil ){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.photoImgView.image = [UIImage imageNamed:@"default"];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                self.photoImgView.image = [UIImage imageWithData: data];
            });
        }
    });
    
}


@end
