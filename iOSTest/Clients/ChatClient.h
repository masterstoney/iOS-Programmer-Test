//
//  ChatClient.h
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import <Foundation/Foundation.h>
#import "Message.h"

@interface ChatClient : NSObject

@property (nonatomic, strong) NSURLSession *session;

- (void)fetchChatData:(void (^_Nonnull)(NSArray<Message *> *_Nullable, NSError * _Nullable))completion;
@end
