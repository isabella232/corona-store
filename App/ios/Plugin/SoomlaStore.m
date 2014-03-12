//
//  SoomlaStore.m
//  Soomla for Corona
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.

#import "SoomlaStore.h"
#import "VirtualItem.h"
#import "VirtualCurrency.h"
#import "VirtualCurrencyPack.h"
#import "VirtualCategory.h"
#import "VirtualGood.h"
#import "NonConsumableItem.h"

@interface SoomlaStore ()

@property (nonatomic,strong) NSMutableDictionary * virtualItems;
@property (nonatomic,strong) NSMutableDictionary * virtualCategories;

@end

@implementation SoomlaStore

#pragma mark - Initialization

+ (SoomlaStore *) sharedInstance {
    static SoomlaStore * instance = nil;
    if(instance == nil) instance = [[SoomlaStore alloc] init];
    return instance;
}

- (id) init {
    self = [super init];
    if(self == nil) return nil;
    self.virtualItems = [[NSMutableDictionary alloc] init];
    self.avaiableCategories = [[NSArray alloc] init];
    self.avaiableCurrencies = [[NSArray alloc] init];
    self.avaiableCurrencyPacks = [[NSArray alloc] init];
    self.avaiableNonConsumableItems = [[NSArray alloc] init];
    self.avaiableVirtualGoods = [[NSArray alloc] init];
    return self;
}

//TODO: Return the correct array for each method

#pragma mark - Version

- (int) getVersion {
    return self.version;
}

- (void) addVirtualItem:(VirtualItem *) virtualItem {
    [self.virtualItems setObject:virtualItem forKey:virtualItem.itemId];
}

- (VirtualItem *) virtualItemWithId:(NSString *) itemId {
    return [self.virtualItems objectForKey:itemId];
}

#pragma mark - Currency

- (NSArray *) virtualCurrencies {
    NSMutableArray * currencies = [[NSMutableArray alloc] init];
    for(NSString * currencyId in self.avaiableCurrencies) {
        VirtualCurrency * currency = (VirtualCurrency *)[self.virtualItems objectForKey:currencyId];
        if(currency == nil) NSLog(@"SOOMLA: %@ is not a Virtual Currency!! It will not be used!",currencyId);
        else [currencies addObject:currency];
    }
    return [NSArray arrayWithArray:currencies];
}

- (NSArray *) virtualCurrencyPacks {
    NSMutableArray * currencyPacks = [[NSMutableArray alloc] init];
    for(NSString * currencyPackId in self.avaiableCurrencyPacks) {
        VirtualCurrencyPack * currencyPack = (VirtualCurrencyPack *)[self.virtualItems objectForKey:currencyPackId];
        if(currencyPack == nil) NSLog(@"SOOMLA: %@ is not a Virtual Currency Pack!! It will not be used!",currencyPackId);
        else [currencyPacks addObject:currencyPack];
    }
    return [NSArray arrayWithArray:currencyPacks];
}

#pragma mark - Categories

- (void) addVirtualCategory:(VirtualCategory *) category {
    [self.virtualCategories setObject:category forKey:category.name];
}

- (VirtualCategory *) categoryWithName:(NSString *) name {
    return [self.virtualCategories objectForKey:name];
}

- (NSArray *) virtualCategories {
    NSMutableArray * categories = [[NSMutableArray alloc] init];
    for(NSString * categoryName in self.avaiableCategories) {
        VirtualCategory * category = (VirtualCategory *)[self.virtualCategories objectForKey:categoryName];
        if(category == nil) NSLog(@"SOOMLA: Category %@ doesn't exist!",categoryName);
        else [categories addObject:category];
    }
    return [NSArray arrayWithArray:categories];
}


#pragma mark - Virtual Goods

- (NSArray *) virtualGoods {
    NSMutableArray * virtualGoods = [[NSMutableArray alloc] init];
    for(NSString * virtualGoodId in self.avaiableVirtualGoods) {
        VirtualGood * virtualGood = (VirtualGood *)[self.virtualItems objectForKey:virtualGoodId];
        if(virtualGood == nil) NSLog(@"SOOMLA: %@ is not a Virtual Currency Pack!! It will not be used!",virtualGoodId);
        else [virtualGoods addObject:virtualGood];
    }
    return [NSArray arrayWithArray:virtualGoods];
}

#pragma mark - Non Consumable Items

- (NSArray *) nonConsumableItems {
    NSMutableArray * nonConsumableItems = [[NSMutableArray alloc] init];
    for(NSString * nonConsumableItemId in self.avaiableNonConsumableItems) {
        NonConsumableItem * nonConsumableItem = (NonConsumableItem *)[self.virtualItems objectForKey:nonConsumableItemId];
        if(nonConsumableItem == nil) NSLog(@"SOOMLA: %@ is not a Virtual Currency Pack!! It will not be used!",nonConsumableItemId);
        else [nonConsumableItems addObject:nonConsumableItem];
    }
    return [NSArray arrayWithArray:nonConsumableItems];
}

@end
