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

import com.soomla.store.domain.PurchasableVirtualItem;
import com.soomla.store.exceptions.InsufficientFundsException;
import com.soomla.store.purchaseTypes.PurchaseWithMarket;
import com.soomla.store.purchaseTypes.PurchaseWithVirtualItem;

import java.lang.Exception;
import java.util.Map;
import java.util.HashMap;

/**
 * A PurchaseType is a way to purchase a PurchasableVirtualItem. This abstract class describes basic features
 * of the actual implementations of PurchaseType.
 */
public abstract class PurchaseType {

    public static PurchaseType fromMap(Map<String,Object> map) throws Exception {
        String type = (String)map.get("purchaseType");
        try {
            if(type == "market") return new PurchaseWithMarket(map);
            else return new PurchaseWithVirtualItem(map);
        } catch (Exception e) { throw e; }
    }

    public Map<String,Object> toMap() {
        HashMap<String,Object> map = new HashMap<String,Object>();
        if(this instanceof PurchaseWithMarket) map.put("purchaseType","market");
        else map.put("purchaseType","virtualItem");
        return map;
    }

    public abstract void buy() throws InsufficientFundsException;

    public void setAssociatedItem(PurchasableVirtualItem associatedItem) {
        mAssociatedItem = associatedItem;
    }

    public PurchasableVirtualItem getAssociatedItem() {
        return mAssociatedItem;
    }

    private PurchasableVirtualItem mAssociatedItem;

}
