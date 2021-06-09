//
//  LoginClient.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "LoginClient.h"

//@interface LoginClient ()
//@property (nonatomic, strong) NSURLSession *session;
//@end

@implementation LoginClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 **/

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {
    
    NSString *params = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    NSData *paramsData = [params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    NSURL *URL = [NSURL URLWithString:@"http://dev.rapptrlabs.com/Tests/scripts/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:paramsData];

    _session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            NSLog(@"dataTaskWithRequest error: %@", error);
            completion(nil,error);
            return;
        }
        NSError *parseJsonError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseJsonError];
        completion(dict,parseJsonError);

    }];
    [task resume];
    
}

@end
