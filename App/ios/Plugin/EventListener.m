//
//  EventListener.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/18/14.
//
//

#import "EventListener.h"
#import "EventHandling.h"

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
    
}

- (void) handleBillingNotSupported:(NSNotification *) notification {
    
}

#pragma mark - Currency Events

- (void) handleCurrencyBalanceChanged:(NSNotification *) notification {
    
}

#pragma mark - Virtual Goods Events

- (void) handleVirtualGoodBalanceChanged:(NSNotification *) notification {
    
}

- (void) handleVirtualGoodEquipped:(NSNotification *) notification {
    
}

- (void) handleVirtualGoodUnequipped:(NSNotification *) notification {
    
}

- (void) handleVirtualGoodUpgrade:(NSNotification *) notification {
    
}

#pragma mark - Purchase Events

- (void) handleItemPurchased:(NSNotification *) notification {
    
}

- (void) handleItemPurchaseStarted:(NSNotification *) notification {
    
}

- (void) handleAppStorePurchaseCancelled:(NSNotification *) notification {
    
}

- (void) handleAppStorePurchased:(NSNotification *) notification {
    
}

- (void) handleAppStorePurchaseVerif:(NSNotification *) notification {
    
}

- (void) handleAppStorePurchaseStarted:(NSNotification *) notification {
    
}

- (void) handleTransactionRestored:(NSNotification *) notification {
    
}

- (void) handleTransactionRestoreStarted:(NSNotification *) notification {
    
}

- (void) handleUnexpectedErrorInStore:(NSNotification *) notification {
    
}

#pragma mark - Store Controller Events

- (void) handleStoreControllerInit:(NSNotification *) notication {
    
}

@end
