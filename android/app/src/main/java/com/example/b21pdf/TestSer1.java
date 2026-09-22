package com.example.b21pdf;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

public class TestSer1 extends Service {

    @Override
    public void onCreate() {
        super.onCreate();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }
}
