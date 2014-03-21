//
//  EventManager.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/21/14.
//
//

#import "EventManager.h"
#import "EventHandling.h"
#import "CoronaListenerRef.h"
#import "NSDictionary+Lua.h"

@implementation EventManager

+ (EventManager *) sharedInstance {
    static EventManager * _instance = NULL;
    if(_instance == NULL) _instance = [[EventManager alloc] init];
    return _instance;
}

- (id) init {
    
    self = [super init];
    if(self == nil) return nil;
    
    self.events = @{
        EVENT_BILLING_SUPPORTED : [[NSMutableArray alloc] init],
        EVENT_BILLING_NOT_SUPPORTED : [[NSMutableArray alloc] init],
        EVENT_APPSTORE_PURCHASE_CANCELLED : [[NSMutableArray alloc] init],
        EVENT_APPSTORE_PURCHASE_STARTED : [[NSMutableArray alloc] init],
        EVENT_APPSTORE_PURCHASE_VERIF : [[NSMutableArray alloc] init],
        EVENT_APPSTORE_PURCHASED : [[NSMutableArray alloc] init],
        EVENT_CURRENCY_BALANCE_CHANGED : [[NSMutableArray alloc] init],
        EVENT_GOOD_BALANCE_CHANGED : [[NSMutableArray alloc] init],
        EVENT_GOOD_EQUIPPED : [[NSMutableArray alloc] init],
        EVENT_GOOD_UNEQUIPPED : [[NSMutableArray alloc] init],
        EVENT_GOOD_UPGRADE : [[NSMutableArray alloc] init],
        EVENT_ITEM_PURCHASE_STARTED : [[NSMutableArray alloc] init],
        EVENT_ITEM_PURCHASED : [[NSMutableArray alloc] init],
        EVENT_STORECONTROLLER_INIT : [[NSMutableArray alloc] init],
        EVENT_TRANSACTION_RESTORE_STARTED : [[NSMutableArray alloc] init],
        EVENT_TRANSACTION_RESTORED : [[NSMutableArray alloc] init],
        EVENT_UNEXPECTED_ERROR_IN_STORE : [[NSMutableArray alloc] init]
    };
    
    return self;
}

- (void) addListener:(CoronaLuaRef)listener toEvent:(NSString *)eventName {
    CoronaListenerRef * coronaListener = [[CoronaListenerRef alloc] init];
    coronaListener.listener = listener;
    NSMutableArray * listeners = [self.events objectForKey:eventName];
    if(listeners == nil) NSLog(@"SOOMLA: Event %@ doesn't exist",eventName);
    else [listeners addObject:coronaListener];
}

- (void) removeListener:(CoronaLuaRef)listener fromEvent:(NSString *)eventName {
    NSMutableArray * listeners = [self.events objectForKey:eventName];
    if(listeners == nil) {
        NSLog(@"SOOMLA: Event %@ doesn't exist",eventName);
        return;
    }
    CoronaListenerRef * coronaListener = [[CoronaListenerRef alloc] init];
    coronaListener.listener = listener;
    [listeners removeObjectIdenticalTo:coronaListener];
}

- (void) throwEvent:(NSDictionary *) eventData {
    lua_State * L = CoronaLuaNew(255);
    [eventData toLuaTable:L];
    
    NSString * eventName = [eventData objectForKey:@"name"];
    NSMutableArray * listeners = [self.events objectForKey:eventName];
    if(listeners == nil) {
        NSLog(@"SOOMLA: Event %@ doesn't exist",eventName);
        return;
    }
    
    for(CoronaListenerRef * coronaListener in listeners)
        CoronaLuaDispatchEvent(L,coronaListener.listener,0);
}

- (void) deleteAllReferences:(lua_State *) L {
    NSArray * listenersList = [self.events allValues];
    for(NSMutableArray * listeners in listenersList) {
        for(CoronaListenerRef * coronaListener in listeners)
            [coronaListener deleteReference:L];
    }
}


@end
