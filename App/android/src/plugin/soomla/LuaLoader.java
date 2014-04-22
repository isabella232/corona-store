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

    private JSONObject getJSONFromLua(LuaState L) {
        Map<String,Object> map = Map_Lua.mapFromLua(L,L.getTop());
        return new JSONObject(map);
    }

    public int createCurrency(LuaState L) {
        JSONObject data = this.getJSONFromLua(L);
        try {
            VirtualCurrency currency = new VirtualCurrency(data);
            this.addVirtualItemForState(currency,L);
        } catch(Exception e) {
            this.handleModelFailure(L,"Currency");
            System.out.println(e.getMessage());
        }
        return 1;
    }


    /// Wrappers
    private class CreateCurrencyWrapper implements NamedJavaFunction {
        @Override public String getName() { return "createCurrency"; }
        @Override public int invoke(LuaState L) { return createCurrency(L); }
    }

	@Override public int invoke(LuaState L) {
        NamedJavaFunction[] luaFunctions = new NamedJavaFunction[] {
                new CreateCurrencyWrapper(),
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
