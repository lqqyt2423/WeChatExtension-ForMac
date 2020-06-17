//
//  LQMessage.m
//  WeChatExtension
//
//  Created by gymbo on 2020/6/17.
//  Copyright © 2020 MustangYM. All rights reserved.
//

#import "LQMessage.h"

@implementation LQMessage

-(void)logMsg:(AddMsg *)msg
{
    NSMutableString *text = [[NSMutableString alloc] init];
    [text appendString:@"LQMessage msg start ==========\n"];
    [text appendFormat:@"LQMessage msg: %@\n", msg];
    [text appendFormat:@"LQMessage msg pushContent: %@\n", msg.pushContent];
    [text appendFormat:@"LQMessage msg msgSource: %@\n", msg.msgSource];
    [text appendFormat:@"LQMessage msg msgType: %d\n", msg.msgType];
    [text appendFormat:@"LQMessage msg createTime: %d\n", msg.createTime];
    [text appendFormat:@"LQMessage msg newMsgId: %lld\n", msg.newMsgId];
    [text appendFormat:@"LQMessage msg fromUserName: %@\n", msg.fromUserName.string];
    [text appendFormat:@"LQMessage msg toUserName: %@\n", msg.toUserName.string];
    [text appendFormat:@"LQMessage msg content: %@\n", msg.content.string];
    [text appendString:@"LQMessage msg end   ==========\n\n\n"];
    
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:@"/Users/gymbo/Desktop/lqmessage.txt"];
    [file seekToEndOfFile];
    [file writeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
    
    // [text writeToFile:@"/Users/gymbo/Desktop/lqmessage.txt" atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    NSLog(@"lqmessage append to lqmessage.txt");
}

-(void)saveMsg:(AddMsg *)msg
{
    if (msg.msgType != 49) return;
    
    // NSString *endpoint = @"http://localhost:8104/api/receiver/pc_bot/f6wmvzjiffa";
    NSString *endpoint = @"http://212.64.41.166/wx_spider_admin/api/receiver/pc_bot/f6wmvzjiffa";
    
    NSString *content = msg.content.string;
    NSString *contentLen = [NSString stringWithFormat:@"%ld", [content length]];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:endpoint]];
    [request setHTTPMethod:@"POST"];
    [request setValue:contentLen forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        NSLog(@"lqmessage finish http");
    }];
    
    NSLog(@"lqmessage savemsg end");
}


-(void)handle:(AddMsg *)msg
{
    // [self logMsg:msg];
    [self saveMsg:msg];
    // NSLog(@"lqmessage handle end");
}

@end
