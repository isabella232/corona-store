//
//  LuaLoader.java
//  TemplateApp
//
//  Copyright (c) 2014 Soomla. All rights reserved.
//

package plugin.soomla;

import android.app.Activity;
import android.util.Log;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import com.naef.jnlua.LuaState;
import com.naef.jnlua.JavaFunction;
import com.naef.jnlua.NamedJavaFunction;
import com.ansca.corona.CoronaActivity;
import com.ansca.corona.CoronaEnvironment;
import com.ansca.corona.CoronaLua;
import com.ansca.corona.CoronaRuntime;
import com.ansca.corona.CoronaRuntimeListener;

import com.soomla.corona.Map_Lua;
import com.soomla.store.domain.*;
import com.soomla.store.domain.virtualCurrencies.*;
import com.soomla.store.domain.virtualGoods.*;
import com.soomla.store.data.StoreInfo;

import org.json.JSONObject;

import java.lang.Exception;
import java.lang.Override;
import java.util.Map;

/**
 * Implements the Lua interface for a Corona plugin.
 * <p>
 * Only one instance of this class will be created by Corona for the lifetime of the application.
 * This instance will be re-used for every new Corona activity that gets created.
 */
public class LuaLoader implements JavaFunction, CoronaRuntimeListener {


	public LuaLoader() {
		CoronaEnvironment.addRuntimeListener(this);
	}

    /// Creating Models
    private void addVirtualItemForState(VirtualItem virtualItem,LuaState L) {
        //TODO: Add the Virtual Item into the SoomlaStore instance
        L.pushString(virtualItem.getName());
    }

    private void handleModelFailure(LuaState L,String modelName) {
        System.out.print(modelName + " couldn't be created");
        L.pushNil();
    }

    private Map<String,Object> getMapFromLua(LuaState L) {
        return Map_Lua.mapFromLua(L,L.getTop());
    }

    public int getVirtualItem(LuaState L) {
        String itemId = L.toString(-1);
        try {
            VirtualItem virtualItem = StoreInfo.getVirtualItem(itemId);
            Map<String,Object> map = virtualItem.toMap();
            Map_Lua.mapToLua(map,L);
        } catch (Exception) {
            System.out.println("SOOMLA: VirtualItem with itemId=" + itemId + " couldn't be find!");
            L.pushNil();
        }
        return 1;
    }

    public int createCurrency(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            VirtualCurrency currency = new VirtualCurrency(map);
            this.addVirtualItemForState(currency,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"Currency");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getCurrency(LuaState L) {
        return this.getVirtualItem(L);
    }

    public int createCurrencyPack(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            VirtualCurrencyPack currencyPack = new VirtualCurrencyPack(map);
            this.addVirtualItemForState(currencyPack,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"CurrencyPack");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getCurrencyPack(LuaState L) {
        return this.getVirtualItem(L);
    }

    public int createSingleUseVG(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            SingleUseVG singleUse = new SingleUseVG(map);
            this.addVirtualItemForState(singleUse,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"SingleUseVG");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getSingleUseVG(LuaState L) {
        return this.getVirtualItem(L);
    }

    public int createLifetimeVG(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            LifetimeVG lifetime = new LifetimeVG(map);
            this.addVirtualItemForState(lifetime,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"LifetimeVG");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getLifetimeVG(LuaState L) {
        return this.getVirtualItem(L);
    }

    public int createEquippableVG(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            EquippableVG equippable = new EquippableVG(map);
            this.addVirtualItemForState(equippable,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"EquippableVG");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getEquippableVG(LuaState L) {
        return this.getVirtualItem(L);
    }

    public int createSingleUsePackVG(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            SingleUsePackVG singleUsePack = new SingleUsePackVG(map);
            this.addVirtualItemForState(singleUsePack,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"SingleUsePackVG");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getSingleUsePackVG(LuaState L) {
        return this.getVirtualItem(L);
    }

    public int createUpgradeVG(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            UpgradeVG upgrade = new UpgradeVG(map);
            this.addVirtualItemForState(upgrade,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"UpgradeVG");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getUpgradeVG(LuaState L) {
        return this.getVirtualItem(L);
    }

    public int createNonConsumableItem(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            NonConsumableItem nonConsumable = new NonConsumableItem(map);
            this.addVirtualItemForState(nonConsumable,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"NonConsumableItem");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getNonConsumableItem(LuaState L) {
        return this.getVirtualItem(L);
    }

    public int createVirtualCategory(LuaState L) {
        try {
            Map<String,Object> map = this.getMapFromLua(L);
            VirtualCategory category = new VirtualCategory(map);
            //TODO: Add the Virtual Item into the SoomlaStore instance
            L.pushString(category.getName());
        } catch(Exception e) {
            this.handleModelFailure(L,"Category");
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getVirtualCategory(LuaState L) {
        String name = L.toString(-1);
        //TODO: Get category
        return 0;
    }


    /// Wrappers
    private class GetVirtualItemWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getVirtualItem"; }
        @Override public int invoke(LuaState L) { return getVirtualItem(L); }
    }

    private class CreateCurrencyWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createCurrency"; }
        @Override public int invoke(LuaState L) { return createCurrency(L); }
    }

    private class GetCurrencyWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getCurrency"; }
        @Override public int invoke(LuaState L) { return getCurrency(L); }
    }

    private class CreateCurrencyPackWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createCurrencyPack"; }
        @Override public int invoke(LuaState L) { return createCurrencyPack(L); }
    }

    private class GetCurrencyPackWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getCurrencyPack"; }
        @Override public int invoke(LuaState L) { return getCurrencyPack(L); }
    }

    private class CreateSingleUseVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createSingleUseVG"; }
        @Override public int invoke(LuaState L) { return createSingleUseVG(L); }
    }

    private class GetSingleUseVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getSingleUseVG"; }
        @Override public int invoke(LuaState L) { return getSingleUseVG(L); }
    }

    private class CreateLifetimeVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createLifetimeVG"; }
        @Override public int invoke(LuaState L) { return createLifetimeVG(L); }
    }

    private class GetLifetimeVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getLifetimeVG"; }
        @Override public int invoke(LuaState L) { return getLifetimeVG(L); }
    }

    private class CreateEquippableVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createEquippableVG"; }
        @Override public int invoke(LuaState L) { return createEquippableVG(L); }
    }

