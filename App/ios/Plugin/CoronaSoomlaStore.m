//
//  SoomlaStore.m
//  Soomla for Corona
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.

#import "CoronaSoomlaStore.h"
#import "StoreConfig.h"
#import "SoomlaStore.h"
#import "VirtualItem.h"
#import "VirtualCurrency.h"
#import "VirtualCurrencyPack.h"
#import "VirtualCategory.h"
#import "VirtualGood.h"
#import "NonConsumableItem.h"
#import "StoreInfo.h"
#import "Soomla.h"

#define kStore_Version                  @"version"
#define kStore_VirtualGoods             @"virtualGoods"
#define kStore_VirtualCurrencies        @"virtualCurrencies"
#define kStore_VirtualCurrencyPacks     @"virtualCurrencyPacks"
#define kStore_VirtualCategories        @"virtualCategories"
#define kStore_NonConsumableItems       @"nonConsumableItems"
#define kStore_CustomSecret             @"CUSTOM_SECRET"

@interface CoronaSoomlaStore ()

@property (nonatomic,strong) NSMutableDictionary * vItems;
@property (nonatomic,strong) NSMutableDictionary * vCategories;

@end

@implementation CoronaSoomlaStore

#pragma mark - Initialization

+ (SoomlaStore *) sharedInstance {
    static SoomlaStore * instance = nil;
    if(instance == nil) instance = [[SoomlaStore alloc] init];
    return instance;
}

- (id) init {
    self = [super init];
    if(self == nil) return nil;
    self.vItems = [[NSMutableDictionary alloc] init];
    self.vCategories = [[NSMutableDictionary alloc] init];
    self.avaiableCategories = [[NSArray alloc] init];
    self.avaiableCurrencies = [[NSArray alloc] init];
    self.avaiableCurrencyPacks = [[NSArray alloc] init];
    self.avaiableNonConsumableItems = [[NSArray alloc] init];
    self.avaiableVirtualGoods = [[NSArray alloc] init];
    return self;
}

- (void) initializeWithData:(NSDictionary *) luaData {
    NSNumber * version = [luaData objectForKey:kStore_Version];
    self.version = [version intValue];
    
    NSDictionary * categories = [luaData objectForKey:kStore_VirtualCategories];
    self.avaiableCategories = [categories allValues];
    
    NSDictionary * virtualCurrencies = [luaData objectForKey:kStore_VirtualCurrencies];
    self.avaiableCurrencies = [virtualCurrencies allValues];
    
    NSDictionary * virtualCurrencyPacks = [luaData objectForKey:kStore_VirtualCurrencyPacks];
    self.avaiableCurrencyPacks = [virtualCurrencyPacks allValues];
    
    NSDictionary * nonConsumableItems = [luaData objectForKey:kStore_NonConsumableItems];
    self.avaiableNonConsumableItems = [nonConsumableItems allValues];
    
    NSDictionary * virtualGoods = [luaData objectForKey:kStore_VirtualGoods];
    self.avaiableVirtualGoods = [virtualGoods allValues];
    
    NSString * customSecret = [luaData objectForKey:kStore_CustomSecret];
    [Soomla initializeWithSecret:customSecret];
    [[SoomlaStore getInstance] initializeWithStoreAssets:self];
}

//TODO: Return the correct array for each method

#pragma mark - Version

- (int) getVersion {
    return self.version;
}

- (void) addVirtualItem:(VirtualItem *) virtualItem {
    [self.vItems setObject:virtualItem forKey:virtualItem.itemId];
}

#pragma mark - Currency

- (NSArray *) virtualCurrencies {
    NSMutableArray * currencies = [[NSMutableArray alloc] init];
    for(NSString * currencyId in self.avaiableCurrencies) {
        VirtualCurrency * currency = (VirtualCurrency *)[self.vItems objectForKey:currencyId];
        if(currency == nil) NSLog(@"SOOMLA: %@ is not a Virtual Currency!! It will not be used!",currencyId);
        else [currencies addObject:currency];
    }
    return [NSArray arrayWithArray:currencies];
}

- (NSArray *) virtualCurrencyPacks {
    NSMutableArray * currencyPacks = [[NSMutableArray alloc] init];
    for(NSString * currencyPackId in self.avaiableCurrencyPacks) {
        VirtualCurrencyPack * currencyPack = (VirtualCurrencyPack *)[self.vItems objectForKey:currencyPackId];
        if(currencyPack == nil) NSLog(@"SOOMLA: %@ is not a Virtual Currency Pack!! It will not be used!",currencyPackId);
        else [currencyPacks addObject:currencyPack];
    }
    return [NSArray arrayWithArray:currencyPacks];
}

#pragma mark - Categories

- (void) addVirtualCategory:(VirtualCategory *) category {
    [self.vCategories setValue:category forKey:category.name];
}

- (VirtualCategory *) categoryWithName:(NSString *) name {
    return [self.vCategories objectForKey:name];
}

- (NSArray *) virtualCategories {
    NSMutableArray * categories = [[NSMutableArray alloc] init];
    for(NSString * categoryName in self.avaiableCategories) {
        VirtualCategory * category = (VirtualCategory *)[self.vCategories objectForKey:categoryName];
        if(category == nil) NSLog(@"SOOMLA: Category %@ doesn't exist!",categoryName);
        else [categories addObject:category];
    }
    return [NSArray arrayWithArray:categories];
}


#pragma mark - Virtual Goods

- (NSArray *) virtualGoods {
    NSMutableArray * virtualGoods = [[NSMutableArray alloc] init];
    for(NSString * virtualGoodId in self.avaiableVirtualGoods) {
        VirtualGood * virtualGood = (VirtualGood *)[self.vItems objectForKey:virtualGoodId];
        if(virtualGood == nil) NSLog(@"SOOMLA: %@ is not a Virtual Good!! It will not be used!",virtualGoodId);
        else [virtualGoods addObject:virtualGood];
    }
    return [NSArray arrayWithArray:virtualGoods];
}

#pragma mark - Non Consumable Items

- (NSArray *) nonConsumableItems {
    NSMutableArray * nonConsumableItems = [[NSMutableArray alloc] init];
    for(NSString * nonConsumableItemId in self.avaiableNonConsumableItems) {
        NonConsumableItem * nonConsumableItem = (NonConsumableItem *)[self.vItems objectForKey:nonConsumableItemId];
        if(nonConsumableItem == nil) NSLog(@"SOOMLA: %@ is not a Non Consumable Item!! It will not be used!",nonConsumableItemId);
        else [nonConsumableItems addObject:nonConsumableItem];
    }
    return [NSArray arrayWithArray:nonConsumableItems];
}


@end
