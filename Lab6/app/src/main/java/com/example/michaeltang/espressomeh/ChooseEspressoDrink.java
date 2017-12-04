package com.example.michaeltang.espressomeh;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.TextView;

/**
 * Created by michaeltang on 12/3/17.
 */

public class ChooseEspressoDrink extends AppCompatActivity{

    private Espresso drink = new Espresso();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.choose_espresso_drink);

        //get intent
        Intent intent = getIntent();
        //get button
        final Button button = (Button) findViewById(R.id.button);
        //create listener
        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){
                sendBackInfo(view);
            }
        };
        //add listener to the button
        button.setOnClickListener(onclick);

    }

    public void sendBackInfo(View view){
        //get spinner
        Spinner drinkChoice = (Spinner)findViewById(R.id.spinner);
        //get spinner item array position
        int drinkID = drinkChoice.getSelectedItemPosition();
        drink.createEspressoDrink(drinkID);
        //Get back espresso info
        int espressoImageName = drink.getEspressoImage();
        String drinkDescription = drink.getDescription();

        //create an Intent
        Intent intentBack = new Intent(this, MainActivity.class);

        //pass data
        intentBack.putExtra("ImageName", espressoImageName);
        intentBack.putExtra("Description", drinkDescription);

        //start intent
        startActivity(intentBack);
    }

    public void googleCoffee(View view){
        Spinner drinkChoice = (Spinner)findViewById(R.id.spinner);
        //get spinner item array position
        int drinkID = drinkChoice.getSelectedItemPosition();
        Intent intent = new Intent(Intent.ACTION_VIEW);
        //intent.setData(Uri.parse(coffeeShopURL));
        switch (drinkID){
            case 0:
                intent.setData(Uri.parse("https://en.wikipedia.org/wiki/Espresso"));
                break;
            case 1:
                intent.setData(Uri.parse("https://en.wikipedia.org/wiki/Macchiato"));
                break;
            case 2:
                intent.setData(Uri.parse("https://en.wikipedia.org/wiki/Cappuccino"));
                break;
            case 3:
                intent.setData(Uri.parse("https://en.wikipedia.org/wiki/Americano"));
                break;
            case 4:
                intent.setData(Uri.parse("https://en.wikipedia.org/wiki/Latte"));
                break;
            case 5:
                intent.setData(Uri.parse("https://en.wikipedia.org/wiki/Frappuccino"));
                break;
        }
        startActivity(intent);
    }
}
