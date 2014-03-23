//
//  EventListener.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/18/14.
//
//

#import "EventListener.h"
#import "EventHandling.h"
#import "CoronaLua.h"
#import "PurchasableVirtualItem+Lua.h"
#import "SKPaymentTransaction+Lua.h"
#import "VirtualItem+Lua.h"
#import "UpgradeVG+Lua.h"
#import "EquippableVG+Lua.h"

#include "PluginSoomla.h"

@implementation EventListener

#pragma mark - Initialization

+ (EventListener *) sharedInstance {
    static EventListener * instance = nil;
    if(instance == nil) instance = [[EventListener alloc] init];
    return instance;
}

#pragma mark - Soomla Events

- (void) startListeningSoomlaEvents {
    [self listenEvent:EVENT_BILLING_SUPPORTED selector:@selector(handleBillingSupported:)];
    [self listenEvent:EVENT_BILLING_NOT_SUPPORTED selector:@selector(handleBillingNotSupported:)];
    [self listenEvent:EVENT_CURRENCY_BALANCE_CHANGED selector:@selector(handleCurrencyBalanceChanged:)];
    [self listenEvent:EVENT_GOOD_BALANCE_CHANGED selector:@selector(handleVirtualGoodBalanceChanged:)];
    [self listenEvent:EVENT_GOOD_EQUIPPED selector:@selector(handleVirtualGoodEquipped:)];
    [self listenEvent:EVENT_GOOD_UNEQUIPPED selector:@selector(handleVirtualGoodUnequipped:)];
    [self listenEvent:EVENT_GOOD_UPGRADE selector:@selector(handleVirtualGoodUpgrade:)];
    [self listenEvent:EVENT_ITEM_PURCHASED selector:@selector(handleItemPurchased:)];
    [self listenEvent:EVENT_ITEM_PURCHASE_STARTED selector:@selector(handleItemPurchaseStarted:)];
    [self listenEvent:EVENT_APPSTORE_PURCHASE_CANCELLED selector:@selector(handleAppStorePurchaseCancelled:)];
    [self listenEvent:EVENT_APPSTORE_PURCHASE_STARTED selector:@selector(handleAppStorePurchaseStarted:)];
    [self listenEvent:EVENT_APPSTORE_PURCHASE_VERIF selector:@selector(handleAppStorePurchaseVerif:)];
    [self listenEvent:EVENT_APPSTORE_PURCHASED selector:@selector(handleAppStorePurchased:)];
    [self listenEvent:EVENT_TRANSACTION_RESTORED selector:@selector(handleTransactionRestored:)];
    [self listenEvent:EVENT_TRANSACTION_RESTORE_STARTED selector:@selector(handleTransactionRestoreStarted:)];
    [self listenEvent:EVENT_UNEXPECTED_ERROR_IN_STORE selector:@selector(handleUnexpectedErrorInStore:)];
    [self listenEvent:EVENT_STORECONTROLLER_INIT selector:@selector(handleStoreControllerInit:)];
}

- (void) listenEvent:(NSString *) eventName selector:(SEL) listener {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:listener name:eventName object:nil];
}

- (void) stopListeningSoomlaEvents {
    [self stopListeningEvent:EVENT_BILLING_SUPPORTED];
    [self stopListeningEvent:EVENT_BILLING_NOT_SUPPORTED];
    [self stopListeningEvent:EVENT_APPSTORE_PURCHASE_CANCELLED];
    [self stopListeningEvent:EVENT_APPSTORE_PURCHASE_STARTED];
    [self stopListeningEvent:EVENT_APPSTORE_PURCHASE_VERIF];
    [self stopListeningEvent:EVENT_APPSTORE_PURCHASED];
    [self stopListeningEvent:EVENT_CURRENCY_BALANCE_CHANGED];
    [self stopListeningEvent:EVENT_GOOD_BALANCE_CHANGED];
    [self stopListeningEvent:EVENT_GOOD_EQUIPPED];
    [self stopListeningEvent:EVENT_GOOD_UNEQUIPPED];
    [self stopListeningEvent:EVENT_GOOD_UPGRADE];
    [self stopListeningEvent:EVENT_ITEM_PURCHASE_STARTED];
    [self stopListeningEvent:EVENT_ITEM_PURCHASED];
    [self stopListeningEvent:EVENT_STORECONTROLLER_INIT];
    [self stopListeningEvent:EVENT_TRANSACTION_RESTORE_STARTED];
    [self stopListeningEvent:EVENT_TRANSACTION_RESTORED];
    [self stopListeningEvent:EVENT_UNEXPECTED_ERROR_IN_STORE];
}

- (void) stopListeningEvent:(NSString *) eventName {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:eventName object:nil];
}

#pragma mark - Billing Events

- (void) handleBillingSupported:(NSNotification *) notification {
    soomla_throwEvent(@{ @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_BILLING_SUPPORTED] });
}

- (void) handleBillingNotSupported:(NSNotification *) notification {
        soomla_throwEvent(@{ @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_BILLING_NOT_SUPPORTED] });
}

#pragma mark - Currency Events

- (void) handleCurrencyBalanceChanged:(NSNotification *) notification {
    NSNumber * balance = [notification.userInfo objectForKey:DICT_ELEMENT_BALANCE];
    VirtualCurrency * currency = [notification.userInfo objectForKey:DICT_ELEMENT_CURRENCY];
    NSNumber * amountAdded = [notification.userInfo objectForKey:DICT_ELEMENT_AMOUNT_ADDED];
    soomla_throwEvent(@{
         @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_CURRENCY_BALANCE_CHANGED],
         @"balance" : balance,
         @"amountAdded" : amountAdded,
         @"virtualCurrency" : [currency toLuaDictionary]
    });
}

