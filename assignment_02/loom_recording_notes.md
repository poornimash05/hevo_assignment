Url for loom recording: https://www.loom.com/share/84de9de8398843b695c9503ac24468eb


00:00 So, hello, my name is Poornima Sharma. In this video, I'll demonstrate how I cleaned and modelled a raw data in Snowflake.
00:12 Using views to ensure real-time usage and, uh, analytic ready data. So, before that, I wanted to just show the raw tables that we have.
00:25 So, this one is the first raw table. It is customer raw table. So, if you can see, there are, uh, null values inserted in front phone number.
00:33 Created date is null. Updated is. So, we'll handle all these edge cases. Then, similarly, I can show for, for order data.
00:43 So, here also we can see that our product ID is null. There are, uh, duplications in all those tables. Then, we have product raw table.
00:57 So, here also, uh, this is product raw table that we have. And the fourth one is country dim table. So, this one also have ISO, code null, all the country name is unknown.
01:12 These, all the edge cases we are handling here. So, what my task is, first one is deduplicate customers. So, what I have to do here is, keep only the most recent record for each customer ID.
01:28 Then, I have to standardize emails to lowercase. The next one is standardizing phone number into 10-digit format or marking them as invalid.
01:39 So, this is the query that I have been using here. So, what I am doing is, I am deduplicating customer ID.
01:45 Customer using raw number and keeping the most recent record of the customer and also emails are converted to lowercase and phone numbers are marked as invalid in this and country values are also standardized.
02:01 So, let me execute this query. So, as we can see, customers are my clean table view has been created. Now, just let us view that.
02:17 So, okay. So, if we. We can see here what we have handled is that there is no duplicacy in the customer ID.
02:24 All the customer IDs are unique and all the email address have been standardized. And the phone number which are unknown, they have been placed as unknown.
02:35 And the number is converted into 10-digit format. So this task has been completed for deduplicating customer. Next one is fixing null, uh, and country issues.
02:48 So what we have to do is, we have to standardize country issues. Country code values using country dim table, and then we have to handle variations such as, uh, for different countries we have been using here.
03:01 You can see, you know, not using code, somewhere we are using code and other we are using names. We have to fix this.
03:06 Then the next one, created date should not, uh, created at should not be null. They should be replaced by this timestamp.
03:13 As you can see here it is null, here it is null. This will get fixed after that. So in this customer clean, uh, final table, uh, we are just, uh, standardizing the output.
03:25 And we are keeping the, uh, missing timestamp default to this one what is asked. So let us execute. So it has been created.
03:40 I gave the name customer clean final. Now let's view it. So here we can see that, uh, the country codes have been placed as, as the country code from the country.
03:53 Dim table that I have done here from the country Dim table. We have standardized them and then, uh, created at, uh, where it is.
04:01 I have placed the default value that was asked. It is nineteen hundred zero one zero one. So now we are good with this.
04:09 Now, next one is cleaning orders. So in cleaning orders, in order table, what we have to do is we have to remove exact duplicate rows.
04:17 Then to, ah, suppose if there is negative, we have to replace it by zero. If it is null, we have to replace by reasonable fallback that is asked as median of customer transaction.
04:32 we have to standardize. Customer, ah, standardized currency code to uppercase, all the currency codes are standardized to uppercase. Then we have to create a derived column, ah, of amount USD by converting all amounts into USD.
04:45 using their predefined conversion rule. So, in this, ah, orders are cleaned by removing duplicate and fixing invalid amounts. So, what I, ah, did is, with all the currency are converted in this query to their, ah, standardized currency.
05:02 Let me execute this query. Let's create order screen table, so it has been, the view has been created. Then, let's view that view.
05:27 So, if we can see here, what is, exact duplicate rows have been removed. So we are we are not having any duplicate rows, then, ah, the next one is, the amount that is negative or zero, those are negative, are replaced by zero.
05:43 So, if we can see, we are seeing zero, zero. So there must have been negative amount, that's why it has been released.
05:49 And we have kept, ah, null to the amount which are unknown. And then, ah, we have standardized currency code to upper case.
05:57 Here, we can see the currency codes are standardized to upper case. And then we have created amount, USD calling with their conversion rate.
06:03 If we can see the conversion rates. From this amount, we have converted it. So, by this clean order table has been, I have created and completed this task.
06:15 Then the next task is. products. Now, we have to clean the products table. What we have to do is, we have to standardize product name.
06:24 Like, we have to capitalize them properly. Then, we have to standardize category names. Like, in case, we standardize that. The proper capitalization is there.
06:34 And, inactive products are, uh, marked as discontinued products. So, let me execute the query for that. All right. The name I gave is Product Clean.
06:51 Let's view my product's clean table. So, if we can see for product the correct status. This has been mounted as discontinued product and then currencies are, this has been mounted as a discontinued product.
07:07 And in this, if we can see product name are capitalized, if the first uh, uh, letters have been capitalized and the category name.
07:18 These are all showing title cases. So, if it's keyboard, then it comes under hard cable hardware, mouse and hardware, premium cable under it.
07:26 Now, my last task is, ah, to add on these. is to task together. So what is being done is, we have to produce a unified data set by joining customer order and product table.
07:42 Then what we have to do is customer ID that does not exist in clean. A marked as, uhh, marked as, uhh, does not exist in the marked email as orphaned customer.
07:54 What? And if product ID is missing, then we can mark this as, uhh, unknown product. And we have also hindered edge cases here, like the customer will completely record should be invalid customer.
08:06 And order referring non-existing customer or product should still appear in 500 database with appropriate placeholders. And then- mixed currency handling should be consistent across all rows.
08:18 So, I've used this query for that. All right. So, my final data set has been created. Now, let's move it.
08:30 So, here the paper has been merged. So, what we can see here is, first one, product unified data set, joining customer order and product, which is the customer orders and product.
08:42 If the been merged, then the customer ID that does not exist in clean customer is marked as orphaned customer. If we can see.
08:50 It's really an orphaned customer, yeah. We can see that these product IDs are not being uhh, these customer IDs are not being visible in uhh, the- Cleaned customer tables, so we have marked it as orphaned customers in their email.
09:06 Then, for product ID, uhh, which are missing or invalid, we have kept it as unknown product. Suppose there it is.
09:14 It is null, here it is null, we have kept, this one is also not uhh, available, so we have kept it as unknown product.
09:20 Then, h cases like uhh, customer will completely null record. So, we can see there is uhh, for now there is no question.
09:31 So, we are all able to see. Here, uhh, it is for country courts. So, we are not able to see that it is not as invalid, but if we have, then if the month is invalid, because we have handled this case overall.
09:42 Then next one is, you know. Order every non-distagram should say, I'm appear in a pineapple, a placeholder, yeah. This has been done.
09:50 Mixed currency handling should be consistent across all rows. So, currency handling has been done here. If we can see this is being done, the created date and data has been consistent.
10:03 So, we have rendered all the edge cases, since we are good with it. This task. Uhh, thank you very much.
10:09 So, one thing that I wanted to, uh, let's hear is that I have read all the transformations and implemented all things using views, not tables.
10:18 This is done to ensure that the data set automatically refreshes whenever new data arrives, uh, without any manual reprocessing from EBO.
10:28 So, that is why I did this. And this completes the end-to-end data cleaning and modeling workflow. So, thank you for watching.
10:35 Thank you.


