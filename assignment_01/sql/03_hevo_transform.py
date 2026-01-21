def transform(event):
   # Get the status field from your Postgres data
   status = event.properties.get('status')
   if status:
       # This adds a new column inside that table to show the specific event
       event.properties['transformed_event'] = 'order_' + status.lower()
   return event
