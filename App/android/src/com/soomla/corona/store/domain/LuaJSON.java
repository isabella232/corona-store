package com.soomla.corona.store.domain;

import com.soomla.store.domain.*;
import com.soomla.store.data.StoreJSONConsts;
import com.soomla.store.domain.MarketItem;
import com.soomla.store.domain.NonConsumableItem;
import com.soomla.store.domain.PurchasableVirtualItem;
import com.soomla.store.domain.VirtualCategory;
import com.soomla.store.domain.virtualCurrencies.VirtualCurrency;
import com.soomla.store.domain.virtualCurrencies.VirtualCurrencyPack;
import com.soomla.store.domain.virtualGoods.EquippableVG;
import com.soomla.store.domain.virtualGoods.LifetimeVG;
import com.soomla.store.domain.virtualGoods.SingleUsePackVG;
import com.soomla.store.domain.virtualGoods.SingleUseVG;
import com.soomla.store.domain.virtualGoods.UpgradeVG;
import com.soomla.store.purchaseTypes.PurchaseType;
import com.soomla.store.purchaseTypes.PurchaseWithMarket;
import com.soomla.store.purchaseTypes.PurchaseWithVirtualItem;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.Integer;
import java.lang.Object;
import java.lang.Exception;
import java.lang.String;
import java.util.Map;
import java.util.HashMap;

public class LuaJSON {

    // Virtual Item
    public static final String I_ID = "itemId";
    public static final String I_NAME = "name";
    public static final String I_DESCRIPTION = "description";
    public static final String I_CLASS = "class";

    protected static void printError(String id, String message) {
        System.out.println("SOOMLA " + id + message);
    }

