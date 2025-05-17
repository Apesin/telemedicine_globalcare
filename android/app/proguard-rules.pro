# Keep Google Billing API
-keep class com.android.billingclient.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.google.api.client.http.** { *; }
-keep class com.google.zxing.** { *; }

 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.** { *; }
 -keep class io.flutter.util.** { *; }
 -keep class io.flutter.view.** { *; }
 -keep class io.flutter.** { *; }
 -keep class io.flutter.plugins.** { *; }
 -keep class com.google.firebase.** { *; }
 -dontwarn io.flutter.embedding.**
 -ignorewarnings
 -keep class androidx.webkit.** { *; }

# Keep Zoom SDK if applicable
-keep class us.zoom.proguard.** { *; }


# Ensure reflection works properly
-keepattributes *Annotation*
-keepclassmembers class * {
    @Keep *;
}
