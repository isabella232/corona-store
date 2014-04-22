/*
 * Copyright (C) 2012 Soomla Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.soomla.store.purchaseTypes;

import com.soomla.store.BusProvider;
import com.soomla.store.StoreUtils;
import com.soomla.store.data.StorageManager;
import com.soomla.store.data.StoreInfo;
import com.soomla.store.data.VirtualItemStorage;
import com.soomla.store.domain.VirtualItem;
import com.soomla.store.events.ItemPurchaseStartedEvent;
import com.soomla.store.events.ItemPurchasedEvent;
import com.soomla.store.exceptions.InsufficientFundsException;
import com.soomla.store.exceptions.VirtualItemNotFoundException;

import java.lang.Exception;
import java.lang.Integer;
import java.lang.Object;
import java.lang.String;
import java.util.Map;
import java.util.HashMap;

/**
 * This type of IabPurchase allows users to purchase PurchasableVirtualItems with other VirtualItems.
 */
public class PurchaseWithVirtualItem extends PurchaseType {

    /** Constructor
     *
     * @param targetItemId is the itemId of the VirtualItem that is used to "pay" in order to make the purchase.
     * @param amount is the number of items to purchase.
     */
    public PurchaseWithVirtualItem(String targetItemId, int amount) {
        mTargetItemId = targetItemId;
        mAmount = amount;
    }

    public PurchaseWithVirtualItem(Map<String,Object> map) throws Exception {
        if(!map.containsKey("exchangeCurrency")) { throw new Exception("SOOMLA: exchangeCurrency can't be null for a PurchaseWithVirtualItem"); }
        Map<String,Object> exchangeCurrencyMap = (Map<String,Object>)map.get("exchangeCurrency");

        if(!exchangeCurrencyMap.containsKey("itemId")) { throw new Exception("SOOMLA: itemId can't be null for a PurchaseWithVirtualItem"); }
        this.mTargetItemId = (String)exchangeCurrencyMap.get("itemId");

        this.mAmount = (exchangeCurrencyMap.containsKey("amount")) ? ((Integer)exchangeCurrencyMap.get("amount")).intValue() : 0;
    }

    @Override public Map<String,Object> toMap() {
        HashMap<String,Object> map = (HashMap<String,Object>)super.toMap();
        HashMap<String,Object> exchangeCurrencyMap = new HashMap<String,Object>();
        exchangeCurrencyMap.put("itemId",this.mTargetItemId);
        exchangeCurrencyMap.put("amount",new Double(this.mAmount));
        map.put("exchangeCurrency",exchangeCurrencyMap);
        return map;
    }

    /**
     * see parent
     */
    @Override
    public void buy() throws InsufficientFundsException{

        StoreUtils.LogDebug(TAG, "Trying to buy a " + getAssociatedItem().getName() + " with " + mAmount + " pieces of " + mTargetItemId);

        VirtualItem item = null;
        try {
            item = StoreInfo.getVirtualItem(mTargetItemId);
        } catch (VirtualItemNotFoundException e) {
            StoreUtils.LogError(TAG, "Target virtual item doesn't exist !");
            return;
        }

        BusProvider.getInstance().post(new ItemPurchaseStartedEvent(getAssociatedItem()));

        VirtualItemStorage storage = StorageManager.getVirtualItemStorage(item);

        assert storage != null;
        int balance = storage.getBalance(item);
        if (balance < mAmount){
            throw new InsufficientFundsException(mTargetItemId);
        }

        storage.remove(item, mAmount);

        getAssociatedItem().give(1);
        BusProvider.getInstance().post(new ItemPurchasedEvent(getAssociatedItem()));
    }

    public String getTargetItemId() {
        return mTargetItemId;
    }

    public int getAmount() {
        return mAmount;
    }

    private static final String TAG = "SOOMLA PurchaseWithVirtualItem";

    private String      mTargetItemId;
    private int         mAmount;
}
