package com.example.michaeltang.espressomeh;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private int imageName;
    private String description;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //See if an intent was given
        Intent intent = getIntent();
        if(intent.getExtras() != null){
            //Set image and description
            imageName = intent.getIntExtra("ImageName",0);
            description = intent.getStringExtra("Description");
            setView();
        }

        //Research button
        final Button research = (Button) findViewById(R.id.research);
        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){
                startResearching(view);
            }
        };
        research.setOnClickListener(onclick);
    }

    public void startResearching(View view){
        //create an intent
        Intent intent = new Intent(this, ChooseEspressoDrink.class);
        //start intent plz don't crash
        startActivity(intent);

    }

    public void setView(){
        TextView desc = (TextView) findViewById(R.id.textView3);
        desc.setText(description);

        ImageView coffeeImage = (ImageView) findViewById(R.id.imageView);
        switch (imageName){
            case 0:
                coffeeImage.setImageResource(R.drawable.espresso);
                break;
            case 1:
                coffeeImage.setImageResource(R.drawable.macchiato);
                break;
            case 2:
                coffeeImage.setImageResource(R.drawable.cappuccino);
                break;
            case 3:
                coffeeImage.setImageResource(R.drawable.americano);
                break;
            case 4:
                coffeeImage.setImageResource(R.drawable.latte);
                break;
            case 5:
                coffeeImage.setImageResource(R.drawable.frap);
                break;
        }
    }
}
