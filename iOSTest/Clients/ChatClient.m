//
//  ChatClient.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "ChatClient.h"

@interface ChatClient ()

@end

@implementation ChatClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 **/

- (void)fetchChatData:(void (^)(NSArray<Message *> * _Nullable, NSError * _Nullable))completion {
    
    NSURL *URL = [NSURL URLWithString:@"http://dev.rapptrlabs.com/Tests/scripts/chat_log.php"];
    _session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [_session dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"dataTaskWithRequest error: %@", error);
            completion(nil,error);
            return;
        }
        
        NSError *parseJsonError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseJsonError];
        NSMutableArray *messages = [NSMutableArray array];
        for (NSDictionary *messageDict in dict[@"data"]) {
            Message *message = [[Message alloc] initWithDictionary:messageDict];
            [messages addObject:message];
        }
        completion(messages,parseJsonError);
    }];
    [task resume];
    
}

@end
