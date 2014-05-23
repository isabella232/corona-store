package com.soomla.corona.store;

import com.soomla.store.domain.*;
import com.soomla.store.domain.virtualCurrencies.*;
import com.soomla.store.domain.virtualGoods.*;
import com.soomla.store.BusProvider;
import com.soomla.store.SoomlaApp;
import com.soomla.store.StoreConfig;
import com.soomla.store.events.*;
import com.squareup.otto.Subscribe;

import java.lang.Boolean;
import java.lang.Object;
import java.lang.String;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

public class EventListener {

    /// Singleton
    private EventListener() {}

    public static EventListener getInstance() {
        if(_instance == null) _instance = new EventListener();
        return _instance;
    }

    private static EventListener _instance;

    @Subscribe public void onMarketPurchase(MarketPurchaseEvent marketPurchaseEvent) {
        VirtualItem purchasableVirtualItem = marketPurchaseEvent.getPurchasableVirtualItem();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_MarketPurchase");
        map.put("purchasableItem",purchasableVirtualItem.toMap());
        map.put("payload",marketPurchaseEvent.getPayload());
        map.put("token",marketPurchaseEvent.getToken());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onMarketItemsRefreshed(MarketItemsRefreshed marketItemsRefreshedEvent) {
        ArrayList<Map<String,Object>> items = new ArrayList<Map<String,Object>>();
        for(MarketItem marketItem : marketItemsRefreshedEvent.getMarketItems()) {
            items.add(marketItem.toMap());
        }
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_MarketItemsRefreshed");
        map.put("items",items);
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onMarketRefund(MarketRefundEvent marketRefundEvent) {
        VirtualItem purchasableVirtualItem = marketRefundEvent.getPurchasableVirtualItem();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_MarketRefund");
        map.put("purchasableItem",purchasableVirtualItem.toMap());
        map.put("payload",marketRefundEvent.getPayload());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onVirtualItemPurchased(ItemPurchasedEvent itemPurchasedEvent) {
        VirtualItem purchasableVirtualItem = itemPurchasedEvent.getPurchasableVirtualItem();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_ItemPurchased");
        map.put("purchasableItem",purchasableVirtualItem.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onVirtualGoodEquipped(GoodEquippedEvent virtualGoodEquippedEvent) {
        VirtualItem equippableVG = virtualGoodEquippedEvent.getGood();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_VirtualGoodEquipped");
        map.put("equippableVG",equippableVG.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onVirtualGoodUnequipped(GoodUnEquippedEvent virtualGoodUnEquippedEvent) {
        VirtualItem equippableVG = virtualGoodUnEquippedEvent.getGood();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_VirtualGoodUNEQUIPPED");
        map.put("equippableVG",equippableVG.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onGoodUpgrade(GoodUpgradeEvent goodUpgradeEvent) {
        VirtualItem upgradeVG = goodUpgradeEvent.getCurrentUpgrade();
        VirtualItem good = goodUpgradeEvent.getGood();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_VirtualGoodUpgrade");
        map.put("virtualGood",good.toMap());
        map.put("upgradeVG",upgradeVG.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onBillingSupported(BillingSupportedEvent billingSupportedEvent) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_BillingSupported");
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onBillingNotSupported(BillingNotSupportedEvent billingNotSupportedEvent) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_BillingNotSupported");
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onMarketPurchaseStarted(MarketPurchaseStartedEvent marketPurchaseStartedEvent) {
        VirtualItem purchasableVirtualItem = marketPurchaseStartedEvent.getPurchasableVirtualItem();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_MarketPurchaseStarted");
        map.put("purchasableItem", purchasableVirtualItem.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onMarketPurchaseCancelled(MarketPurchaseCancelledEvent marketPurchaseCancelledEvent) {
        VirtualItem purchasableVirtualItem = marketPurchaseCancelledEvent.getPurchasableVirtualItem();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_MarketPurchaseCancelled");
        map.put("purchasableItem",purchasableVirtualItem.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onItemPurchaseStarted(ItemPurchaseStartedEvent itemPurchaseStartedEvent) {
        VirtualItem purchasableVirtualItem = itemPurchaseStartedEvent.getPurchasableVirtualItem();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_ItemPurchaseStarted");
        map.put("purchasableItem",purchasableVirtualItem.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onUnexpectedErrorInStore(UnexpectedStoreErrorEvent unexpectedStoreErrorEvent) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_UnexpectedErrorInStore");
        map.put("description",unexpectedStoreErrorEvent.getMessage());
        map.put("code",new Double(0));
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onIabServiceStarted(IabServiceStartedEvent iabServiceStartedEvent) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_IabServiceStarted");
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onIabServiceStopped(IabServiceStoppedEvent iabServiceStoppedEvent) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_IabServiceStopped");
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onCurrencyBalanceChanged(CurrencyBalanceChangedEvent currencyBalanceChangedEvent) {
        VirtualItem currency = currencyBalanceChangedEvent.getCurrency();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_ChangedCurrencyBalance");
        map.put("balance",new Double(currencyBalanceChangedEvent.getBalance()));
        map.put("amountAdded",new Double(currencyBalanceChangedEvent.getAmountAdded()));
        map.put("currency",currency.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onGoodBalanceChanged(GoodBalanceChangedEvent goodBalanceChangedEvent) {
        VirtualItem virtualGood = goodBalanceChangedEvent.getGood();
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_ChangedGoodBalance");
        map.put("balance",new Double(goodBalanceChangedEvent.getBalance()));
        map.put("amountAdded",new Double(goodBalanceChangedEvent.getAmountAdded()));
        map.put("virtualGood",virtualGood.toMap());
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onRestoreTransactionsFinished(RestoreTransactionsFinishedEvent restoreTransactionsFinishedEvent) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_TransactionRestored");
        map.put("success",new Boolean(restoreTransactionsFinishedEvent.isSuccess()));
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onRestoreTransactionsStarted(RestoreTransactionsStartedEvent restoreTransactionsStartedEvent) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_TransactionRestoreStarted");
        plugin.soomla.LuaLoader.throwEvent(map);
    }

    @Subscribe public void onStoreControllerInitialized(StoreControllerInitializedEvent storeControllerInitializedEvent) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name","soomla_StoreControllerInitialized");
        plugin.soomla.LuaLoader.throwEvent(map);
    }

}