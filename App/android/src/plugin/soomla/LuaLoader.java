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

import com.soomla.store.domain.*;
import com.soomla.store.domain.virtualCurrencies.VirtualCurrency;

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
    private void HandleModelFailure(LuaState L,String modelName) {
        System.out.print(modelName + " couldn't be created");
        L.pushNil();
    }

    public int CreateCurrency(LuaState L) {

        return 1;
    }

	/** Implements the library.init() Lua function. */
	private class InitWrapper implements NamedJavaFunction {
		/**
		 * Gets the name of the Lua function as it would appear in the Lua script.
		 * @return Returns the name of the custom Lua function.
		 */
		@Override
		public String getName() {
			return "init";
		}
		
		/**
		 * This method is called when the Lua function is called.
		 * <p>
		 * Warning! This method is not called on the main UI thread.
		 * @param luaState Reference to the Lua state.
		 *                 Needed to retrieve the Lua function's parameters and to return values back to Lua.
		 * @return Returns the number of values to be returned by the Lua function.
		 */
		@Override
		public int invoke(LuaState L) {
			return init(L);
		}
	}

	/** Implements the library.show() Lua function. */
	private class ShowWrapper implements NamedJavaFunction {
		/**
		 * Gets the name of the Lua function as it would appear in the Lua script.
		 * @return Returns the name of the custom Lua function.
		 */
		@Override
		public String getName() {
			return "show";
		}
		
		/**
		 * This method is called when the Lua function is called.
		 * <p>
		 * Warning! This method is not called on the main UI thread.
		 * @param luaState Reference to the Lua state.
		 *                 Needed to retrieve the Lua function's parameters and to return values back to Lua.
		 * @return Returns the number of values to be returned by the Lua function.
		 */
		@Override
		public int invoke(LuaState L) {
			return show(L);
		}
	}

    @Override public int invoke(LuaState L) {
        NamedJavaFunction[] luaFunctions = new NamedJavaFunction[] {
                new InitWrapper(),
                new ShowWrapper(),
        };
        String libName = L.toString( 1 );
        L.register(libName, luaFunctions);
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
