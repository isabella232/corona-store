package com.soomla.corona.store.domain;

import com.soomla.store.domain.*;

import com.soomla.corona.Map_Lua;
import com.soomla.store.data.JSONConsts;
import com.soomla.store.domain.MarketItem;
import com.soomla.store.domain.virtualGoods.EquippableVG;

import org.apache.http.util.LangUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.lang.Integer;
import java.lang.Object;
import java.lang.Exception;
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

    public static JSONObject purchasableVirtualItemJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.virtualItemJSON(map);
        try {
            Map<String,Object> purchaseMap = (Map<String,Object>)map.get(LuaJSON.PURCHASE);
            String purchaseType = purchaseMap.get(LuaJSON.PURCHASETYPE);
            boolean isMarket = purchaseType.equals(LuaJSON.PURCHASEMARKET);
            JSONObject purchaseTypeJSON = (isMarket) ? LuaJSON.purchaseMarketJSON(purchaseMap) : LuaJSON.purchaseVirtualItem(purchaseMap);
            json.put(JSONConsts.PURCHASABLE_ITEM,purchaseTypeJSON);
        } catch(Exception e) {}
        return json;
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

    public static final String EXCHANGE_CURRENCY    = "exchangeCurrency";
    public static final String EXCHANGE_AMOUNT      = "amount";

    public static JSONObject purchaseVirtualItem(Map<String,Object> map) {
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

    // Virtual Currencies

    public static JSONObject currencyJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.virtualItemJSON(map);
        return json;
    }

    public static JSONObject currencyPackJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        return json;
    }

    // Single Use

    public static JSONObject singleUseJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        return json;
    }

    public static final String SINGLEUSEGOOD_ID     = "singleUseGood";
    public static final String SINGLEUSEGOOD_AMOUNT = "amount";

    public static JSONObject singleUsePackJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        try {
            String singleUseId = (String)map.get(LuaJSON.SINGLEUSEGOOD);
            Integer amount = (Integer)map.get(LuaJSON.SINGLEUSEGOOD_AMOUNT);
            json.put(JSONConsts.VGP_GOOD_ITEMID,singleUseId);
            json.put(JSONConsts.VGP_GOOD_AMOUNT,amount)
        } catch(Exception e) {}
        return json;
    }

    // Lifetime

    public static JSONObject lifetimeJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        return json;
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

    // Non Consumable Item

    public static JSONObject nonConsumableItemJSON(Map<String,Object> map) {
        JSONObject json = LuaJSON.purchasableVirtualItemJSON(map);
        return json;
    }


}