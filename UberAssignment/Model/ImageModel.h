//
//  ImageModel.h
//  UberAssignment
//
//  Created by Ankita Mishra on 02/10/19.
//  Copyright © 2019 Ankita Mishra. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject

@property (nonatomic, strong, readonly) NSString *image_id;
@property (nonatomic, strong, readonly) NSString *owner;
@property (nonatomic, strong, readonly) NSString *secret;
@property (nonatomic, strong, readonly) NSString *server;
@property (nonatomic, strong, readonly) NSString *farm;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSNumber *ispublic;
@property (nonatomic, strong, readonly) NSNumber *isfriend;
@property (nonatomic, strong, readonly) NSNumber *isfamily;

- (void)parseObject:(NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END
