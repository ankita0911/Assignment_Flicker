//
//  ImageModel.m
//  UberAssignment
//
//  Created by Ankita Mishra on 02/10/19.
//  Copyright © 2019 Ankita Mishra. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


/*
    parse complete data from the dictionary
*/
-(void)parseObject:(NSDictionary *)response{
    _image_id = [self getStringForKey:@"id" fromDictionary:response withInitialValue:nil];
    _owner = [self getStringForKey:@"owner" fromDictionary:response withInitialValue:nil];
    _secret = [self getStringForKey:@"secret" fromDictionary:response withInitialValue:nil];
    _server = [self getStringForKey:@"server" fromDictionary:response withInitialValue:nil];
    _farm = [self getStringForKey:@"farm" fromDictionary:response withInitialValue:nil];
    _title = [self getStringForKey:@"title" fromDictionary:response withInitialValue:nil];
    _ispublic = [self getNumberForKey:@"ispublic" fromDictionary:response withInitialValue:nil];
    _isfriend = [self getNumberForKey:@"isfriend" fromDictionary:response withInitialValue:nil];
    _isfamily = [self getNumberForKey:@"isfamily" fromDictionary:response withInitialValue:nil];
}


//get number value from the dictionary
- (NSNumber *) getNumberForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary withInitialValue:(NSNumber *)initialValue
{
    NSNumber *returnVal = initialValue;
    
    @try {
        returnVal = [dictionary valueForKeyPath:key];
    } @catch (NSException *exception) {
        NSLog(@"Catched: %@ - %@", exception.name, exception.reason);
    }
    
    if (returnVal == nil || [returnVal class] == [NSNull class]) {
        return initialValue;
    } else {
        if([returnVal isKindOfClass:[NSString class]]) {
            NSString *tempString = (NSString *)returnVal;
            @try {
                returnVal = @([tempString doubleValue]);
            } @catch (NSException *exception) {
                NSLog(@"catched in get number of key %@", returnVal);
            }
        }
    }
    
    return returnVal;
}

//get string value from the dictionary
- (NSString *) getStringForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary withInitialValue:(NSString *)initialValue
{
    NSString *returnVal = initialValue;
    @try {
        returnVal = [dictionary valueForKeyPath:key];
    } @catch (NSException *exception) {
        NSLog(@"Catched: %@ - %@", exception.name, exception.reason);
    }
    
    if ([returnVal class] == [NSNull class] ||returnVal == nil) {
        return initialValue;
    } else {
        returnVal = [NSString stringWithFormat:@"%@",returnVal];
    }
    return returnVal;
}

@end
