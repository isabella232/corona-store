package com.soomla.corona.store.domain;

import com.soomla.store.domain.*;

import com.soomla.corona.Map_Lua;
import com.soomla.store.data.JSONConsts;
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

import org.apache.http.util.LangUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.lang.Integer;
import java.lang.Object;
import java.lang.Exception;
import java.lang.String;
import java.util.Map;
import java.util.HashMap;

public static class LuaJSON {

    // Virtual Item
    public static final String ITEMID       = "itemId";
    public static final String NAME         = "name";
    public static final String DESCRIPTION  = "description";
    public static final String CLASS        = "class";

    public static JSONObject virtualItemJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        try {
            String itemId = (String)map.get(LuaJSON.ITEMID);
            json.put(JSONConsts.ITEM_ITEMID,itemId);
        } catch (Exception e) {}
        String name = (map.containsKey(LuaJSON.NAME)) ? (String)map.get(LuaJSON.NAME) : "";
        String description = (map.containsKey(LuaJSON.DESCRIPTION)) ? (String)map.get(LuaJSON.DESCRIPTION) : "";
        json.put(JSONConsts.ITEM_NAME,name);
        json.put(JSONConsts.ITEM_DESCRIPTION,description);
        return json;
    }

    public static Map<String,Object> virtualItemMap(VirtualItem virtualItem) {
        Class<?> enclosingClass = virtualItem.getClass().getEnclosingClass();
        String className = "";
        if(enclosingClass != null) className = enclosingClass.getName();
        else className = this.getClass().getName();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put(LuaJSON.CLASS,className);
        map.put(LuaJSON.ITEMID,virtualItem.getItemId());
        map.put(LuaJSON.NAME,virtualItem.getName());
        map.put(LuaJSON.DESCRIPTION,virtualItem.getDescription());
        return map;
    }



    // Purchasable Virtual Item
    public static final String PURCHASE             = "purchase";
    public static final String PURCHASETYPE         = "purchaseType";
    public static final String PURCHASEMARKET       = "market";
    public static final String PURCHASEVIRTUALITEM  = "virtualItem";

    public static JSONObject purchasableItemJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.virtualItemJSON(map);
        try {
            Map<String,Object> purchaseMap = (Map<String,Object>)map.get(LuaJSON.PURCHASE);
            String purchaseType = purchaseMap.get(LuaJSON.PURCHASETYPE);
            boolean isMarket = purchaseType.equals(LuaJSON.PURCHASEMARKET);
            JSONObject purchaseTypeJSON = (isMarket) ? LuaJSON.purchaseMarketJSON(purchaseMap) : LuaJSON.purchaseVirtualItemJSON(purchaseMap);
            json.put(JSONConsts.PURCHASABLE_ITEM,purchaseTypeJSON);
        } catch(Exception e) {}
        return json;
    }

    public static Map<String,Object> purchasableItemMap(PurchasableVirtualItem purchasableItem) {
        HashMap<String,Object> map = (HashMap<String,Object>)LuaJSON.virtualItemMap(purchasableItem);
        PurchaseType purchaseType = purchasableItem.getPurchaseType();
        map.put(LuaJSON.PURCHASE,LuaJSON.purchaseTypeMap(purchaseType));
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
        json.put(JSONConsts.PURCHASE_TYPE,JSONConsts.PURCHASE_TYPE_MARKET);
        json.put(JSONConsts.PURCHASE_MARKET_ITEM,marketJSON);
        return json;
    }

    public static Map<String,Object> purchaseMarketMap(PurchaseWithMarket purchaseMarket) {
        HashMap<String,Object> map = new HashMap<String, Object>();
        map.put(LuaJSON.PURCHASETYPE,LuaJSON.PURCHASEMARKET);
        MarketItem marketItem = purchaseMarket.getMarketItem();
        map.put(LuaJSON.PRODUCT,LuaJSON.marketItemMap(marketItem));
        return map;
    }

    public static final String MARKETITEM_ID            = "id";
    public static final String MARKETITEM_PRICE         = "price";
    public static final String MARKETITEM_MANAGEMENT    = "management";
    public static final String MANAGEMENT_MANAGED       = "managed";
    public static final String MANAGEMENT_UNMANAGED     = "unmanaged";
    public static final String MANAGEMENT_SUBSCRIPTION  = "subscription";

    public static JSONObject marketItemJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        try {
            String marketId = (String)map.get(LuaJSON.MARKETITEM_ID);
            Double price = (Double)map.get(LuaJSON.MARKETITEM_PRICE);
            String management = (String)map.get(LuaJSON.MARKETITEM_MANAGEMENT);
            json.put(JSONConsts.MARKETITEM_ANDROID_ID,marketId);
            json.put(JSONConsts.MARKETITEM_PRICE,price);
            json.put(JSONConsts.MARKETITEM_MANAGED,LuaJSON.getManagementInt(management));
        } catch(Exception e) {}
        return json;
    }

    public static int getManagementInt(String management) {
        if(management == LuaJSON.MANAGEMENT_MANAGED) return 0;
        if(management == LuaJSON.MANAGEMENT_UNMANAGED) return 1;
        if(management == LuaJSON.MANAGEMENT_SUBSCRIPTIONA) return 2;
        return 0;
    }

    public static Map<String,Object> marketItemMap(MarketItem marketItem) {
        HashMap<String,Object> map = new HashMap<String, Object>();
        map.put(LuaJSON.MARKETITEM_ID,marketItem.getProductId());
        map.put(LuaJSON.MARKETITEM_PRICE,new Double(marketItem.getPrice()));
        String management = "";
        switch(marketItem.getManaged()) {
            case MANAGED: management = LuaJSON.MANAGEMENT_MANAGED; break;
            case UNMANAGED: management = LuaJSON.MANAGEMENT_UNMANAGED; break;
            case SUBSCRIPTION: management = LuaJSON.MANAGEMENT_SUBSCRIPTION; break;
        }
        map.put(LuaJSON.MARKETITEM_MANAGEMENT,management);
        return map;
    }

    public static final String EXCHANGE_CURRENCY    = "exchangeCurrency";
    public static final String EXCHANGE_AMOUNT      = "amount";

    public static JSONObject purchaseVirtualItemJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        Map<String,Object> exchangeMap = (Map<String,Object>)map.get(LuaJSON.EXCHANGE_CURRENCY);
        try {
            String targetId = (String)exchangeMap.get(LuaJSON.ITEMID);
            Integer amount = (Integer)exchangeMap.get(LuaJSON.EXCHANGE_AMOUNT);
            json.put(JSONConsts.PURCHASE_TYPE,JSONConsts.PURCHASE_TYPE_VI);
            json.put(JSONConsts.PURCHASE_VI_ITEMID,targetId);
            json.put(JSONConsts.PURCHASE_VI_AMOUNT,amount);
        } catch (Exception e) {}
        return json;
    }

    public static Map<String,Object> purchaseVirtualItemMap(PurchaseWithVirtualItem purchaseVirtualItem) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put(LuaJSON.PURCHASETYPE,LuaJSON.PURCHASEVIRTUALITEM);
        HashMap<String,Object> exchangeCurrencyMap = new HashMap<String,Object>();
        exchangeCurrencyMap.put(LuaJSON.ITEMID,purchaseVirtualItem.getTargetItemId());
        exchangeCurrencyMap.put(LuaJSON.EXCHANGE_AMOUNT,new Double(purchaseVirtualItem.getAmount()));
        map.put(LuaJSON.EXCHANGE_CURRENCY,exchangeCurrencyMap);
        return map;
    }

    // Virtual Category

    public static final String NAME     = "name";
    public static final String ITEMS    = "items";

    public static JSONObject categoryJSON(Map<String,Object> map) {
        JSONObject json = new JSONObject();
        try {
            String name = (String)map.get(LuaJSON.NAME);
            Map<String,Object> items = (Map<String,Object>)map.get(LuaJSON.ITEMS);
            json.put(JSONConsts.CATEGORY_NAME,name);
            JSONArray jsonArray = new JSONArray();
            for(Object obj : map.values()) jsonArray.put(obj);
            json.put(JSONConsts.CATEGORY_GOODSITEMIDS,jsonArray);
        } catch(Exception e) {}
        return json;
    }

    public static Map<String,Object> categoryMap(VirtualCategory category) {
        Class<?> enclosingClass = virtualItem.getClass().getEnclosingClass();
        String className = "";
        if(enclosingClass != null) className = enclosingClass.getName();
        else className = this.getClass().getName();
        HashMap<String,Object> categoryMap = new HashMap<String,Object>();
        categoryMap.put(LuaJSON.CLASS,className);
        categoryMap.put(LuaJSON.NAME,category.getName());
        categoryMap.put(LuaJSON.ITEMS,category.getGoodsItemIds());
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

    public static final String CURRENCY_ID      = "currency";
    public static final String CURRENCY_AMOUNT  = "amount";

    public static JSONObject currencyPackJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        String currency = (String)map.get(LuaJSON.CURRENCYID);
        Integer amount = (Integer)map.get(LuaJSON.CURRENCY_AMOUNT)
        json.put(JSONConsts.CURRENCYPACK_CURRENCYAMOUNT,amount);
        json.put(JSONConsts.CURRENCYPACK_CURRENCYITEMID,currency);
        return json;
    }

    public static Map<String,Object> currencyPackMap(VirtualCurrencyPack currencyPack) {
        HashMap<String,Object> currencyPackMap = (HashMap<String,Object>)LuaJSON.purchasableItemMap(currencyPack);
        currencyPackMap.put(LuaJSON.CURRENCY_ID,currencyPack.getCurrencyItemId());
        currencyPackMap.put(LuaJSON.CURRENCY_AMOUNT,new Double(currencyPack.getCurrencyAmount()));
        return currencyPackMap;
    }

    // Single Use

    public static JSONObject singleUseJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        return json;
    }

    public static Map<String,Object> singleUseMap(SingleUseVG singleUse) {
        Map<String,Object> map = LuaJSON.purchasableItemMap(singleUse);
        return map;
    }

    public static final String SINGLEUSEGOOD_ID     = "singleUseGood";
    public static final String SINGLEUSEGOOD_AMOUNT = "amount";

    public static JSONObject singleUsePackJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        try {
            String singleUseId = (String)map.get(LuaJSON.SINGLEUSEGOOD_ID);
            Integer amount = (Integer)map.get(LuaJSON.SINGLEUSEGOOD_AMOUNT);
            json.put(JSONConsts.VGP_GOOD_ITEMID,singleUseId);
            json.put(JSONConsts.VGP_GOOD_AMOUNT,amount)
        } catch(Exception e) {}
        return json;
    }

    public static Map<String,Object> singleUsePackMap(SingleUsePackVG singleUsePack) {
        HashMap<String,Object> map = (HashMap<String,Object>)LuaJSON.purchasableItemMap(singleUsePack);
        map.put(LuaJSON.SINGLEUSEGOOD_ID,singleUsePack.getGoodItemId());
        map.put(LuaJSON.SINGLEUSEGOOD_AMOUNT,new Double(singleUsePack.getGoodAmount()));
        return map;
    }

    // Lifetime

    public static JSONObject lifetimeJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        return json;
    }

    public static Map<String,Object> lifetimeMap(LifetimeVG lifetime) {
        Map<String,Object> map = LuaJSON.purchasableItemMap(lifetime);
        return lifetime;
    }

    // Equipment

    public static final String EQUIPMENTTYPE            = "equipModel";
    public static final String EQUIPMENTTYPE_LOCAL      = "local";
    public static final String EQUIPMENTTYPE_CATEGORY   = "category";
    public static final String EQUIPMENTTYPE_GLOBAL     = "global";


    public static JSONObject equippableJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        String equipmentType = (String)map.get(LuaJSON.EQUIPMENTTYPE);
        EquippableVG.EquippingModel equipModel = EquippableVG.EquippingModel.LOCAL;
        if(equipmentType.equals(LuaJSON.EQUIPMENTTYPE_CATEGORY)) equipModel = EquippableVG.EquippingModel.CATEGORY;
        else if (equipmentType.equals(LuaJSON.EQUIPMENTTYPE_GLOBAL)) equipModel = EquippableVG.EquippingModel.GLOBAL;
        json.put(JSONConsts.EQUIPPABLE_EQUIPPING,equipModel.toString());
        return json;
    }

    public static Map<String,Object> equippableMap(EquippableVG equippable) {
        HashMap<String,Object> map = (HashMap<String,Object>)LuaJSON.purchasableItemMap(equippable);
        String equipmentType = LuaJSON.EQUIPMENTTYPE_LOCAL;
        switch(equippable.getEquippingModel()) {
            case CATEGORY: equipmentType = LuaJSON.EQUIPMENTTYPE_CATEGORY; break;
            case GLOBAL: equipmentType = LuaJSON.EQUIPMENTTYPE_GLOBAL; break;
            default: equipmentType = LuaJSON.EQUIPMENTTYPE_LOCAL; break;
        }
        map.put(LuaJSON.EQUIPMENTTYPE,equipmentType);
        return map;
    }

    // Upgrade

    public static final String UPGRADE_LINKEDGOOD   = "linkedGood";
    public static final String UPGRADE_PREVIOUS     = "previousUpgrade";
    public static final String UPGRADE_NEXT         = "nextUpgrade";

    public static JSONObject upgradeJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        try {
            String linkedGood = (String)map.get(LuaJSON.UPGRADE_LINKEDGOOD);
            String nextUpgrade = (map.containsKey(LuaJSON.UPGRADE_NEXT)) ? (String)map.get(LuaJSON.UPGRADE_NEXT) : "";
            String previousUpgrade = (map.containsKey(LuaJSON.UPGRADE_PREVIOUS)) ? (String)map.get(LuaJSON.UPGRADE_PREVIOUS) : "";
            json.put(JSONConsts.VGU_GOOD_ITEMID,linkedGood);
            json.put(JSONConsts.VGU_NEXT_ITEMID,nextUpgrade);
            json.put(JSONConsts.VGU_PREV_ITEMID,previousUpgrade);
        } catch(Exception e) {}
        return json;
    }

    public static Map<String,Object> upgradeMap(UpgradeVG upgrade) {
        HashMap<String,Object> map = (HashMap<String,Object>)LuaJSON.purchasableItemMap(upgrade);
        map.put(LuaJSON.UPGRADE_LINKEDGOOD,upgrade.getGoodItemId());
        map.put(LuaJSON.UPGRADE_NEXT,upgrade.getNextItemId());
        map.put(LuaJSON.UPGRADE_PREVIOUS,upgrade.getPrevItemId());
        return map;
    }

    // Non Consumable Item

    public static JSONObject nonConsumableItemJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        return json;
    }

    public static Map<String,Object> nonConsumableItemMap(NonConsumableItem nonConsumableItem) {
        Map<String,Object> map = LuaJSON.purchasableItemMap(nonConsumableItem);
        return map;
    }


}