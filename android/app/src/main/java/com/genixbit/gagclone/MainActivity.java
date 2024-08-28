package com.genixbit.gagclone;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
//    private static final String CHANNEL = "com.example.notification";
//    private static final String NOTIFICATION_CHANNEL_ID = "10001";
//
//    @Override
//    public void configureFlutterEngine(FlutterEngine flutterEngine) {
//        super.configureFlutterEngine(flutterEngine);
//
//        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                .setMethodCallHandler(
//                        (call, result) -> {
//                            if (call.method.equals("showNotification")) {
//                                String title = call.argument("title");
//                                String content = call.argument("content");
//                                showNotification(title, content);
//                                result.success(null);
//                            } else {
//                                result.notImplemented();
//                            }
//                        }
//                );
//    }
//
//    private void showNotification(String title, String content) {
//        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            NotificationChannel notificationChannel = new NotificationChannel(NOTIFICATION_CHANNEL_ID,
//                    "NOTIFICATION_CHANNEL_NAME", NotificationManager.IMPORTANCE_HIGH);
//            notificationManager.createNotificationChannel(notificationChannel);
//        }
//
//        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
//                .setSmallIcon(R.drawable.ic_notification)
//                .setContentTitle(title)
//                .setContentText(content)
//                .setAutoCancel(true);
//
//        Intent resultIntent = new Intent(this, MainActivity.class);
//        TaskStackBuilder stackBuilder = TaskStackBuilder.create(this);
//        stackBuilder.addNextIntentWithParentStack(resultIntent);
//        PendingIntent resultPendingIntent = stackBuilder.getPendingIntent(0, PendingIntent.FLAG_UPDATE_CURRENT);
//        builder.setContentIntent(resultPendingIntent);
//
//        notificationManager.notify((int) System.currentTimeMillis(), builder.build());
//    }
}

