def transform(event):
   # Get the status field from your Postgres data
   status = event.properties.get('status')
   if status:
       # This adds a new column inside that table to show the specific event
       event.properties['transformed_event'] = 'order_' + status.lower()
   return event


def transform(event):
   email = event.properties.get('email')
   if email:
       event.properties['username'] = email.split('@')[0]
   return event
