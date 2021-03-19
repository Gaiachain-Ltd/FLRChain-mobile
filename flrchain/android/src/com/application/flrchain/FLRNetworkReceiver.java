package com.application.flrchain;

import android.content.Context;
import android.content.BroadcastReceiver;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.widget.Toast;
import android.os.Handler;

public class FLRNetworkReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(final Context context, final Intent intent) {
        if (checkInternet(context)) {
           networkAvailableCallback(true);
        } else {
           networkAvailableCallback(false);
        }
    }

    boolean checkInternet(Context context) {
        FLRServiceManager serviceManager = new FLRServiceManager(context);
        if (serviceManager.isNetworkAvailable()) {
            return true;
        } else {
            return false;
        }
    }

    public native void networkAvailableCallback(boolean isAvaliable);
}
