//
//  Connection Manager.m
//  UberAssignment
//
//  Created by Ankita Mishra on 02/10/19.
//  Copyright © 2019 Ankita Mishra. All rights reserved.
//

#import "Connection Manager.h"

@implementation Connection_Manager

/*
    creating instance
*/
+ (Connection_Manager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}


#pragma mark GET SERVER DATA API

-(void)getServerData:(NSString *)page andText:(NSString *)searchText withCompletion:(void (^)(NSDictionary *news, NSError *error))completion{

    NSString *path = [NSString stringWithFormat:@"?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736& format=json&nojsoncallback=1&safe_search=1&text=%@&page=%@",searchText,page];
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self makePostRequest:@"https://api.flickr.com/services/rest/" path:path param:nil httpMethod:@"GET" httpBody:nil completion:completion];
}


/*
    Connection Request
*/

- (void)makePostRequest:(NSString *)url path:(NSString *)path param:(NSMutableDictionary*)param httpMethod:(NSString *)httpMethod httpBody:(NSData *)httpBody completion:(void (^)(id result, NSError *error))completion
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    request.timeoutInterval = 60;
    NSString *appurl = [NSString stringWithFormat:@"%@%@",url,path];
    NSLog(@"appurl %@",appurl);
    [request setURL:[NSURL URLWithString:appurl]];
    [request setHTTPMethod:httpMethod];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            // If any error occurs then just display its description on the console.
            NSLog(@"error DESCRIPTION:: %@", [error localizedDescription]);
            if (completion) {
                completion(data, error);
            }
        }
        else{
            // If no error occurs, check the HTTP status code.
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSData *objectData = [result dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
            
            // If it's other than 200, then show it on the console.
            if (HTTPStatusCode != 200) {
                NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
            }
            // Call the completion handler with the returned data on the main thread.
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                if (completion) {
                    completion(json, error);
                }
            }];
        }
    }];
    
    [postDataTask resume];
}


@end