#pragma mark - Virtual Goods Events

- (void) handleVirtualGoodBalanceChanged:(NSNotification *) notification {
    NSNumber * balance = [notification.userInfo objectForKey:DICT_ELEMENT_BALANCE];
    NSNumber * amountAdded = [notification.userInfo objectForKey:DICT_ELEMENT_AMOUNT_ADDED];
    VirtualGood * virtualGood = [notification.userInfo objectForKey:DICT_ELEMENT_GOOD];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_GOOD_BALANCE_CHANGED],
        @"balance" : balance,
        @"amountAdded" : amountAdded,
        @"virtualGood" : [virtualGood toLuaDictionary]
    });
}

- (void) handleVirtualGoodEquipped:(NSNotification *) notification {
    EquippableVG * equippableVG = [notification.userInfo objectForKey:DICT_ELEMENT_EquippableVG];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_GOOD_UNEQUIPPED],
        @"equippableVG" : [equippableVG toLuaDictionary]
    });
}

- (void) handleVirtualGoodUnequipped:(NSNotification *) notification {
    EquippableVG * equippableVG = [notification.userInfo objectForKey:DICT_ELEMENT_EquippableVG];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_GOOD_EQUIPPED],
        @"equippableVG" : [equippableVG toLuaDictionary]
    });
}

- (void) handleVirtualGoodUpgrade:(NSNotification *) notification {
    VirtualGood * virtualGood = [notification.userInfo objectForKey:DICT_ELEMENT_GOOD];
    UpgradeVG * upgradeVG = [notification.userInfo objectForKey:DICT_ELEMENT_UpgradeVG];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_GOOD_UPGRADE],
        @"virtualGood" : [virtualGood toLuaDictionary],
        @"upgradeVG" : [upgradeVG toLuaDictionary]
    });
}

#pragma mark - Purchase Events

- (void) handleItemPurchased:(NSNotification *) notification {
    PurchasableVirtualItem * purchasableItem = [notification.userInfo objectForKey:DICT_ELEMENT_PURCHASABLE];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_ITEM_PURCHASED],
        @"purchasableItem" : [purchasableItem toLuaDictionary]
    });
}

- (void) handleItemPurchaseStarted:(NSNotification *) notification {
    PurchasableVirtualItem * purchasableItem = [notification.userInfo objectForKey:DICT_ELEMENT_PURCHASABLE];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_ITEM_PURCHASE_STARTED],
        @"purchasableItem" : [purchasableItem toLuaDictionary]
    });
}

- (void) handleAppStorePurchaseCancelled:(NSNotification *) notification {
    PurchasableVirtualItem * purchasableItem = [notification.userInfo objectForKey:DICT_ELEMENT_PURCHASABLE];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_APPSTORE_PURCHASE_CANCELLED],
        @"purchasableItem" : [purchasableItem toLuaDictionary]
    });
}

- (void) handleAppStorePurchased:(NSNotification *) notification {
    PurchasableVirtualItem * purchasableItem = [notification.userInfo objectForKey:DICT_ELEMENT_PURCHASABLE];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_APPSTORE_PURCHASED],
        @"purchasableItem" : [purchasableItem toLuaDictionary]
    });
}

- (void) handleAppStorePurchaseVerif:(NSNotification *) notification {
    PurchasableVirtualItem * purchasableItem = [notification.userInfo objectForKey:DICT_ELEMENT_PURCHASABLE];
    NSNumber * verified = [notification.userInfo objectForKey:DICT_ELEMENT_VERIFIED];
    SKPaymentTransaction * transaction = [notification.userInfo objectForKey:DICT_ELEMENT_TRANSACTION];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_APPSTORE_PURCHASE_VERIF],
        @"purchasableItem" : [purchasableItem toLuaDictionary],
        @"verified" : verified,
        @"transaction" : [transaction toLuaDictionary]
    });
}

- (void) handleAppStorePurchaseStarted:(NSNotification *) notification {
    PurchasableVirtualItem * purchasableItem = [notification.userInfo objectForKey:DICT_ELEMENT_PURCHASABLE];
    soomla_throwEvent(@{
       @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_APPSTORE_PURCHASE_STARTED],
       @"purchasableItem" : [purchasableItem toLuaDictionary]
    });
}

- (void) handleTransactionRestored:(NSNotification *) notification {
    NSNumber * success = [notification.userInfo objectForKey:DICT_ELEMENT_SUCCESS];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_TRANSACTION_RESTORED],
        @"success" : success
    });
}

- (void) handleTransactionRestoreStarted:(NSNotification *) notification {
    soomla_throwEvent(@{ @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_TRANSACTION_RESTORE_STARTED] });
}

- (void) handleUnexpectedErrorInStore:(NSNotification *) notification {
    NSNumber * errorCode = [notification.userInfo objectForKey:DICT_ELEMENT_ERROR_CODE];
    soomla_throwEvent(@{
        @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_UNEXPECTED_ERROR_IN_STORE],
        @"errorCode" : errorCode
    });
}

#pragma mark - Store Controller Events
- (void) handleStoreControllerInit:(NSNotification *) notication {
    soomla_throwEvent(@{ @"name" : [NSString stringWithFormat:@"soomla_%@",EVENT_STORECONTROLLER_INIT] });
}

@end
