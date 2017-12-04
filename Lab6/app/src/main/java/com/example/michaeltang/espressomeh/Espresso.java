package com.example.michaeltang.espressomeh;

/**
 * Created by michaeltang on 12/3/17.
 */

public class Espresso {
    private int espressoImage;
    private String description;

    public void createEspressoDrink(int id){
        switch (id){
            case 0:
                espressoImage = 0;
                description = "A small drink made using an espresso machine by forcing hot water under pressure through fine-coffee grounds. It is the base for most coffee drinks.";
                break;
            case 1:
                espressoImage = 1;
                description = "A lighter version of espresso by having a touch of milk.";
                break;
            case 2:
                espressoImage = 2;
                description = "A cappuccino is composed of espresso, milk, and steamed-milk foam. The sweetness of the milk balances the bitterness of the espresso.";
                break;
            case 3:
                espressoImage = 3;
                description = "Known as American coffee, an Americano is an espresso diluted with hot water.";
                break;
            case 4:
                espressoImage = 4;
                description = "A latte is the combination of an espresso and steamed milk";
                break;
            case 5:
                espressoImage = 5;
                description = "Wanna be coffee";
                break;
            default:
                espressoImage = 6;
                description = "Not found!";
        }
    }

    public void setEspressoImage(int image){
        espressoImage = image;
    }
    public void setDescription(String message){
        description = message;
    }
    public int getEspressoImage(){
        return espressoImage;
    }
    public String getDescription(){
        return description;
    }
}