    public static JSONObject virtualItemJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        String name = (map.containsKey(LuaJSON.I_NAME)) ? (String)map.get(LuaJSON.I_NAME) : "";
        String description = (map.containsKey(LuaJSON.I_DESCRIPTION)) ? (String)map.get(LuaJSON.I_DESCRIPTION) : "";
        try {
            String itemId = (String)map.get(LuaJSON.I_ID);
            json.put(StoreJSONConsts.ITEM_ITEMID,itemId);
            json.put(StoreJSONConsts.ITEM_NAME,name);
            json.put(StoreJSONConsts.ITEM_DESCRIPTION,description);
        } catch (Exception e) { LuaJSON.printError("vi lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> virtualItemMap(VirtualItem virtualItem) {
        Class<?> enclosingClass = virtualItem.getClass().getEnclosingClass();
        String className = "";
        if(enclosingClass != null) className = enclosingClass.getName();
        else className = virtualItem.getClass().getName();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put(LuaJSON.I_CLASS,className);
        map.put(LuaJSON.I_ID,virtualItem.getItemId());
        map.put(LuaJSON.I_NAME,virtualItem.getName());
        map.put(LuaJSON.I_DESCRIPTION,virtualItem.getDescription());
        return map;
    }



    // Purchasable Virtual Item
    public static final String I_PURCHASE = "purchase";
    public static final String I_PURCHASETYPE = "purchaseType";
    public static final String I_PURCHASEMARKET = "market";
    public static final String I_PURCHASEVIRTUALITEM = "virtualItem";

    public static JSONObject purchasableItemJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.virtualItemJSON(map);
        try {
            Map<String,Object> purchaseMap = (Map<String,Object>)map.get(LuaJSON.I_PURCHASE);
            String purchaseType = (String)purchaseMap.get(LuaJSON.I_PURCHASETYPE);
            boolean isMarket = purchaseType.equals(LuaJSON.I_PURCHASEMARKET);
            JSONObject purchaseTypeJSON = (isMarket) ? LuaJSON.purchaseMarketJSON(purchaseMap) : LuaJSON.purchaseVirtualItemJSON(purchaseMap);
            json.put(StoreJSONConsts.PURCHASABLE_ITEM, purchaseTypeJSON);
        } catch(Exception e) { LuaJSON.printError("purchase lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> purchasableItemMap(PurchasableVirtualItem purchasableItem) {
        HashMap<String,Object> map = (HashMap<String,Object>)LuaJSON.virtualItemMap(purchasableItem);
        PurchaseType purchaseType = purchasableItem.getPurchaseType();
        map.put(LuaJSON.I_PURCHASE,LuaJSON.purchaseTypeMap(purchaseType));
        return map;
    }

    public static Map<String,Object> purchaseTypeMap(PurchaseType purchaseType) {
        if(purchaseType instanceof PurchaseWithMarket) return LuaJSON.purchaseMarketMap((PurchaseWithMarket)purchaseType);
        else return LuaJSON.purchaseVirtualItemMap((PurchaseWithVirtualItem)purchaseType);
    }

    public static final String PRODUCT  = "product";

    public static JSONObject purchaseMarketJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        Map<String,Object> marketMap = (Map<String,Object>)map.get(LuaJSON.PRODUCT);
        JSONObject marketJSON = LuaJSON.marketItemJSON(marketMap);
        try {
            json.put(StoreJSONConsts.PURCHASE_TYPE,StoreJSONConsts.PURCHASE_TYPE_MARKET);
            json.put(StoreJSONConsts.PURCHASE_MARKET_ITEM, marketJSON);
        } catch(JSONException e) { LuaJSON.printError("purchaseMarket lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> purchaseMarketMap(PurchaseWithMarket purchaseMarket) {
        HashMap<String,Object> map = new HashMap<String, Object>();
        map.put(LuaJSON.I_PURCHASETYPE,LuaJSON.I_PURCHASEMARKET);
        MarketItem marketItem = purchaseMarket.getMarketItem();
        map.put(LuaJSON.PRODUCT,LuaJSON.marketItemMap(marketItem));
        return map;
    }

    public static final String I_MARKETITEM_ID = "id";
    public static final String I_MARKETITEM_PRICE = "price";
    public static final String I_MARKETITEM_MANAGEMENT = "management";
    public static final String I_MANAGEMENT_MANAGED = "managed";
    public static final String I_MANAGEMENT_UNMANAGED = "unmanaged";
    public static final String I_MANAGEMENT_SUBSCRIPTION = "subscription";

    public static JSONObject marketItemJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        try {
            String marketId = (String)map.get(LuaJSON.I_MARKETITEM_ID);
            Double price = (Double)map.get(LuaJSON.I_MARKETITEM_PRICE);
            String management = (String)map.get(LuaJSON.I_MARKETITEM_MANAGEMENT);
            json.put(StoreJSONConsts.MARKETITEM_ANDROID_ID,marketId);
            json.put(StoreJSONConsts.MARKETITEM_PRICE,price);
            json.put(StoreJSONConsts.MARKETITEM_MANAGED,LuaJSON.getManagementInt(management));
        } catch(Exception e) { LuaJSON.printError("marketItem lua->json",e.getMessage()); }
        return json;
    }

    public static int getManagementInt(String management) {
        if(management == LuaJSON.I_MANAGEMENT_MANAGED) return 0;
        if(management == LuaJSON.I_MANAGEMENT_UNMANAGED) return 1;
        if(management == LuaJSON.I_MANAGEMENT_SUBSCRIPTION) return 2;
        return 0;
    }

    public static Map<String,Object> marketItemMap(MarketItem marketItem) {
        HashMap<String,Object> map = new HashMap<String, Object>();
        map.put(LuaJSON.I_MARKETITEM_ID,marketItem.getProductId());
        map.put(LuaJSON.I_MARKETITEM_PRICE,new Double(marketItem.getPrice()));
        String management = "";
        switch(marketItem.getManaged()) {
            case MANAGED: management = LuaJSON.I_MANAGEMENT_MANAGED; break;
            case UNMANAGED: management = LuaJSON.I_MANAGEMENT_UNMANAGED; break;
            case SUBSCRIPTION: management = LuaJSON.I_MANAGEMENT_SUBSCRIPTION; break;
        }
        map.put(LuaJSON.I_MARKETITEM_MANAGEMENT,management);
        return map;
    }

    public static final String I_EXCHANGE_CURRENCY = "exchangeCurrency";
    public static final String I_EXCHANGE_AMOUNT = "amount";

    public static JSONObject purchaseVirtualItemJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        Map<String,Object> exchangeMap = (Map<String,Object>)map.get(LuaJSON.I_EXCHANGE_CURRENCY);
        try {
            String targetId = (String)exchangeMap.get(LuaJSON.I_ID);
            Double amount = (Double)exchangeMap.get(LuaJSON.I_EXCHANGE_AMOUNT);
            json.put(StoreJSONConsts.PURCHASE_TYPE,StoreJSONConsts.PURCHASE_TYPE_VI);
            json.put(StoreJSONConsts.PURCHASE_VI_ITEMID,targetId);
            json.put(StoreJSONConsts.PURCHASE_VI_AMOUNT,amount.intValue());
        } catch (Exception e) { LuaJSON.printError("purchaseVI lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> purchaseVirtualItemMap(PurchaseWithVirtualItem purchaseVirtualItem) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put(LuaJSON.I_PURCHASETYPE,LuaJSON.I_PURCHASEVIRTUALITEM);
        HashMap<String,Object> exchangeCurrencyMap = new HashMap<String,Object>();
        exchangeCurrencyMap.put(LuaJSON.I_ID,purchaseVirtualItem.getTargetItemId());
        exchangeCurrencyMap.put(LuaJSON.I_EXCHANGE_AMOUNT,new Double(purchaseVirtualItem.getAmount()));
        map.put(LuaJSON.I_EXCHANGE_CURRENCY,exchangeCurrencyMap);
        return map;
    }

    // Virtual Category

    public static final String VC_NAME = "name";
    public static final String VC_ITEMS = "items";

    public static JSONObject categoryJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        try {
            String name = (String)map.get(LuaJSON.I_NAME);
            Map<String,Object> items = (Map<String,Object>)map.get(LuaJSON.VC_ITEMS);
            json.put(StoreJSONConsts.CATEGORY_NAME,name);
            JSONArray jsonArray = new JSONArray();
            for(Object obj : map.values()) jsonArray.put(obj);
            json.put(StoreJSONConsts.CATEGORY_GOODSITEMIDS,jsonArray);
        } catch(Exception e) { LuaJSON.printError("category lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> categoryMap(VirtualCategory category) {
        Class<?> enclosingClass = category.getClass().getEnclosingClass();
        String className = "";
        if(enclosingClass != null) className = enclosingClass.getName();
        else className = category.getClass().getName();
        HashMap<String,Object> categoryMap = new HashMap<String,Object>();
        categoryMap.put(LuaJSON.I_CLASS,className);
        categoryMap.put(LuaJSON.VC_NAME,category.getName());
        categoryMap.put(LuaJSON.VC_ITEMS,category.getGoodsItemIds());
        return categoryMap;
    }

    // Virtual Currencies

    public static JSONObject currencyJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.virtualItemJSON(map);
        return json;
    }

    public static Map<String,Object> currencyMap(VirtualCurrency currency) {
        Map<String,Object> currencyMap = LuaJSON.virtualItemMap(currency);
        return currencyMap;
    }

    public static final String I_CURRENCY_ID = "currency";
    public static final String I_CURRENCY_AMOUNT = "amount";

    public static JSONObject currencyPackJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableItemJSON(map);
        String currency = (String)map.get(LuaJSON.I_CURRENCY_ID);
        Double amount = (Double)map.get(LuaJSON.I_CURRENCY_AMOUNT);
        try {
            json.put(StoreJSONConsts.CURRENCYPACK_CURRENCYAMOUNT,amount.intValue());
            json.put(StoreJSONConsts.CURRENCYPACK_CURRENCYITEMID,currency);
        } catch(JSONException e) { LuaJSON.printError("currency lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> currencyPackMap(VirtualCurrencyPack currencyPack) {
        HashMap<String,Object> currencyPackMap = (HashMap<String,Object>)LuaJSON.purchasableItemMap(currencyPack);
        currencyPackMap.put(LuaJSON.I_CURRENCY_ID,currencyPack.getCurrencyItemId());
        currencyPackMap.put(LuaJSON.I_CURRENCY_AMOUNT,new Double(currencyPack.getCurrencyAmount()));
        return currencyPackMap;
    }

    // Single Use

    public static JSONObject singleUseJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableItemJSON(map);
        return json;
    }

    public static Map<String,Object> singleUseMap(SingleUseVG singleUse) {
        Map<String,Object> map = LuaJSON.purchasableItemMap(singleUse);
        return map;
    }

    public static final String I_SINGLEUSEGOOD_ID = "singleUseGood";
    public static final String I_SINGLEUSEGOOD_AMOUNT = "amount";

    public static JSONObject singleUsePackJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableItemJSON(map);
        try {
            String singleUseId = (String)map.get(LuaJSON.I_SINGLEUSEGOOD_ID);
            Double amount = (Double)map.get(LuaJSON.I_SINGLEUSEGOOD_AMOUNT);
            json.put(StoreJSONConsts.VGP_GOOD_ITEMID,singleUseId);
            json.put(StoreJSONConsts.VGP_GOOD_AMOUNT,amount.intValue());
        } catch(Exception e) { LuaJSON.printError("suvg lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> singleUsePackMap(SingleUsePackVG singleUsePack) {
        HashMap<String,Object> map = (HashMap<String,Object>)LuaJSON.purchasableItemMap(singleUsePack);
        map.put(LuaJSON.I_SINGLEUSEGOOD_ID,singleUsePack.getGoodItemId());
        map.put(LuaJSON.I_SINGLEUSEGOOD_AMOUNT,new Double(singleUsePack.getGoodAmount()));
        return map;
    }

    // Lifetime

    public static JSONObject lifetimeJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableItemJSON(map);
        return json;
    }

    public static Map<String,Object> lifetimeMap(LifetimeVG lifetime) {
        Map<String,Object> map = LuaJSON.purchasableItemMap(lifetime);
        return map;
    }

    // Equipment

    public static final String I_EQUIPMENTTYPE = "equipModel";
    public static final String I_EQUIPMENTTYPE_LOCAL = "local";
    public static final String I_EQUIPMENTTYPE_CATEGORY = "category";
    public static final String I_EQUIPMENTTYPE_GLOBAL = "global";


    public static JSONObject equippableJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableItemJSON(map);
        String equipmentType = (String)map.get(LuaJSON.I_EQUIPMENTTYPE);
        EquippableVG.EquippingModel equipModel = EquippableVG.EquippingModel.LOCAL;
        if(equipmentType.equals(LuaJSON.I_EQUIPMENTTYPE_CATEGORY)) equipModel = EquippableVG.EquippingModel.CATEGORY;
        else if (equipmentType.equals(LuaJSON.I_EQUIPMENTTYPE_GLOBAL)) equipModel = EquippableVG.EquippingModel.GLOBAL;
        try {
            json.put(StoreJSONConsts.EQUIPPABLE_EQUIPPING, equipModel.toString());
        } catch(JSONException e) { LuaJSON.printError("evg lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> equippableMap(EquippableVG equippable) {
        HashMap<String,Object> map = (HashMap<String,Object>)LuaJSON.purchasableItemMap(equippable);
        String equipmentType = LuaJSON.I_EQUIPMENTTYPE_LOCAL;
        switch(equippable.getEquippingModel()) {
            case CATEGORY: equipmentType = LuaJSON.I_EQUIPMENTTYPE_CATEGORY; break;
            case GLOBAL: equipmentType = LuaJSON.I_EQUIPMENTTYPE_GLOBAL; break;
            default: equipmentType = LuaJSON.I_EQUIPMENTTYPE_LOCAL; break;
        }
        map.put(LuaJSON.I_EQUIPMENTTYPE,equipmentType);
        return map;
    }

    // Upgrade

    public static final String I_UPGRADE_LINKEDGOOD = "linkedGood";
    public static final String I_UPGRADE_PREVIOUS = "previousUpgrade";
    public static final String I_UPGRADE_NEXT = "nextUpgrade";

    public static JSONObject upgradeJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableItemJSON(map);
        try {
            String linkedGood = (String)map.get(LuaJSON.I_UPGRADE_LINKEDGOOD);
            String nextUpgrade = (map.containsKey(LuaJSON.I_UPGRADE_NEXT)) ? (String)map.get(LuaJSON.I_UPGRADE_NEXT) : "";
            String previousUpgrade = (map.containsKey(LuaJSON.I_UPGRADE_PREVIOUS)) ? (String)map.get(LuaJSON.I_UPGRADE_PREVIOUS) : "";
            json.put(StoreJSONConsts.VGU_GOOD_ITEMID,linkedGood);
            json.put(StoreJSONConsts.VGU_NEXT_ITEMID,nextUpgrade);
            json.put(StoreJSONConsts.VGU_PREV_ITEMID,previousUpgrade);
        } catch(Exception e) { LuaJSON.printError("upgrade lua->json",e.getMessage()); }
        return json;
    }

    public static Map<String,Object> upgradeMap(UpgradeVG upgrade) {
        HashMap<String,Object> map = (HashMap<String,Object>)LuaJSON.purchasableItemMap(upgrade);
        map.put(LuaJSON.I_UPGRADE_LINKEDGOOD,upgrade.getGoodItemId());
        map.put(LuaJSON.I_UPGRADE_NEXT,upgrade.getNextItemId());
        map.put(LuaJSON.I_UPGRADE_PREVIOUS,upgrade.getPrevItemId());
        return map;
    }

    // Non Consumable Item

    public static JSONObject nonConsumableItemJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableItemJSON(map);
        return json;
    }

    public static Map<String,Object> nonConsumableItemMap(NonConsumableItem nonConsumableItem) {
        Map<String,Object> map = LuaJSON.purchasableItemMap(nonConsumableItem);
        return map;
    }


}