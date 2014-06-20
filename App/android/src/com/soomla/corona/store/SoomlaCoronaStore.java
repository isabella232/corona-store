package com.soomla.corona.store;

import com.soomla.store.billing.google.*;
import com.soomla.store.IStoreAssets;
import com.soomla.store.SoomlaStore;
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

public class SoomlaCoronaStore implements IStoreAssets {

    /// Singleton
    private SoomlaCoronaStore() {}

    public static SoomlaCoronaStore getInstance() {
        if(_instance == null) _instance = new SoomlaCoronaStore();
        return _instance;
    }

    private static SoomlaCoronaStore _instance;

    /// Initialization
    public static final String VERSION          = "version";
    public static final String CATEGORIES       = "virtualCategories";
    public static final String CURRENCIES       = "virtualCurrencies";
    public static final String CURRENCYPACKS    = "virtualCurrencyPacks";
    public static final String VIRTUALGOODS     = "virtualGoods";
    public static final String NONCONSUMABLE    = "nonConsumableItems";
    public static final String CUSTOMSECRET     = "CUSTOM_SECRET";
    public static final String SOOMSEC          = "SOOM_SEC";
    public static final String GOOGLEPLAYKEY    = "GOOGLE_PLAY_KEY";


    public void initialize(Map<String,Object> map) throws Exception {
        try {
            this.version = ((Integer)map.get(SoomlaCoronaStore.VERSION)).intValue();

            Map<String,String> categories = (Map<String,String>)map.get(SoomlaCoronaStore.CATEGORIES);
            this.availableCategories = new ArrayList<String>(categories.values());

            Map<String,String> currencies = (Map<String,String>)map.get(SoomlaCoronaStore.CURRENCIES);
            this.availableCurrencies = new ArrayList<String>(currencies.values());

            Map<String,String> currencyPacks = (Map<String,String>)map.get(SoomlaCoronaStore.CURRENCYPACKS);
            this.availableCurrencyPacks = new ArrayList<String>(currencyPacks.values());

            Map<String,String> virtualGoods = (Map<String,String>)map.get(SoomlaCoronaStore.VIRTUALGOODS);
            this.availableVirtualGoods = new ArrayList<String>(virtualGoods.values());

            Map<String,String> nonConsumableItems = (Map<String,String>)map.get(SoomlaCoronaStore.NONCONSUMABLE);
            this.availableNonConsumableItems = new ArrayList<String>(nonConsumableItems.values());

            this.customSecret = (String)map.get(SoomlaCoronaStore.CUSTOMSECRET);
            this.soomlaSecret = (String)map.get(SoomlaCoronaStore.SOOMSEC);
            this.googlePlayKey = (String)map.get(SoomlaCoronaStore.GOOGLEPLAYKEY);

            //StoreConfig.SOOM_SEC = this.soomlaSecret;
            Soomla.initialize(this.customSecret);
            SoomlaStore.getInstance().initialize(this);
            GooglePlayIabService.getInstance().setPublicKey(this.googlePlayKey);
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
        this.vItems.put(virtualItem.getItemId(),virtualItem);
    }

    private HashMap<String,VirtualItem> vItems = new HashMap<String,VirtualItem>();


    /// Category
    public void addVirtualCategory(VirtualCategory category) {
        this.vCategories.put(category.getName(),category);
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
        VirtualCurrency[] currencyArray = new VirtualCurrency[currencies.size()];
        return currencies.toArray(currencyArray);
    }

    @Override public VirtualCurrencyPack[] getCurrencyPacks() {
        ArrayList<VirtualCurrencyPack> currencyPacks = new ArrayList<VirtualCurrencyPack>();
        for(String currencyPackId : this.availableCurrencyPacks) {
            VirtualCurrencyPack currencyPack = (VirtualCurrencyPack)this.vItems.get(currencyPackId);
            currencyPacks.add(currencyPack);
        }
        VirtualCurrencyPack[] currencyPackArray = new VirtualCurrencyPack[currencyPacks.size()];
        return currencyPacks.toArray(currencyPackArray);
    }

    @Override public VirtualCategory[] getCategories() {
        ArrayList<VirtualCategory> categories = new ArrayList<VirtualCategory>();
        for(String categoryName : this.availableCurrencies) {
            VirtualCategory category = this.vCategories.get(categoryName);
            categories.add(category);
        }
        VirtualCategory[] categoryArray = new VirtualCategory[categories.size()];
        return categories.toArray(categoryArray);
    }

    @Override public VirtualGood[] getGoods() {
        ArrayList<VirtualGood> virtualGoods = new ArrayList<VirtualGood>();
        for(String virtualGoodId : this.availableVirtualGoods) {
            VirtualGood virtualGood = (VirtualGood)this.vItems.get(virtualGoodId);
            virtualGoods.add(virtualGood);
        }
        VirtualGood[] virtualGoodArray = new VirtualGood[virtualGoods.size()];
        return virtualGoods.toArray(virtualGoodArray);
    }

    @Override public NonConsumableItem[] getNonConsumableItems() {
        ArrayList<NonConsumableItem> nonConsumableItems = new ArrayList<NonConsumableItem>();
        for(String nonConsumableItemId : this.availableNonConsumableItems) {
            NonConsumableItem nonConsumableItem = (NonConsumableItem)this.vItems.get(nonConsumableItemId);
            nonConsumableItems.add(nonConsumableItem);
        }
        NonConsumableItem[] nonConsumableItemArray = new NonConsumableItem[nonConsumableItems.size()];
        return nonConsumableItems.toArray(nonConsumableItemArray);
    }


    private ArrayList<String> availableCategories = new ArrayList<String>();
    private ArrayList<String> availableCurrencies = new ArrayList<String>();
    private ArrayList<String> availableCurrencyPacks = new ArrayList<String>();
    private ArrayList<String> availableNonConsumableItems = new ArrayList<String>();
    private ArrayList<String> availableVirtualGoods = new ArrayList<String>();
}