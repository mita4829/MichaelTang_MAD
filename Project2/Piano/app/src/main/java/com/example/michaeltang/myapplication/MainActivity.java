package com.example.michaeltang.myapplication;

import android.media.MediaPlayer;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.*;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final MediaPlayer c = MediaPlayer.create(this, R.raw.c);
        ImageButton cKey = (ImageButton) findViewById(R.id.c);

        cKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                c.start();
            }
        });


        final MediaPlayer csharp = MediaPlayer.create(this, R.raw.csharp);
        ImageButton csharpKey = (ImageButton) findViewById(R.id.csharp);

        csharpKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                csharp.start();
            }
        });

        final MediaPlayer d = MediaPlayer.create(this, R.raw.d);
        ImageButton dKey = (ImageButton) findViewById(R.id.d);

        dKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                d.start();
            }
        });

        final MediaPlayer dsharp = MediaPlayer.create(this, R.raw.dsharp);
        ImageButton dsharpKey = (ImageButton) findViewById(R.id.dsharp);

        dsharpKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dsharp.start();
            }
        });

        final MediaPlayer e = MediaPlayer.create(this, R.raw.e);
        ImageButton eKey = (ImageButton) findViewById(R.id.e);

        eKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                e.start();
            }
        });

        final MediaPlayer f = MediaPlayer.create(this, R.raw.f);
        ImageButton fKey = (ImageButton) findViewById(R.id.f);

        fKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                f.start();
            }
        });

        final MediaPlayer fsharp = MediaPlayer.create(this, R.raw.fsharp);
        ImageButton fsharpKey = (ImageButton) findViewById(R.id.fsharp);

        fsharpKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                fsharp.start();
            }
        });

        final MediaPlayer g = MediaPlayer.create(this, R.raw.g);
        ImageButton gKey = (ImageButton) findViewById(R.id.g);

        gKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                g.start();
            }
        });

        final MediaPlayer gsharp = MediaPlayer.create(this, R.raw.gsharp);
        ImageButton gsharpKey = (ImageButton) findViewById(R.id.gsharp);

        gsharpKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gsharp.start();
            }
        });

        final MediaPlayer a = MediaPlayer.create(this, R.raw.a);
        ImageButton aKey = (ImageButton) findViewById(R.id.a);

        aKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                a.start();
            }
        });

        final MediaPlayer asharp = MediaPlayer.create(this, R.raw.asharp);
        ImageButton aKeysharp = (ImageButton) findViewById(R.id.asharp);

        aKeysharp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                asharp.start();
            }
        });

        final MediaPlayer b = MediaPlayer.create(this, R.raw.b);
        ImageButton bKey = (ImageButton) findViewById(R.id.b);

        bKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                b.start();
            }
        });

        final MediaPlayer cfour = MediaPlayer.create(this, R.raw.cfour);
        ImageButton cfourKey = (ImageButton) findViewById(R.id.c4);

        cfourKey.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                cfour.start();
            }
        });

    }
}
