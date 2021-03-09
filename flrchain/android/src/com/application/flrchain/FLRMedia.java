package com.application.flrchain;

import android.provider.MediaStore;
import android.content.Intent;
import java.util.Date;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import android.net.Uri;
import android.database.Cursor;
import android.content.Context;
import java.io.File;
import android.support.v4.content.FileProvider;

public class FLRMedia {

    static final int NOT_DEFINED = -1;
    static final int PHOTO = 0;

    static final int CAPTURE_PHOTO_ACTIVITY_RESULT = 1;

    FLRActivity activity;
    String mCurrentPhotoPath;
    int mLastPhotoId = 0;

    public FLRMedia(FLRActivity act) {
        activity = act;
        mCurrentPhotoPath = null;
    }

    private int getLastImageId() {
        final String[] imageColumns = {
            MediaStore.Images.Media._ID
        };
        final String imageOrderBy = MediaStore.Images.Media._ID + " DESC";
        final String imageWhere = null;
        final String[] imageArguments = null;

        Cursor imageCursor = activity.getApplicationContext().getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, imageColumns, imageWhere, imageArguments, imageOrderBy);
        if (imageCursor.moveToFirst()) {
            int id = imageCursor.getInt(imageCursor.getColumnIndex(MediaStore.Images.Media._ID));
            imageCursor.close();
            return id;
        } else {
            return 0;
        }
    }

    public void capturePhoto() {
        mCurrentPhotoPath = null;
        Intent capture = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

        if (capture.resolveActivity(activity.getPackageManager()) != null) {
            // Create the File where the photo should go
            File photoFile = null;
            try {
                photoFile = createImageFile();
            } catch (IOException ex) {
                // Error occurred while creating the File
                System.out.println(ex.getMessage());
            }
            // Non-Galaxy androids require extra item as photo path;
            if (photoFile != null) {
                capture.putExtra(MediaStore.EXTRA_OUTPUT, FileProvider.getUriForFile(activity.getApplicationContext(), "com.application.flrchain.fileprovider", photoFile));
            }
            mLastPhotoId = this.getLastImageId();
            activity.startActivityForResult(capture, CAPTURE_PHOTO_ACTIVITY_RESULT);
        }
    }

    private File createImageFile() throws IOException {
        // Create an image file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "JPEG_" + timeStamp + "_";
        File storageDir = new File(activity.getFilesDir(), "photos/");
        File image = File.createTempFile(
            imageFileName, /* prefix */
            ".jpg", /* suffix */
            storageDir /* directory */
        );
        mCurrentPhotoPath = image.getAbsolutePath();
        return image;
    }

    public void checkResult(int requestCode, int resultCode, Intent data) {
        //Support for Galaxy series
        if (mCurrentPhotoPath == null) {
            Uri photoUri = data.getData();
            mCurrentPhotoPath = getRealPathFromURI(photoUri);
        } else if (mLastPhotoId < this.getLastImageId()) {
            activity.getApplicationContext().getContentResolver().delete(
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                MediaStore.Images.Media._ID + "=?",
                new String[] {
                    Long.toString(this.getLastImageId())
                });
        }

        captureCallback(mCurrentPhotoPath);
    }

    public String getRealPathFromURI(Uri contentUri) {
        if (contentUri == null)
            return "";
        String res = null;
        String[] proj = {
            MediaStore.Images.Media.DATA
        };
        Cursor cursor = activity.getApplicationContext().getContentResolver().query(contentUri, proj, null, null, null);
        if (cursor.moveToFirst()) {
            int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
            res = cursor.getString(column_index);
        }
        cursor.close();
        return res;
    }

    // Native Callbacks
    public static native void captureCallback(String path);
}
