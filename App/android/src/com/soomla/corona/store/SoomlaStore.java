package com.soomla.corona.store;

import com.soomla.store.IStoreAssets;
import com.soomla.store.StoreController;
import com.soomla.store.domain.*;
import com.soomla.store.domain.virtualCurrencies.*;
import com.soomla.store.domain.virtualGoods.*;

import java.lang.Integer;
import java.lang.Override;
import java.lang.String;
import java.lang.Exception;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

public class SoomlaStore implements IStoreAssets {

    /// Singleton
    private SoomlaStore() {}

    public static SoomlaStore getInstance() {
        if(_instance == null) _instance = new SoomlaStore();
        return _instance;
    }

    private static SoomlaStore _instance;

    /// Initialization
    public void initialize(Map<String,Object> map) throws Exception {
        try {
            this.version = ((Integer)map.get("version")).intValue();

            Map<String,String> categories = (Map<String,String>)map.get("virtualCategories");
            this.availableCategories = new ArrayList<String>(categories.values());

            Map<String,String> currencies = (Map<String,String>)map.get("virtualCurrencies");
            this.availableCurrencies = new ArrayList<String>(currencies.values());

            Map<String,String> currencyPacks = (Map<String,String>)map.get("virtualCurrencyPacks");
            this.availableCurrencyPacks = new ArrayList<String>(currencyPacks.values());

            Map<String,String> virtualGoods = (Map<String,String>)map.get("virtualGoods");
            this.availableVirtualGoods = new ArrayList<String>(virtualGoods.values());

            Map<String,String> nonConsumableItems = (Map<String,String>)map.get("nonConsumableItems");
            this.availableNonConsumableItems = new ArrayList<String>(nonConsumableItems.values());

            this.customSecret = (String)map.get("CUSTOM_SECRET");
            this.soomlaSecret = (String)map.get("SOOM_SEC");
            this.googlePlayKey = (String)map.get("GOOGLE_PLAY_KEY");

            StoreController.getInstance().initialize(this,this.googlePlayKey,this.customSecret);
        } catch(Exception e) { throw e; }
    }

    /// Version
    @Override public int getVersion() {
        return this.version;
    }

    private int version = 0;

    /// Security
    private String customSecret = "UNKNOWN";
    private String soomlaSecret = "UNKNOWN";
    private String googlePlayKey = "UNKNOWN";

    /// Virtual Items
    public void addVirtualItem(VirtualItem virtualItem) {
        this.vItems.put(virtualItem.itemId,virtualItem);
    }

    private HashMap<String,VirtualItem> vItems = new HashMap<String,VirtualItem>();


    /// Category
    public void addVirtualCategory(VirtualCategory category) {
        this.vCategories.put(category.name,category);
    }

    public VirtualCategory getCategory(String name) {
        return this.vCategories.get(name);
    }

    private HashMap<String,VirtualCategory> vCategories = new HashMap<String,VirtualCategory>();

    /// Availables
    @Override public VirtualCurrency[] getCurrencies() {
        ArrayList<VirtualCurrency> currencies = new ArrayList<VirtualCurrency>();
        for(String currencyId : this.availableCurrencies) {
            VirtualCurrency currency = (VirtualCurrency)this.vItems.get(currencyId);
            currencies.add(currency);
        }
        return currencies.toArray();
    }

    @Override public VirtualCurrencyPack[] getCurrencyPacks() {
        ArrayList<VirtualCurrencyPack> currencyPacks = new ArrayList<VirtualCurrencyPack>();
        for(String currencyPackId : this.availableCurrencyPacks) {
            VirtualCurrencyPack currencyPack = (VirtualCurrencyPack)this.vItems.get(currencyPackId);
            currencyPacks.add(currencyPack);
        }
        return currencyPacks.toArray();
    }

    @Override public VirtualCategory[] getVirtualCategories() {
        ArrayList<VirtualCategory> categories = new ArrayList<VirtualCategory>();
        for(String categoryName : this.availableCurrencies) {
            VirtualCategory category = this.vCategories.get(categoryName);
            categories.add(category);
        }
        return categories.toArray();
    }

    @Override public VirtualGood[] getGoods() {
        ArrayList<VirtualGood> virtualGoods = new ArrayList<VirtualGood>();
        for(String virtualGoodId : this.availableVirtualGoods) {
            VirtualGood virtualGood = (VirtualGood)this.vItems.get(virtualGoodId);
            virtualGoods.add(virtualGood);
        }
        return virtualGoods.toArray();
    }

    @Override public NonConsumableItem[] getNonConsumableItems() {
        ArrayList<NonConsumableItem> nonConsumableItems = new ArrayList<NonConsumableItem>();
        for(String nonConsumableItemId : this.availableNonConsumableItems) {
            NonConsumableItem nonConsumableItem = (NonConsumableItem)this.vItems.get(nonConsumableItemId);
            nonConsumableItems.add(nonConsumableItem);
        }
        return nonConsumableItems.toArray();
    }


    private ArrayList<String> availableCategories = new ArrayList<String>();
    private ArrayList<String> availableCurrencies = new ArrayList<String>();
    private ArrayList<String> availableCurrencyPacks = new ArrayList<String>();
    private ArrayList<String> availableNonConsumableItems = new ArrayList<String>();
    private ArrayList<String> availableVirtualGoods = new ArrayList<String>();
}