package com.example.cygiene_ui;
import  android.content.Context;

import android.bluetooth.BluetoothAdapter;
import android.content.Intent;
import android.nfc.NfcAdapter;
import androidx.annotation.NonNull;
import android.location.LocationManager;
import android.os.Build;
import android.provider.Settings;

import androidx.core.location.LocationManagerCompat;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    public static final String BLUETOOTH_CHANNEL = "samples.flutter.dev/bluetooth";
    public static final String GPS_CHANNEL = "samples.flutter.dev/gps";
    public static final String NFC_CHANNEL = "samples.flutter.dev/nfc";


    // @Override
    // public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    //     super.configureFlutterEngine(flutterEngine);
    //     new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), BLUETOOTH_CHANNEL)
    //             .setMethodCallHandler(
    //                     (call, result) ->{

    //                         if (call.method.equals("getBluetoothStatus")) {
    //                         java.lang.Boolean bluetoothStatus = getBluetoothStatus();
    //                         result.success(bluetoothStatus);
    //                             result.notImplemented();
    //                             return;

    //                         }}
    //             );
    // }
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger() , NFC_CHANNEL)
        .setMethodCallHandler(
                (call, result) -> {

                    if (call.method.equals("getNfcStatus")) {
                        Boolean nfc_status = getNfcStatus();
                        result.success(nfc_status);

                        result.notImplemented();
                        return;
                    }
                }
        );
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger() , GPS_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {

                            if (call.method.equals("getGpsStatus")) {
                                Boolean gps_enabled = getGpsStatus();
                                result.success(gps_enabled);

                                result.notImplemented();
                                return;


                            }



                        }
                );



        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), BLUETOOTH_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {

                            if (call.method.equals("getBluetoothStatus")) {
                                Boolean bluetoothStatus = getBluetoothStatus();
                                result.success(bluetoothStatus);

                                result.notImplemented();
return;

                            }


                        }
                );
    }







    //Bluetooth Status
    public boolean getBluetoothStatus() {
        boolean bluetoothStatus = false;

        BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (mBluetoothAdapter == null) {
            // Device does not support Bluetooth
        } else if (!mBluetoothAdapter.isEnabled()) {
            System.out.println("bluetooth is currently off");
            // Bluetooth is not enabled :)
        } else {
            System.out.println("bluetooth is on by users");
            bluetoothStatus = true;
        }

        return bluetoothStatus;
    }

//Gps status
     public boolean getGpsStatus() {
         LocationManager lm = (LocationManager)
                 getSystemService(Context.LOCATION_SERVICE);
         boolean gps_enabled = false;
         // System.out.println("gps is enabled" + gps_enabled);

         try {
             gps_enabled = lm.isProviderEnabled(LocationManager.GPS_PROVIDER);
             System.out.println("gps is enabled" + gps_enabled);
         } catch (Exception e) {
             e.printStackTrace();
         }
         return gps_enabled;
     }

//NFC status
 public boolean getNfcStatus(){
     boolean nfcStatus = false;

     NfcAdapter nfcAdapter = NfcAdapter.getDefaultAdapter(this);

     if (nfcAdapter == null) {
         // NFC is not available for device
     } else if (!nfcAdapter.isEnabled()) {
         System.out.println("NFC is currently off");
         // NFC is available for device but not enabled
     } else {
         System.out.println("NFC is on by users");
         nfcStatus = true;
     }
     return nfcStatus;
 }}

//System Update








