/*
    Copyright (c) 2010-2011 Josiah Barber (aka Darshan)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
*/

package com.darshancomputing.BatteryIndicatorPro.IconPluginV1.Classic;

import android.content.ComponentName;
import android.content.ServiceConnection;
import android.os.IBinder;

public class PluginServiceConnection implements ServiceConnection {
    public PluginService pluginService;

    public void onServiceConnected(ComponentName name, IBinder service) {
        pluginService = ((PluginService.LocalBinder) service).getService();
    }

    public void onServiceDisconnected(ComponentName name) {
        pluginService = null;
    }
}
