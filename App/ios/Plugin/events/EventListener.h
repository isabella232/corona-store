//
//  EventListener.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/18/14.
//
//

#import <Foundation/Foundation.h>

@interface EventListener : NSObject

+ (EventListener *) sharedInstance;
- (void) startListeningSoomlaEvents;
- (void) stopListeningSoomlaEvents;

@end
