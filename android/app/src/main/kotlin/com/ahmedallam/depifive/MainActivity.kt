package com.ahmedallam.depifive

import android.content.Context
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(){

        private val CHANNEL = "samples.flutter.dev/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL,
        ).setMethodCallHandler { call, result ->

            when(call.method){
                "getBatteryLevel" -> {
                    val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                    val batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)


                    if(batteryLevel != -1){
                        result.success(batteryLevel)
                    }else{
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }

                }
                else ->  result.notImplemented()
            }

        }

    }




}
