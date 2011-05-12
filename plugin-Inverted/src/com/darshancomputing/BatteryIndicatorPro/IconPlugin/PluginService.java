/*
    Copyright (c) 2011 Josiah Barber (aka Darshan)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
*/

package com.darshancomputing.BatteryIndicatorPro.IconPluginV1.Inverted;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;

public class PluginService extends Service {
    private NotificationManager mNotificationManager;
    private Context context;

    private static final int NOTIFICATION_PRIMARY = 1;

    private static final int STATUS_UNPLUGGED     = 0;
    private static final int STATUS_UNKNOWN       = 1;
    private static final int STATUS_CHARGING      = 2;
    private static final int STATUS_DISCHARGING   = 3;
    private static final int STATUS_NOT_CHARGING  = 4;
    private static final int STATUS_FULLY_CHARGED = 5;

    private static final int defaultIcon0 = R.drawable.default000;
    private int chargingIcon0;

    private boolean bound;

    private final Handler mHandler = new Handler();
    private final Runnable mStartMainServiceIfNotBound = new Runnable() {
        public void run() {
            if (bound) return;

            try {
                String mainPackage = "com.darshancomputing.BatteryIndicatorPro";
                Context mainContext = getApplicationContext().createPackageContext(mainPackage, Context.CONTEXT_INCLUDE_CODE);
                ClassLoader mainClassLoader = mainContext.getClassLoader();
                Class mainServiceClass = mainClassLoader.loadClass(mainPackage + ".BatteryIndicatorService");

                startService(new Intent(mainContext, mainServiceClass));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    };

    @Override
    public void onCreate() {
        context = getApplicationContext();
        mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

        try {
            java.lang.reflect.Field f = R.drawable.class.getField("charging000");
            chargingIcon0 = f.getInt(R.drawable.class);
        } catch (Exception e) {
            chargingIcon0 = defaultIcon0;
        }

        /* If the user reinstalls the main package, Android restarts this service.  If we don't check for this,
             we'd end up with a stale notification without a real BI behind it.  So we should either check for this
             and kill this service (which would be the behavior you get without any plugins -- if you reinstall, your
             notification goes away and you have to re-open BI) or take advantage of the opportunity and restart the
             main BI service.

           Our clue is that when we are started by BI we are bound to more or less immediately, whereas when Android
             is restarting us, we don't get bound to.
        */
        bound = false;
        mHandler.postDelayed(mStartMainServiceIfNotBound, 200);
    }

    @Override
    public void onDestroy() {
        mNotificationManager.cancelAll();
    }

    @Override
    public IBinder onBind(Intent intent) {
        bound = true;
        return mBinder;
    }

    public class LocalBinder extends Binder {
        public Service getService() {
            return PluginService.this;
        }
    }

    private final IBinder mBinder = new LocalBinder();

    public void notify(int percent, int status, String title, String text, PendingIntent intent) {
        int icon;

        if (status == STATUS_CHARGING)
            icon = chargingIcon0 + percent;
        else
            icon = defaultIcon0 + percent;

        Notification notification = new Notification(icon, null, System.currentTimeMillis());

        notification.flags |= Notification.FLAG_ONGOING_EVENT | Notification.FLAG_NO_CLEAR;
        notification.setLatestEventInfo(context, title, text, intent);

        mNotificationManager.notify(NOTIFICATION_PRIMARY, notification);
    }
}
