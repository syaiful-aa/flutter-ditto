package com.thoughtlab.ditto

import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val configChannel = "config_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            configChannel
        ).setMethodCallHandler { call, result ->
            provideResult(call, result)
        }
    }

    private fun provideResult(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "currentFlavor" -> {
                result.success(BuildConfig.FLAVOR)
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