    private class GetEquippableVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getEquippableVG"; }
        @Override public int invoke(LuaState L) { return getEquippableVG(L); }
    }

    private class CreateSingleUsePackVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createSingleUsePackVG"; }
        @Override public int invoke(LuaState L) { return createSingleUsePackVG(L); }
    }

    private class GetSingleUsePackVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getSingleUsePackVG"; }
        @Override public int invoke(LuaState L) { return getSingleUsePackVG(L); }
    }

    private class CreateUpgradeVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createUpgradeVG"; }
        @Override public int invoke(LuaState L) { return createUpgradeVG(L); }
    }

    private class GetUpgradeVGWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getUpgradeVG"; }
        @Override public int invoke(LuaState L) { return getUpgradeVG(L); }
    }

    private class CreateNonConsumableItemWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createNonConsumableItem"; }
        @Override public int invoke(LuaState L) { return createNonConsumableItem(L); }
    }

    private class GetNonConsumableItemWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getNonConsumableItem"; }
        @Override public int invoke(LuaState L) { return getNonConsumableItem(L); }
    }

    private class CreateVirtualCategoryWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createVirtualCategory"; }
        @Override public int invoke(LuaState L) { return createVirtualCategory(L); }
    }

    private class GetVirtualCategoryWrapper implements NamedJavaFunction {
        @Override public String getName() { return "getVirtualCategory"; }
        @Override public int invoke(LuaState L) { return getVirtualCategory(L); }
    }

	@Override public int invoke(LuaState L) {
        NamedJavaFunction[] luaFunctions = new NamedJavaFunction[] {
                new GetVirtualItemWrapper(),
                new CreateCurrencyWrapper(),
                new GetCurrencyWrapper(),
                new CreateCurrencyPackWrapper(),
                new GetCurrencyPackWrapper(),
                new CreateEquippableVGWrapper(),
                new GetEquippableVGWrapper(),
                new CreateLifetimeVGWrapper(),
                new GetLifetimeVGWrapper(),
                new CreateNonConsumableItemWrapper(),
                new GetNonConsumableItemWrapper(),
                new CreateSingleUsePackVGWrapper(),
                new GetSingleUsePackVGWrapper(),
                new CreateSingleUseVGWrapper(),
                new GetSingleUseVGWrapper(),
                new CreateUpgradeVGWrapper(),
                new GetUpgradeVGWrapper(),
                new CreateVirtualCategoryWrapper(),
                new GetVirtualCategoryWrapper()
        };
        String libName = L.toString(1);
        L.register(libName,luaFunctions);
        return 1;
    }

    /// Corona Events
    @Override public void onLoaded(CoronaRuntime runtime) { this.runtime = runtime; }
    @Override public void onStarted(CoronaRuntime runtime) {}
    @Override public void onSuspended(CoronaRuntime runtime) {}
    @Override public void onResumed(CoronaRuntime runtime) {}
    @Override public void onExiting(CoronaRuntime runtime) {
        // TODO: Delete all the Lua references
        CoronaLua.deleteRef( runtime.getLuaState(), fListener );
        fListener = CoronaLua.REFNIL;
    }



    private CoronaRuntime runtime;

    private int fListener;
    private static final String EVENT_NAME = "pluginlibraryevent";
}
