package com.example.nefs;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.graphics.Typeface;
import android.text.Html;
import android.util.Log;
import android.widget.SimpleAdapter;

import com.google.gson.JsonArray;

public class EventAdapter extends SimpleAdapter {

	protected static final String KEY_TITLE = "eTitle", KEY_TYPE = "eType",
			KEY_MONTH = "eMonth", KEY_TIME = "eTime",
			KEY_DESCRIPTION = "eDesc", KEY_DAY = "eDay", KEY_DATE = "eDate";
	protected static final String TAG = EventAdapter.class.getSimpleName(); 

	protected Context mContext;
	protected static List<HashMap<String, String>> mEvents;
	protected JsonArray JSONEvents;
	protected Typeface tf;

	public EventAdapter(Context context, JSONArray events,int resource, String[] from, int[] to,String font) {
		super(context, getList(events), resource, from, to);
		
		//tf = Typeface.createFromAsset(context.getAssets(), font);
		
	
		mContext = context;
		

	}

	protected static List<HashMap<String, String>> getList(JSONArray jEvents) {

		JSONArray jsonEvents = jEvents;

		mEvents = new ArrayList<HashMap<String, String>>();
		
		Locale l = Locale.getDefault();

		for (int i = 0; i < jsonEvents.length(); i++) {

			try {

				JSONObject event = jsonEvents.getJSONObject(i);
				
				String title = event.getString(KEY_TITLE);
				title = Html.fromHtml(title).toString();
				

				String fullDate = event.getString(KEY_DATE);
				fullDate = Html.fromHtml(fullDate).toString();

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm",l);
				Date date = sdf.parse(fullDate);
				
				String month = (String) android.text.format.DateFormat.format("MMM", date);
				
				String day =  (String) android.text.format.DateFormat.format("dd", date);

				String hour = (String) android.text.format.DateFormat.format("kk", date);
				
				String mins = (String) android.text.format.DateFormat.format("mm", date);

				String time = hour + ":" + mins;

				String type = event.getString("eEvent");
				type = Html.fromHtml(type).toString();

				HashMap<String, String> eventPost = new HashMap<String, String>();
				eventPost.put(KEY_TITLE, title);
				eventPost.put(KEY_MONTH, month);
				eventPost.put(KEY_TIME, time);
				eventPost.put(KEY_TYPE, type);
				eventPost.put(KEY_DAY, day);

				mEvents.add(eventPost);
				
				

			} catch (JSONException e) {
				Log.e(TAG, "Exception caught!", e);
			} catch (ParseException e) {
				
				Log.e(TAG, "Exception caught!", e);
			}
		}
		
		return mEvents;

	}

//	@Override
//	public View getView(int position, View convertView, ViewGroup parent) {
//		ViewHolder holder;
//
//		convertView = LayoutInflater.from(mContext).inflate(
//				R.layout.event_item, null);
//
//		if (convertView == null) {
//			holder = new ViewHolder();
//			holder.eventMonth = (TextView) convertView
//					.findViewById(R.id.monthLabel);
//			holder.eventDay = (TextView) convertView
//					.findViewById(R.id.dayLabel);
//			holder.eventTime = (TextView) convertView
//					.findViewById(R.id.eventTimeLabel);
//			holder.eventStatus = (TextView) convertView
//					.findViewById(R.id.eventStatus);
//
//		}
//
//		else {
//			holder = (ViewHolder) convertView.getTag();
//		}
//
//		JsonObject event = (JsonObject) JSONEvents.get(position);
//		holder.eventMonth = event.
//		
//		return convertView;
//	}
//
//	private static class ViewHolder {
//		TextView eventMonth;
//		TextView eventDay;
//		TextView eventTitle;
//		TextView eventTime;
//		TextView eventStatus;
//
//	}
	
	public void refill(List<HashMap<String, String>> events) {
		mEvents.clear();
		mEvents.addAll(events);
		notifyDataSetChanged();
	}

}
