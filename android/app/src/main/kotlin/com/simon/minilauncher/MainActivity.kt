package com.simon.minilauncher

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import java.util.*

class MainActivity: FlutterActivity() {

    private val channel = "com.simon.minilauncher/test"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            if(call.method == "getAppUsageList") {

                val message = getAppUsages(context)
                result.success(message)

            } else {
                result.notImplemented()
            }
        }
    }

    fun getAppUsages(context: Context): List<Map<String, Any>> {

        // Current timestamp
        val endTime = System.currentTimeMillis()

        // Start of the day
        val calendar = Calendar.getInstance()
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        val startTime = calendar.timeInMillis

        // Gets usage stats
        val usageStatsManager = context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val queryUsageStats = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_BEST,
            startTime,
            endTime
        )

        val appUsageList = mutableListOf<Map<String, Any>>()

        // Adds the usage stats to the list
        queryUsageStats?.let {
            if (it.isNotEmpty()) {
                for (stats in it) {

                    // If the utilization time is not zero the app gets added to the list
                    if(stats.totalTimeInForeground/(60000) != 0.toLong()) {
                        val appUsage = mapOf("packageName" to stats.packageName.toString(), "usageTimeInMinutes" to stats.totalTimeInForeground / (1000 * 60))
                        appUsageList.add(appUsage)
                    }

                }
            }
        }

        return appUsageList

    }

}
