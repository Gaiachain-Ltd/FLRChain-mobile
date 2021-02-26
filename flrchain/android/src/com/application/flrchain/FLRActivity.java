package com.application.flrchain;

import android.Manifest;
import android.content.Intent;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import android.net.Uri;
import android.database.Cursor;
import android.content.Context;
import java.io.File;
import android.provider.MediaStore;
import java.util.Date;
import android.support.v4.content.FileProvider;
import android.content.pm.PackageManager;
import android.support.v4.content.ContextCompat;
import android.support.v4.app.ActivityCompat;
import java.util.ArrayList;

public class FLRActivity extends org.qtproject.qt5.android.bindings.QtActivity {

    static final int FILE_SELECT_RESULT_CODE = 3;

    static final int REQUEST_PERMISSION_CAMERA = 1;
    static final int REQUEST_PERMISSION_READ_STORAGE = 2;
    static final int REQUEST_PERMISSION_WRITE_STORAGE = 3;
    static final int REQUEST_PERMISSION_CAMERA_READ = 4;

    private FLRMedia capture = new FLRMedia(this);

    private String mimeTypeFilterToApply = "*/*";

    private int startedActivity = 0;

    public FLRActivity() {} 

 @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        System.out.println("RESULT " + requestCode + " / " + resultCode);

        if ( requestCode == FLRMedia.CAPTURE_PHOTO_ACTIVITY_RESULT) {

            if (resultCode == RESULT_OK) {
                capture.checkResult(requestCode, resultCode, data);
            } else {
                activityClosedCallback();
            }

        } else if (requestCode == FILE_SELECT_RESULT_CODE) {

            System.out.println("Result code: " + resultCode);

            if (resultCode != RESULT_OK) {
                activityClosedCallback();
                return;
            }

            if (data == null) {
                System.out.println("intent is null!");
                activityClosedCallback();
                return;
            }

            Uri contentUri = null;
            contentUri = data.getData();

            if (contentUri == null) {
                System.out.println("content uri is empty!");
                activityClosedCallback();
                return;
            }

            System.out.println(contentUri.toString());

            switch (requestCode) {

                case FILE_SELECT_RESULT_CODE:
                    fileSelectionCallback(contentUri.toString());
                    break;

                default:
                    activityClosedCallback();
                    break;
            }

        }

        startedActivity = 0;
    }

 @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {

        if (grantResults.length == 0) {
            activityClosedCallback();
            return;
        }

        for (int i = 0; i < grantResults.length; ++i) {
            if (PackageManager.PERMISSION_DENIED == grantResults[i]) {
                activityClosedCallback();
                return;
            }
        }

        switch (requestCode) {
            case REQUEST_PERMISSION_CAMERA:
                capture();
                break;

            case REQUEST_PERMISSION_READ_STORAGE:
                importFile(mimeTypeFilterToApply);
                break;

            case REQUEST_PERMISSION_CAMERA_READ:
                activityClosedCallback();
                break;
        }
    }

    public void capture() {
        boolean cameraPermissionGranted = (PackageManager.PERMISSION_GRANTED == ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA));
        boolean storagePermissionGranted = (PackageManager.PERMISSION_GRANTED == ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE));

        if (cameraPermissionGranted && storagePermissionGranted) {
            captureMedia();
        } else {

            ArrayList<String> permissions = new ArrayList<String>();

            if ( false == cameraPermissionGranted ) {
                permissions.add(Manifest.permission.CAMERA);
            }

            if ( false == storagePermissionGranted ) {
                permissions.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
            }

            ActivityCompat.requestPermissions(this, permissions.toArray(new String[permissions.size()]), REQUEST_PERMISSION_CAMERA);
        }
    }

    public void importFile(String mimeTypeFilter) {
        if (PackageManager.PERMISSION_GRANTED == ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE)) {
            showFileDialog(mimeTypeFilter);
        } else {
            mimeTypeFilterToApply = mimeTypeFilter;

            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE},
                    REQUEST_PERMISSION_READ_STORAGE);
        }
    }

    public boolean hasCameraPermission() {
        return (PackageManager.PERMISSION_GRANTED == ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA));
    }

    public void requestCameraPermission() {
        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.CAMERA},
                REQUEST_PERMISSION_CAMERA_READ);
    }



public String getImagePath(Uri uri){
   Cursor cursor = getContentResolver().query(uri, null, null, null, null);
   cursor.moveToFirst();
   String document_id = cursor.getString(0);
   document_id = document_id.substring(document_id.lastIndexOf(":")+1);
   cursor.close();

   cursor = getContentResolver().query( 
   android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
   null, MediaStore.Images.Media._ID + " = ? ", new String[]{document_id}, null);
   cursor.moveToFirst();
   String path = cursor.getString(cursor.getColumnIndex(MediaStore.Images.Media.DATA));
   cursor.close();

   return path;
}

    //=================//
    // PRIVATE METHODS //
    //=================//

    private void captureMedia(){
        capture.capturePhoto();
    }

    private void showFileDialog(String mimeTypeFilter) {

        Intent intent = new Intent();
        intent.setType(mimeTypeFilter);
        intent.setAction(Intent.ACTION_GET_CONTENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_WRITE_URI_PERMISSION);

        startedActivity = FILE_SELECT_RESULT_CODE;

        startActivityForResult(intent, FILE_SELECT_RESULT_CODE);

        mimeTypeFilterToApply = "*/*";
    }

    // Native Callbacks
    public native void activityClosedCallback();
    public static native void fileSelectionCallback(String path);
    public native void backButtonCallback();
}
