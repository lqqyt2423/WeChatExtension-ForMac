//
//  LQMessage.h
//  WeChatExtension
//
//  Created by gymbo on 2020/6/17.
//  Copyright © 2020 MustangYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeChatPlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface LQMessage : NSObject

-(void)handle:(AddMsg *)msg;

@end

NS_ASSUME_NONNULL_END
