package com.example.nefs;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;
import android.widget.Toast;

public class EventsFragment extends ListFragment {

	public static final String TAG = EventsFragment.class.getSimpleName();
	protected final String Url = "http://pastebin.com/raw.php?i=xb5m0mVX";
	private final String font = "fonts/Roboto_Thin.tff";
	private final String KEY_TITLE = "eTitle", KEY_TYPE = "eType",
			KEY_MONTH = "eMonth",KEY_TIME = "eTime", KEY_DESCRIPTION = "eDesc",KEY_DAY = "eDay";

	private final String MONTH_JAN = "January", MONTH_FEB = "Febuary",
			MONTH_MARCH = "March", MONTH_APRL = "April", MONTH_MAY = "May",
			MONTH_JUN = "June", MONTH_JULY = "July", MONTH_AUG = "August",
			MONTH_SEP = "September", MONTH_OCT = "October",
			MONTH_NOV = "November", MONTH_DEC = "December";

	protected JSONObject mEventsData;
	protected ProgressBar mProgresBar;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater.inflate(R.layout.fragment_events, container,
				false);

		return rootView;
	}

	@Override
	public void onResume() {
		super.onResume();

		retrieveMessages();
	}

	public void retrieveMessages() {

		if (isNetworkAvailable()) {

			GetMessagesTask getMessagesTask = new GetMessagesTask();
			getMessagesTask.execute();
		} else {
			Toast.makeText(this.getActivity(), "Network is unavailable!",
					Toast.LENGTH_LONG).show();
		}

	}

	private void logException(Exception e) {
		Log.e(TAG, "Exception caught!", e);
	}

	private boolean isNetworkAvailable() {
		ConnectivityManager manager = (ConnectivityManager) this.getActivity()
				.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo networkInfo = manager.getActiveNetworkInfo();

		boolean isAvailable = false;
		if (networkInfo != null && networkInfo.isConnected()) {
			isAvailable = true;
		}

		return isAvailable;
	}

	public void handleEventsResponse() {

		if (mEventsData == null) {
			Log.e(TAG, "no data");
		} else {
			try {

				JSONArray jsonEvents = mEventsData.getJSONArray("Events");

				String[] keys = { KEY_TITLE, KEY_MONTH, KEY_DAY, KEY_TIME};
				
				int[] ids = { R.id.EventTitleLabel, R.id.monthLabel,R.id.dayLabel,R.id.eventTimeLabel};

				if (getListView().getAdapter() == null) {
					EventAdapter adapter = new EventAdapter(
							getListView().getContext(), 
							jsonEvents,R.layout.event_item2,keys,ids,font);
					setListAdapter(adapter);
				}
				
			} catch (JSONException e) {
				logException(e);
			}
		}
	}

	protected String getMonth(int position) {

		switch (position) {

		case 0:
			return MONTH_JAN;
		case 1:
			return MONTH_FEB;
		case 2:
			return MONTH_MARCH;
		case 3:
			return MONTH_APRL;
		case 4:
			return MONTH_MAY;
		case 5:
			return MONTH_JUN;
		case 6:
			return MONTH_JULY;
		case 7:
			return MONTH_AUG;
		case 8:
			return MONTH_SEP;
		case 9:
			return MONTH_OCT;
		case 10:
			return MONTH_NOV;
		case 11:
			return MONTH_DEC;

		}
		return null;
	}

	private class GetMessagesTask extends AsyncTask<Object, Void, JSONObject> {

		protected JSONObject doInBackground(Object... arg0) {
			int responseCode = -1;
			JSONObject jsonResponse = null;

			try {
				URL nefsUrl = new URL(
						"http://pastebin.com/raw.php?i=uA9wba73");
				HttpURLConnection connection = (HttpURLConnection) nefsUrl
						.openConnection();
				connection.connect();

				responseCode = connection.getResponseCode();
				if (responseCode == HttpURLConnection.HTTP_OK) {
					InputStream inputStream = connection.getInputStream();
					Reader reader = new InputStreamReader(inputStream);

					String responseData = "";
					int nextCharacter;

					while (true) {

						nextCharacter = reader.read();

						if (nextCharacter == -1) {
							break;
						}

						responseData += (char) nextCharacter;
					}
					
				
					jsonResponse = new JSONObject(responseData);
				} else {
					Log.i(TAG, "Unsuccessful HTTP Response Code: "
							+ responseCode);
				}
			} catch (MalformedURLException e) {
				logException(e);
			} catch (IOException e) {
				logException(e);
			} catch (Exception e) {
				logException(e);
			}

			return jsonResponse;
		}

		@Override
		protected void onPostExecute(JSONObject result) {
			mEventsData = result;
			handleEventsResponse();
		}

	}

}
