//
//  LoginClient.h
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import <Foundation/Foundation.h>

@interface LoginClient : NSObject

@property (nonatomic, strong) NSURLSession * session;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^_Nonnull)(NSDictionary * _Nullable, NSError * _Nullable))completion;
@end
