//
//  Connection Manager.h
//  UberAssignment
//
//  Created by Ankita Mishra on 02/10/19.
//  Copyright © 2019 Ankita Mishra. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Connection_Manager : NSObject<NSURLSessionDelegate>

+ (Connection_Manager *)sharedInstance;

-(void)getServerData:(NSString *)page andText:(NSString *)searchText withCompletion:(void (^)(NSDictionary *news, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
