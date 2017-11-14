package com.example.michaeltang.calculator;

import java.util.*;

import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.TextView;
import android.widget.Toast;
import android.content.Context;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    public void clear(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText("");
        //Show grumpy cat
        ImageView cat = (ImageView)findViewById(R.id.cat);
        cat.setVisibility(View.INVISIBLE);
    }
    public void dot(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+".");
    }
    public void plus(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"+");
    }
    public void minus(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"-");
    }
    public void times(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"*");
    }
    public void div(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"/");
    }
    public void b9(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"9");
    }
    public void b8(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"8");
    }
    public void b7(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"7");
    }
    public void b6(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"6");
    }
    public void b5(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"5");
    }
    public void b4(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"4");
    }
    public void b3(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"3");
    }
    public void b2(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"2");
    }
    public void b1(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"1");
    }
    public void b0(View view){
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();
        result.setText(current+"0");
    }

    public void equal(View view) {
        TextView result = (TextView)findViewById(R.id.calculateResult);
        String current = result.getText().toString();

        System.out.println(current);
        float calcResult = lex(current);

        result.setText(Float.toString(calcResult));
    }
    //Lexer to break up string into a list of lexems
    private float lex(String expr){
        //Parse the expression string into tokens
        List<String> lexems = new ArrayList<String>();
        int start = 0;
        for (int i = 0; i<expr.length(); i++){
            char lexem = expr.charAt(i);
            if(lexem == '+' || lexem == '-' || lexem == '*' || lexem == '/'){
                String item = expr.substring(start,i);
                if(!item.equals("")) {
                    lexems.add(item);
                }
                lexems.add(String.valueOf(lexem));
                start = i+1;
            }
        }
        lexems.add(expr.substring(start));
        System.out.println(lexems);
        float steppedExpr = union(lexems);
        curr = 0;
        return steppedExpr;
    }

    int curr = 0;
    //Functions to force order of operations: Recursive Descent Parser
    private float union(List<String> token){
        float lval = intersect(token);


        while(curr < token.size()-1 && (token.get(curr).equals("+") || token.get(curr).equals("-"))){
            String op = token.get(curr);
            curr++;
            float rval = intersect(token);

            if(op.equals("+")){
                lval = lval + rval;
            }else if(op.equals("-")){
                lval = lval - rval;
            }
        }
        return lval;
    }

    private float intersect(List<String> token){
        float lval = atom(token);

        while(curr < token.size()-1 && (token.get(curr).equals("*") || token.get(curr).equals("/"))){
            String op = token.get(curr);
            curr++;
            float rval = atom(token);

            if(op.equals("*")){
                lval = lval * rval;
            }else if(op.equals("/")){
                if(rval == 0){
                    //When you do the unspeakable
                    CharSequence text = "No dividing by zero! >:(";
                    Context context = this;
                    int duration = Toast.LENGTH_SHORT;

                    Toast toast = Toast.makeText(context, text, duration);
                    toast.show();

                    //Show grumpy cat
                    ImageView cat = (ImageView)findViewById(R.id.cat);
                    cat.setVisibility(View.VISIBLE);
                    return 0;
                }
                lval = lval / rval;
            }
        }
        return lval;
    }

    private float atom(List<String> token){
        if(token.size() == 0){
            return 0;
        }
        if(token.get(curr).equals("-")){
            curr++;
            float rtn = Float.parseFloat(token.get(curr));
            curr++;
            return -1*rtn;
        }
        float rtn = Float.parseFloat(token.get(curr));
        curr++;
        return rtn;
    }

    public void updateUI(View view){
        CheckBox blue = (CheckBox)findViewById(R.id.checkBox);
        CheckBox yellow = (CheckBox)findViewById(R.id.checkBox2);
        Button cr = (Button)findViewById(R.id.button27);
        if(blue.isChecked() && yellow.isChecked()){
            cr.setBackgroundColor(Color.GREEN);
            cr.setTextColor(Color.BLACK);
        }
        else if(blue.isChecked()){

            cr.setBackgroundColor(Color.BLUE);
            cr.setTextColor(Color.WHITE);
        }
        else if(yellow.isChecked()){
            cr.setBackgroundColor(Color.YELLOW);
            cr.setTextColor(Color.BLACK);
        }

        else if(!blue.isChecked() && !yellow.isChecked()){
            cr.setBackgroundColor(Color.RED);
            cr.setTextColor(Color.BLACK);
        }
    }

}
