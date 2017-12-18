package com.example.michaeltang.burritobuilder;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.*;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    //Build food item
    public void build(View view){
        propagateRadioChoice();
    }

    private void propagateRadioChoice(){
        RadioButton burrito = (RadioButton) findViewById(R.id.radioButton2);
        RadioButton taco = (RadioButton) findViewById(R.id.radioButton4);

        if(burrito.isChecked()){
            setImage(1);
            setDescription(1);
        }else if(taco.isChecked()){
            setImage(2);
            setDescription(2);
        }else{
            //No radio buttons checked
        }
    }
    private void setImage(int val){
        ImageView i = (ImageView) findViewById(R.id.imageView);
        i.setVisibility(View.VISIBLE);
        if(val == 1){
            i.setImageResource(R.drawable.burrito);
        }else if(val == 2){
            i.setImageResource(R.drawable.taco);
        }
    }
    //Set text description
    private void setDescription(int i){
        TextView t = (TextView) findViewById(R.id.textView2);
        EditText e = findViewById(R.id.editText);

        String name = e.getText().toString();
        String item = "";

        ToggleButton tb = findViewById(R.id.toggleButton);
        String type = tb.getText().toString();
        String gluten = "";
        if(i == 1){
            item = "burrito";
            Switch s = findViewById(R.id.switch2);
            if(s.isChecked()){
                gluten = " on a gluten-free tortilla ";
            }
        }else if(i == 2){
            item = "taco";
        }

        CheckBox salsa = findViewById(R.id.checkBox);
        CheckBox cheese = findViewById(R.id.checkBox2);
        CheckBox sourCream = findViewById(R.id.checkBox3);
        CheckBox guac = findViewById(R.id.checkBox4);

        String salasString = salsa.isChecked() ? "salsa " : "";
        String cheeseString = cheese.isChecked() ? "cheese " : "";
        String sourCreamString = sourCream.isChecked() ? "sour cream " : "";
        String guacString = guac.isChecked() ? "guacamole " : "";

        Spinner s = findViewById(R.id.spinner3);
        String loc = s.getSelectedItem().toString();
        String with = !( salsa.isSelected() || cheese.isSelected() || sourCream.isSelected() || guac.isSelected()) ? " " : " with ";
        String message = "The "+name+" is a "+item+" with "+type+with+salasString+cheeseString+sourCreamString+guacString+gluten+"you'd like to eat on "+loc+".";
        t.setText(message);
    }
}
