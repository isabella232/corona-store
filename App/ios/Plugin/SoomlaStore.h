//
//  SoomlaStore.h
//  Soomla for Corona
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.

#import <Foundation/Foundation.h>
#import "IStoreAssets.h"

@class VirtualItem;
@class VirtualCategory;

@interface SoomlaStore : NSObject <IStoreAssets>

@property int version;
@property (nonatomic,strong) NSArray * avaiableCurrencies;
@property (nonatomic,strong) NSArray * avaiableCurrencyPacks;
@property (nonatomic,strong) NSArray * avaiableCategories;
@property (nonatomic,strong) NSArray * avaiableVirtualGoods;
@property (nonatomic,strong) NSArray * avaiableNonConsumableItems;

+ (SoomlaStore *) sharedInstance;
- (void) addVirtualItem:(VirtualItem *) virtualItem;
- (VirtualItem *) virtualItemWithId:(NSString *) itemId;
- (void) addVirtualCategory:(VirtualCategory *) category;
- (VirtualCategory *) categoryWithName:(NSString *) name;

- (void) initializeWithData:(NSDictionary *) luaData;

@end
