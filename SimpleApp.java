import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class SimpleApp extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        TextView tv = new TextView(this);
        tv.setText("Hello Galaxy S25!");
        setContentView(tv);
    }
}